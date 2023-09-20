

import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:assign_task/Models/Face_model.dart';
import 'package:assign_task/Models/signup_model.dart';
import 'package:camera/camera.dart';
import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:http/http.dart' as http;
class Routes extends GetxController{
 Future<String> faceDetect(XFile imageFile) async {
  final File file = File(imageFile.path);
  final Uint8List bytes = await file.readAsBytes();
  final String base64Image = base64Encode(bytes);
  print("========================++++++++>"+base64Image);
  try {
    final requestData = {
      "frames": [base64Image],
    };
    final dio = Dio();
    final url = 'http://192.168.231.69:8000/test_capture'; 
    final response = await dio.post(
      url,
       data: jsonEncode(requestData),
      options: Options(
        contentType: Headers.jsonContentType,
      ));

    if (response.statusCode == 200) {
      print(faceModel.fromJson(response.data).message);
      print("============================================");
      return  faceModel.fromJson(response.data).message!;
     
    } else {
     return "Server connection error";
    }
  } catch (e) {
    print(e.toString());
    return e.toString();
  }
}
Future<String> signUp(String fill_password,String name,String role,String region) async {
  try {
    final requestData = {
      "name":name,
      "role":role,
      "region":region,
      "password": fill_password,
    };
    final dio = Dio();
    final url = 'http://192.168.231.69:8000/signup_test'; 
    final response = await dio.post(
      url,
       data: jsonEncode(requestData),
      options: Options(
        contentType: Headers.jsonContentType,
      ));
    if (response.statusCode == 200) {
      print(signupModel.fromJson(response.data).message);
      print("============================================");
      return  faceModel.fromJson(response.data).message!;
     
    } else {
     return "Server connection error";
    }
  } catch (e) {
    print(e.toString());
    return e.toString();
  }
}
 Future<String> loginFace(XFile imageFile) async {
  final File file = File(imageFile.path);
  final Uint8List bytes = await file.readAsBytes();
  final String base64Image = base64Encode(bytes);
   try {
    final requestData = {
      'frames': [base64Image],
      "password":"password"
    };
    final dio = Dio();
    final url = 'http://192.168.231.69:8000/login'; 
    final response = await dio.post(
      url,
       data: jsonEncode(requestData),
      options: Options(
        contentType: Headers.jsonContentType,
      ));

    if (response.statusCode == 200) {
      print(faceModel.fromJson(response.data).message);
      print("============================================");
      return  faceModel.fromJson(response.data).message!;
     
    } else {
     return "Server connection error";
    }
  } catch (e) {
    print(e.toString());
    return e.toString();
  }
 }






}

 




