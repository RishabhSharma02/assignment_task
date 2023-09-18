

import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:dio/dio.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class Routes extends GetxController{
 Future<void> signUp(XFile imageFile) async {
  final File file = File(imageFile.path);
  final Uint8List bytes = await file.readAsBytes();
  final String base64Image = base64Encode(bytes);

  try {
    final dio = Dio();
      final data = {
    'password': '213213',
    'frame_base64': base64Image,
  };
    final url = 'http://127.0.0.1:5000/signup'; 
    final FormData formData = FormData.fromMap({
      'password': 'your_password_here',
      'face_encodings': [
        'encoding1',
        'encoding2',
      ],
    });
    final response = await dio.post(
      url,
      data: jsonEncode(data),
      options: Options(
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
        },
      ),
    );

    if (response.statusCode == 200) {
      print(response.data);
    } else {
      print('Signup failed with status: ${response.statusCode}');
    }
  } catch (e) {
    print('Error: $e');
  }
}

}

 




