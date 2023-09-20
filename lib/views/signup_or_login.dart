import 'package:assign_task/utils/Common_widgets.dart';
import 'package:assign_task/views/fill_name.dart';
import 'package:assign_task/views/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Login_or_Signup extends StatelessWidget {
  const Login_or_Signup({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
backgroundColor: Colors.white,
      body: Column(children: [
         Container(
                width: MediaQuery.of(context).size.width,
                child: Image.asset(
                  "assets/background_2.png",
                  fit: BoxFit.cover,
                ),
              ),
              Center(
                child: Text(
                  "Choose a action",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.lato(
                      color: Color(0xff9163D7),
                      fontSize: 24,
                      fontWeight: FontWeight.w700),
                ),
              ),
               Padding(
                padding:  EdgeInsets.only(top:MediaQuery.of(context).size.height*0.05),
                child: Center(child: CustomButton(callback: () {
                     Get.to(()=>FillName(),transition: Transition.fadeIn);
                }, text: "Sign up")),
              ),
                Padding(
                padding:  EdgeInsets.only(top:MediaQuery.of(context).size.height*0.05),
                child: Center(child: CustomButton(callback: () {
                   Get.to(()=>Login(),transition: Transition.fadeIn);
                }, text: "Login")),
              )


      ]),
    );
  }
}