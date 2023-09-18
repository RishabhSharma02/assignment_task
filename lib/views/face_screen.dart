import 'dart:async';

import 'package:assign_task/constants/ConstantColors.dart';
import 'package:assign_task/constants/ConstantStrings.dart';
import 'package:assign_task/utils/client.dart';
import 'package:assign_task/views/fill_password.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:google_fonts/google_fonts.dart';

late List<CameraDescription> _cameras;

class FaceScreen extends StatefulWidget {
  final List<CameraDescription> cameras;
  FaceScreen({super.key, required this.cameras});

  @override
  State<FaceScreen> createState() => _FaceScreenState();
}

class _FaceScreenState extends State<FaceScreen> {
  Routes routeController=Get.put(Routes());
  late XFile? capturedImage; 
  int progressval = 0;
  late CameraController controller;
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
        switch (e.code) {
          case 'CameraAccessDenied':
            // Handle access errors here.
            break;
          default:
            // Handle other errors here.
            break;
        }
      }
    });
      Timer.periodic(Duration(seconds: 5), (Timer timer) {
        
        captureImage();
        print("=============>CAPTURED");
        setState(() {
           progressval+=20;
        });
        //routeController.signUp(capturedImage!);
        if(progressval==100){
          timer.cancel();
          Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return FingerprintScreen();
                    },
                  ));
        }
    
  });
  
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

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
                    BuildInstructionText(progressval: progressval),
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
                    Padding(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.1),
                      child: DefaultTextStyle(
                        
                          style: GoogleFonts.lato(
                            color: Colors.black,
                            fontSize: 14,
                          ),
                          child: Text(progressval.toString()+" %")),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FAProgressBar(
                        maxValue: 100,
                        currentValue: progressval.toDouble(),
                        progressColor: ConstantColors.buttonClr,
                        size: 15,
                      ),
                    )
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
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return FingerprintScreen();
                    },
                  ));
                },
                child: Image.asset("assets/face_border.png")))
      ],
    );
  }
  captureImage() async{
   final XFile? image = await controller.takePicture();
      capturedImage = image;
      Fluttertoast.showToast(msg: "Frame captured");
      print(capturedImage!.path.toString());
   
}
}
class BuildInstructionText extends StatelessWidget {
  final int progressval;
  const BuildInstructionText({super.key, required this.progressval});

  @override
  Widget build(BuildContext context) {
    switch(progressval){
      case 0:
            return Padding(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.02),
                      child: DefaultTextStyle(
                        
                          style: GoogleFonts.lato(
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                            fontSize: 24,
                          ),
                          child: Text("Look Left")),
                    );
      case 20:
      return Padding(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.02),
                      child: DefaultTextStyle(
                          style: GoogleFonts.lato(
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                            fontSize: 24,
                          ),
                          child: Text("Look Center")),
                    );
      case 40:
               return Padding(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.02),
                      child: DefaultTextStyle(
                          style: GoogleFonts.lato(
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                            fontSize: 24,
                          ),
                          child: Text("Look Right")),
                    );


                    case 60:
               return Padding(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.02),
                      child: DefaultTextStyle(
                          style: GoogleFonts.lato(
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                            fontSize: 24,
                          ),
                          child: Text("Face Up")),
                    );
                    case 80:
               return Padding(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.02),
                      child: DefaultTextStyle(
                          style: GoogleFonts.lato(
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                            fontSize: 24,
                          ),
                          child: Text("Face Down")),
                    );
      default:
                     return Padding(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.02),
                      child: DefaultTextStyle(
                          style: GoogleFonts.lato(
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                            fontSize: 24,
                          ),
                          child: Text("Completed !")),
                    );

    }
    
  }
  
}
