import 'package:assign_task/constants/ConstantColors.dart';
import 'package:assign_task/constants/ConstantStrings.dart';

import 'package:assign_task/utils/Common_widgets.dart';
import 'package:assign_task/utils/client.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/instance_manager.dart';
import 'package:google_fonts/google_fonts.dart';

class ChooseProfile extends StatefulWidget {
  final String name;
  final String pwd;
  final String region;
  const ChooseProfile({super.key, required this.name, required this.pwd, required this.region});

  @override
  State<ChooseProfile> createState() => _ChooseProfileState();
}

class _ChooseProfileState extends State<ChooseProfile> {
  Routes routeController = Get.put(Routes());
  String role="";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.center,children: [
          Container(
            width: MediaQuery.of(context).size.width,
            child: Image.asset(
              "assets/background_2.png",
              fit: BoxFit.cover,
            ),
          ),
           Padding(
                  padding: EdgeInsets.only( top: MediaQuery.of(context).size.height*0.03),
                  child: Text(
                    ConstantString.str13,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.lato(
                        color: Color(0xff9163D7),
                        fontSize: 24,
                        fontWeight: FontWeight.w700),
                  ),
                ),
                Padding(
                  padding:  EdgeInsets.only(top:MediaQuery.of(context).size.height*0.03),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CategoryWidget(text: ConstantString.str14,callback: () {
                        setState(() {
                          role="Student";
                        });
                      },
                      selectedCol:role=="Student"?ConstantColors.buttonClr: ConstantColors.textFieldClr,
                      ),
                      CategoryWidget(text: ConstantString.str15,callback: () {
                        setState(() {
                           role="Teacher";
                        });
                        
                      },
                       selectedCol:role=="Teacher"?ConstantColors.buttonClr: ConstantColors.textFieldClr,
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top:MediaQuery.of(context).size.height*0.04),
                      child: CategoryWidget(text: ConstantString.str16,callback: () {
                        setState(() {
                          role="Parent";
                        });
                        
                      },
                       selectedCol:role=="Parent"?ConstantColors.buttonClr: ConstantColors.textFieldClr,
                      ),
                    ),
                  ],
                ),
                 Padding(
                    padding: const EdgeInsets.only(top: 50),
                    child: Center(child: CustomButton(callback: () async {
                      var res= await routeController.signUp(widget.pwd,widget.name,role,widget.region);
                      if(res=="Registration successful!"){
                        Fluttertoast.showToast(msg: res);
                      }
                      else{
                        Fluttertoast.showToast(msg: res);
                      }
                      
                    }, text: ConstantString.str17)),
                  )
      
        ]),
      ),
    );
  }
}
