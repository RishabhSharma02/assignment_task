import 'package:assign_task/constants/ConstantStrings.dart';
import 'package:assign_task/views/fingerprint_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FaceScreen extends StatelessWidget {
  const FaceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return FingerprintScreen();
            },));
          },
          child: Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(),
            child: Image.asset("assets/face_photo.png"),
          ),
        ),
        Positioned(
            top: MediaQuery.of(context).size.height * 0.65,
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: DefaultTextStyle(
                      style: GoogleFonts.lato(
                          color: Colors.black,
                          fontSize: 24,
                          fontWeight: FontWeight.w700),
                      child: Text(ConstantString.str1)),
                ),
                Padding(
                  padding:  EdgeInsets.only(top:MediaQuery.of(context).size.height*0.02),
                  child: DefaultTextStyle(
                      style: GoogleFonts.lato(
                          color: Colors.black,
                          fontSize: 14,
                          ),
                      child: Text(ConstantString.str2)),
                ),
                Padding(
                  padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.1),
                  child: DefaultTextStyle(
                      style: GoogleFonts.lato(
                          color: Colors.black,
                          fontSize: 14,
                          ),
                      child: Text(ConstantString.str3)),
                ),
                Padding(
                  padding:  EdgeInsets.only(top:MediaQuery.of(context).size.height*0.04),
                  child: Image.asset("assets/progress_bar.png"),
                )
              ]),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.5,
            ))
      ],
    );
  }
}
