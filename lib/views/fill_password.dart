import 'package:assign_task/utils/Common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FingerprintScreen extends StatefulWidget {
  const FingerprintScreen({super.key});

  @override
  State<FingerprintScreen> createState() => _FingerprintScreenState();
}

class _FingerprintScreenState extends State<FingerprintScreen> {
  TextEditingController nameController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  width: MediaQuery.of(context).size.width,
                  child: Image.asset(
                    "assets/background_3.png",
                    fit: BoxFit.cover,
                  ),
                ),
                 Padding(
                  padding:  EdgeInsets.only( top: MediaQuery.of(context).size.height*0.04),
                  child: Center(
                    child: Text(
                      "Enter your password",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.lato(
                          color: Color(0xff9163D7),
                          fontSize: 24,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.05),
                  child: Center(
                      child: CommonTextfield(
                        type: "pwd",
                    Text: "Enter your password", inputcontroller: nameController,
                    //inputcontroller: nameController,
                  )),
                ),
              
             
            ]),
      ),
    );
  }
}
