import 'dart:async';

import 'package:assign_task/constants/ConstantStrings.dart';
import 'package:assign_task/utils/client.dart';
import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/instance_manager.dart';
import 'package:google_fonts/google_fonts.dart';
late List<CameraDescription> _cameras;
class LoginFaceScreen extends StatefulWidget {
  final List<CameraDescription> cameras;
  const LoginFaceScreen({super.key, required this.cameras});

  @override
  State<LoginFaceScreen> createState() => _LoginFaceScreenState();
}

class _LoginFaceScreenState extends State<LoginFaceScreen> {
  Routes routeController = Get.put(Routes());
   void initState() {
    super.initState();
    controller = CameraController(widget.cameras[1], ResolutionPreset.max);
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    }).catchError((Object e) {
      if (e is CameraException) {
        Fluttertoast.showToast(msg: e.toString());
      }
    });
    Timer.periodic(Duration(seconds: 5), (timer)async { 
    var Capimg = await captureImage();
       print("=============>CAPTURED");
      var res=await routeController.loginFace(Capimg!);
      Fluttertoast.showToast(msg: res);
    });
    

    
  }
  late CameraController controller;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CameraPreview(controller),
        Positioned(
            top: MediaQuery.of(context).size.height * 0.65,
            child: Container(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                     Padding(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.02),
                      child: DefaultTextStyle(
                          style: GoogleFonts.lato(
                            color: Colors.black,
                            fontSize: 24,
                          ),
                          child: Text(ConstantString.str2)),
                    ),

                    Padding(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.02),
                      child: DefaultTextStyle(
                          style: GoogleFonts.lato(
                            color: Colors.black,
                            fontSize: 14,
                          ),
                          child: Text(ConstantString.str2)),
                    ),
                  ]),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.5,
            )),
        Positioned(
            top: MediaQuery.of(context).size.height * 0.1,
            left: MediaQuery.of(context).size.width * 0.1,
            child: GestureDetector(
                onTap: () {
              
                },
                child: Image.asset("assets/face_border.png")))
      ],
    );
  }
  captureImage() async {
    final XFile? image = await controller.takePicture();
    Fluttertoast.showToast(msg: "Frame captured");
    print(image!.path.toString());
    return image;
  }
}