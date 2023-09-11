import 'package:assign_task/constants/Constants.dart';
import 'package:assign_task/utils/Common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChooseProfile extends StatefulWidget {
  const ChooseProfile({super.key});

  @override
  State<ChooseProfile> createState() => _ChooseProfileState();
}

class _ChooseProfileState extends State<ChooseProfile> {
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
                      CategoryWidget(text: ConstantString.str14,),
                      CategoryWidget(text: ConstantString.str15,),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top:MediaQuery.of(context).size.height*0.04),
                      child: CategoryWidget(text: ConstantString.str16),
                    ),
                  ],
                ),
                 Padding(
                    padding: const EdgeInsets.only(top: 50),
                    child: Center(child: CustomButton(callback: () {
                      
                    }, text: ConstantString.str17)),
                  )
      
        ]),
      ),
    );
  }
}
