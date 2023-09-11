import 'package:assign_task/constants/ConstantStrings.dart';
import 'package:assign_task/utils/Common_widgets.dart';
import 'package:assign_task/views/choose_profile.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FillRegion extends StatefulWidget {
  const FillRegion({super.key});

  @override
  State<FillRegion> createState() => _FillRegionState();
}

class _FillRegionState extends State<FillRegion> {
  TextEditingController regionControler = TextEditingController();
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
                "assets/background_3.png",
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 30,
              ),
              child: Text(
               ConstantString.str7,
                textAlign: TextAlign.left,
                style: GoogleFonts.lato(
                    color: Color(0xff9163D7),
                    fontSize: 24,
                    fontWeight: FontWeight.w700),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.03),
              child: Center(
                  child: CommonTextfield(
                Text: ConstantString.str8,
                inputcontroller: regionControler,
              )),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.12),
              child: Center(
                  child: CustomButton(
                      callback: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return ChooseProfile();
                          },
                        ));
                      },
                      text: ConstantString.str6)),
            )
          ],
        ),
      ),
    );
  }
}
