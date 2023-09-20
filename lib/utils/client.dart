import 'dart:convert';
import 'package:assign_task/Models/signup_model.dart';
import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
class ProfileController extends GetxController{
  RxString role="".obs;
   RxString name="".obs;
    RxString region="".obs;
Future<void> logIn(String username,String password) async {
  try {
    final requestData = {
      'username':username,
      'password': password,
    };
    final dio = Dio();
    final url = 'http://192.168.1.9:8000/login'; 
    final response = await dio.post(
      url,
       data: jsonEncode(requestData),
      options: Options(
        contentType: Headers.jsonContentType,
      ));
    if (response.statusCode == 200) {
      print(signupModel.fromJson(response.data).message);
      print("============================================");
      Fluttertoast.showToast(msg:signupModel.fromJson(response.data).message !);
    } else {
        Fluttertoast.showToast(msg:signupModel.fromJson(response.data).message !);
        print(response.statusCode);
    
    }
  } catch (e) {
    print(e.toString());
   
  }
}







}

 




