

import 'package:dio/dio.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class Routes extends GetxController{
 Future<void> signUp() async {
  try {
    final dio = Dio();
    final url = 'http://127.0.0.1:5000//signup'; 
    final FormData formData = FormData.fromMap({
      'password': 'your_password_here',
      'face_encodings': [
        'encoding1',
        'encoding2',
      ],
    });
    final response = await dio.post(
      url,
      data: formData,
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

 




