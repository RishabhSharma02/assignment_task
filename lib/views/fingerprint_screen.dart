import 'package:assign_task/constants/Constants.dart';
import 'package:assign_task/views/fill_name.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FingerprintScreen extends StatelessWidget {
  const FingerprintScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset("assets/background.png"),
            Padding(
              padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height*0.05),
              child: GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return FillName();
                      },
                    ));
                  },
                  child: Image.asset("assets/fingerprint.png")),
            ),
            Padding(
              padding: EdgeInsets.only(top:MediaQuery.of(context).size.height*0.07),
              child: Text(
                ConstantString.str10,
                style: GoogleFonts.lato(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.w700),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top:MediaQuery.of(context).size.height*0.07),
              child: Text(
                ConstantString.str11,
                style: GoogleFonts.lato(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.w700),
              ),
            ),
            Padding(
              padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height*0.02),
              child: Text(
                ConstantString.str12,
                textAlign: TextAlign.center,
                style: GoogleFonts.lato(
                  color: Colors.grey,
                  fontSize: 14,
                ),
              ),
            )
          ]),
    );
  }
}
