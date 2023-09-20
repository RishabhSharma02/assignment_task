from flask import Flask, request, jsonify, redirect, url_for
from flask_pymongo import PyMongo
from bson.objectid import ObjectId
import os
import face_recognition
import cv2
from werkzeug.security import generate_password_hash, check_password_hash
import uuid
import logging
from werkzeug.exceptions import HTTPException
from skimage.feature import local_binary_pattern
import numpy as np
import hashlib
import re
import base64


logging.basicConfig(level=logging.INFO)

app = Flask(__name__)

# MongoDB configuration
app.config['MONGO_URI'] = os.getenv('MONGO_URI',
                                    'mongodb://localhost:27017/login')

# Initializing MongoDB
mongo = PyMongo(app)


@app.route('/')
def home():
    return "Welcome to the face recognition system."


@app.errorhandler(HTTPException)
def handle_exception(e):
    response = e.get_response()
    response.set_data(jsonify(success=False, message=str(e)).get_data())
    response.content_type = "application/json"
    return response, e.code


def texture_analysis_lbp(image):
    # Convert image to grayscale
    gray_image = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)

    # LBP computation
    radius = 1
    n_points = 8 * radius
    lbp = local_binary_pattern(gray_image, n_points, radius,
                               method="uniform")

    # Histogram analysis can be added if needed to make decisions
    # hist, _ = np.histogram(lbp.ravel(), bins=np.arange(0, n_points +3), range=(0, n_points + 2))

    # Assuming a threshold for LBP (This should be experimentallydetermined)
    lbp_threshold = 0.5
    if np.mean(lbp) < lbp_threshold:
        return False  # Texture likely from a photo
    return True


def detect_blink():
    total_frames = 20
    blink_detected = False

    camera = cv2.VideoCapture(0)
    frame_count = 0
    while frame_count < total_frames:
        ret, frame = camera.read()
        if not ret:
            continue

        # Detect eyes
        eyes = cv2.CascadeClassifier(cv2.data.haarcascades +
                                     'haarcascade_eye.xml')
        gray = cv2.cvtColor(frame, cv2.COLOR_BGR2GRAY)
        detected_eyes = eyes.detectMultiScale(gray, 1.3, 5)

        # If no eyes are detected in several frames, it might be a blink
        if len(detected_eyes) == 0:
            blink_detected = True
            break

        frame_count += 1

    camera.release()
    return blink_detected


def motion_analysis():
    camera = cv2.VideoCapture(0)
    try:
        if not camera.isOpened():
            raise ValueError("Could not open video device")

        print("Please nod your head...")
        frames = []
        frame_count = 0

        while frame_count < 20:  # Capture 20 frames for analysis
            ret, frame = camera.read()
            if not ret:
                continue
            frames.append(cv2.cvtColor(frame, cv2.COLOR_BGR2GRAY))
            frame_count += 1

        # Calculate motion between frames
        motion_detected = False
        for i in range(1, len(frames)):
            diff = cv2.absdiff(frames[i], frames[i-1])
            count = np.sum(diff > 25)  # Threshold to determinecant' motion
            if count > 500:  # Threshold for amount of 'significant'motion to consider
                motion_detected = True
                break

        if not motion_detected:
            raise ValueError("No significant motion detected!")
        return True
    finally:
        camera.release()


def noise_analysis(frame):
    gray_frame = cv2.cvtColor(frame, cv2.COLOR_BGR2GRAY)
    noise_level = np.var(gray_frame)
    if noise_level < 10:  # This threshold can be adjusted based onexperimentation
        raise ValueError("Potential spoof detected based on screennoise!")
    return True


def hash_data(data):
    """Returns a SHA-256 hash of the given data."""
    return hashlib.sha256(data).hexdigest()


def encode_images_to_base64(image_paths):
    """Encode a list of image paths to a list of base64 strings."""
    base64_strings = []

    for image_path in image_paths:
        # Read the image
        image = cv2.imread(image_path)
        if image is None:
            print(f"Warning: Unable to read image at {image_path}.Skipping.")
            continue

        # Convert to base64
        _, buffer = cv2.imencode('.jpg', image)
        jpg_as_text = base64.b64encode(buffer).decode('utf-8')
        base64_strings.append(jpg_as_text)

    return base64_strings


def opencv_face_recognition(frame):
    face_cascade = cv2.CascadeClassifier(
        cv2.data.haarcascades + 'haarcascade_frontalface_default.xml')
    gray = cv2.cvtColor(frame, cv2.COLOR_BGR2GRAY)
    faces = face_cascade.detectMultiScale(gray, 1.3, 5)
    # Returns True if a face is detected, False otherwise
    return len(faces) > 0


def capture_faces(frames, prompt_message=""):
    if not frames:
        return None, "No frames provided", None

    last_frame = frames[-1]

    for frame in frames:
        # Anti-Spoofing: Texture Analysis
        if not texture_analysis_lbp(frame):
            return None, "Potential spoof detected based on texture!", frame

        # Anti-Spoofing: Noise Analysis
        if not noise_analysis(frame):
            return None, "Potential spoof detected based on screen noise!", frame

    # Using OpenCV for Face Recognition
    if not opencv_face_recognition(last_frame):
        return None, "Face not detected", last_frame

    # Generate the actual encoding for the last frame
    face_encoding = face_recognition.face_encodings(last_frame)
    if len(face_encoding) == 0:
        return None, "Face encoding failed", last_frame

    return face_encoding[0], "Success", last_frame


encoded_frames_list = []


@app.route('/test_capture', methods=['POST'])
def test_capture():
    base64_encoded_frames = request.json.get('frames', [])
    frames = [cv2.imdecode(np.frombuffer(base64.b64decode(
        encoded_frame), dtype=np.uint8), cv2.IMREAD_COLOR) for encoded_frame in base64_encoded_frames]

    result = capture_faces(frames, prompt_message="Lookstraight")
    if result is not None:
        face_encoding, message, frame = result
    else:
        # Handle the case when capture_faces returns None
        message, frame = None, None

        encoded_frame = None
    if frame is not None:
        _, buffer = cv2.imencode('.jpg', frame)
        jpg_as_text = base64.b64encode(buffer).decode('utf-8')
        encoded_frame = jpg_as_text

        # Append the encoded frame to the list
        encoded_frames_list.append(encoded_frame)

    return jsonify(success=(message == "Success"), message=message, frame=encoded_frame)


@app.route('/signup_test', methods=['POST'])
def get_encoded_frames():
    user_id = uuid.uuid4().hex
    password = request.json.get("password")
    name = request.json.get("name")
    region = request.json.get("region")
    role = request.json.get("role")
    # Validate password before proceeding
    if not validate_password(password):
        return jsonify(success=False, message='Password does not meet requirements'), 400
    hashed_password = generate_password_hash(password)
    # return jsonify(encoded_frames=encoded_frames_list)
    user_data = {
        "_id": user_id,
        "name": name,
        "region": region,
        "role": role,
        "password": hashed_password,
        "face_encodings": encoded_frames_list   # Store all face encodings
    }
    mongo.db.users.insert_one(user_data)
    encoded_frames_list.clear;
    return jsonify(success=True, user_id=user_id, message='Registration successful!'), 200

def is_face_recognized(stored_encodings, captured_encoding):
    recognized_encodings = [face_recognition.compare_faces([stored],
                                                           captured_encoding) for stored in stored_encodings]
    return sum(recognized_encodings) > 2  # A majority vote mechanism

# def is_fingerprint_recognized(stored_fingerprints_serializedcaptured_fingerprint_serialized):
#    """Compares the captured fingerprint with stored fingerprints."""
#    try:
#        f = PyFingerprint('COM1', 57600, 0xFFFFFFFF, 0x00000000)
#        if not f.verifyPassword():
#            raise ValueError('The fingerprint sensor password isncorrect.')

#        for stored_serialized in stored_fingerprints_serialized:
#            stored = pickle.loads(stored_serialized)
#            f.uploadCharacteristics(0x01, stored)

#            captured = pickle.loads(captured_fingerprint_serialized)
#            f.uploadCharacteristics(0x02, captured)

#            if f.compareCharacteristics():  # Returns True if bothfingerprints match
#                return True
#        return False
#    except Exception as e:
#        logging.error(f"Error during fingerprint comparison: {e}")
#        raise HTTPException(description="Error during fingerprintcomparison!", code=400)


def validate_password(password):
    """
    Validates password based on the following conditions:
    - At least 8 characters long
    - Contains at least one digit
    - Contains at least one uppercase letter
    - Contains at least one special character
    """
    if len(password) < 8:
        return False
    if not re.search("[0-9]", password):
        return False
    if not re.search("[A-Z]", password):
        return False
    # Assuming special characters are !@#$%^&*()-_+=
    if not re.search("[!@#$%^&*()\-_+=]", password):
        return False
    return True


# @app.route('/signup', methods=['POST'])
# def signup():
#     try:
#         global encoded_frames  # Access the global variable

#         base64_encoded_frames = request.json.get('frames', [])
#         frames = [cv2.imdecode(np.frombuffer(base64.b64decode(
#             encoded_frame), dtype=np.uint8), cv2.IMREAD_COLOR) for encoded_frame in base64_encoded_frames]

#         message, frame = capture_faces(frames, prompt_message="Lookstraight")
#         encoded_frame = None

#         if frame is not None:
#             _, buffer = cv2.imencode('.jpg', frame)
#             jpg_as_text = base64.b64encode(buffer).decode('utf-8')
#             encoded_frame = jpg_as_text

#             # Save the encoding to the global list
#             encoded_frames.append(jpg_as_text)

#         # Hash the provided password
#         password = request.json.get("password")

#         # Validate password before proceeding
#         if not validate_password(password):
#             return jsonify(success=False, message='Password does not meet requirements'), 400

#         hashed_password = generate_password_hash(password)

#         # Generate a unique user ID
#         user_id = uuid.uuid4().hex

#         # Store user data in the database
#         user_data = {
#             "_id": user_id,
#             "password": hashed_password,
#             "face_encodings": encoded_frames  # Store all face encodings
#         }
#         mongo.db.users.insert_one(user_data)

#         return jsonify(success=True, user_id=user_id, message='Registration successful!'), 200

#     except Exception as e:
#         return jsonify(success=False, message='Error during registration: {}'.format(str(e))), 500


# @app.route('/complete_signup', methods=['POST'])
# def complete_signup():
#     temp_token = request.json.get("temp_token")
#     name = request.json.get("name")
 
#     role = request.json.get("role")

#     if not all([temp_token, name, region, role]):
#         raise HTTPException(
#             description="Missing details. Ensure temp_token, name, region, and role are provided.", code=400)

#     temp_user = mongo.db.temp_users.find_one({"_id": temp_token})
#     if not temp_user:
#         raise HTTPException(description="Invalid token provided.", code=400)

#     user = {
#         "_id": uuid.uuid4().hex,  # Assigning a final user ID
#         "name": name,
#         "region": region,
#         "role": role,
#         "password": temp_user["password"],
#         "face_encodings": temp_user["face_encodings"]
#     }
#     try:
#         mongo.db.users.insert_one(user)
#         mongo.db.temp_users.delete_one(
#             {"_id": temp_token})  # Deletinthe temporary data
#         return jsonify(success=True, user_id=user["_id"],
#                        message='Signup completed successfully!'), 200
#     except Exception as e:
#         logging.error(f"Error during signup completion: {e}")
#         raise HTTPException(
#             description="Error during signup completion!", code=400)


@app.route('/login', methods=['POST'])
def login():
    try:
        base64_encoded_frames = request.json.get('frames', [])
        frames = [cv2.imdecode(np.frombuffer(base64.b64decode(
            encoded_frame), dtype=np.uint8), cv2.IMREAD_COLOR) for encoded_frame in base64_encoded_frames]

        captured_face_encoding, encoded_frame = capture_faces(frames)
        if captured_face_encoding is None:
            return jsonify(success=False, message='Face not recognized', frame=encoded_frame), 400

        users_data = list(mongo.db.users.find({}))
        if not users_data:
            raise HTTPException(
                description="No users in the database!", code=400)

        password = request.json.get("password")
        recognized_user = None
        for user_data in users_data:
            recognized_encodings = [face_recognition.compare_faces(
                [stored], captured_face_encoding) for stored in user_data['face_encodings']]
            if sum(recognized_encodings) > 2:  # A majority votemechanism
                if check_password_hash(user_data['password'], password):
                    recognized_user = user_data
                    break

        if recognized_user:
            return jsonify(success=True, message='Face and password recognized!', user_id=recognized_user['_id']), 200
        else:
            return jsonify(success=False, message='Face recognized but credentials incorrect', frame=encoded_frame), 401

    except Exception as e:
        return jsonify(success=False, message=str(e)), 500


if __name__ == "__main__":
    app.run(debug=True, host='0.0.0.0', port='8000')
