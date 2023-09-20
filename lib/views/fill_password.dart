import 'package:assign_task/constants/ConstantStrings.dart';
import 'package:assign_task/utils/Common_widgets.dart';
import 'package:assign_task/utils/client.dart';
import 'package:assign_task/views/fill_name.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/instance_manager.dart';
import 'package:google_fonts/google_fonts.dart';

class FingerprintScreen extends StatefulWidget {
  const FingerprintScreen({super.key});

  @override
  State<FingerprintScreen> createState() => _FingerprintScreenState();
}

class _FingerprintScreenState extends State<FingerprintScreen> {
  Routes routeController = Get.put(Routes());
  TextEditingController pwdController=TextEditingController();
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
                    Text: "Enter your password", inputcontroller: pwdController,
                    //inputcontroller: nameController,
                  )),
                ),
              Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.07),
              child: Center(
                  child: CustomButton(
                      callback: () async{
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return FillName(pwd: pwdController.text,);
                          },
                        ));
                      },
                      text: ConstantString.str6)),
            )
              
             
            ]),
      ),
    );
  }
}
