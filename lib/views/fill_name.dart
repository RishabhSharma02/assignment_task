import 'package:assign_task/constants/ConstantStrings.dart';
import 'package:assign_task/utils/Common_widgets.dart';
import 'package:assign_task/views/fill_region.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FillName extends StatefulWidget {
  const FillName({super.key});

  @override
  State<FillName> createState() => _FillNameState();
}

class _FillNameState extends State<FillName> {
  TextEditingController nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                child: Image.asset(
                  "assets/background_2.png",
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding:  EdgeInsets.only(left: 25, top: MediaQuery.of(context).size.height*0.04),
                child: Text(
                  ConstantString.str4,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.lato(
                      color: Color(0xff9163D7),
                      fontSize: 24,
                      fontWeight: FontWeight.w700),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.03),
                child: Center(
                    child: CommonTextfield(
                      type: "normal",
                  Text: ConstantString.str5,
                  inputcontroller: nameController,
                )),
              ),
              Padding(
                padding:  EdgeInsets.only(top:MediaQuery.of(context).size.height*0.15),
                child: Center(child: CustomButton(callback: () {
                   Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return FillRegion();
                      },
                    ));
                }, text: ConstantString.str6)),
              )
            ]),
      ),
    );
  }
}
