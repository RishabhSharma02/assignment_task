import 'package:assign_task/constants/ConstantColors.dart';
import 'package:assign_task/constants/ConstantStrings.dart';

import 'package:assign_task/utils/Common_widgets.dart';
import 'package:assign_task/utils/client.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/instance_manager.dart';
import 'package:google_fonts/google_fonts.dart';

class ChooseProfile extends StatelessWidget {
  ChooseProfile({super.key});

  ProfileController profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
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
                    "assets/background_2.png",
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.03),
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
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.03),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CategoryWidget(
                        text: ConstantString.str14,
                        callback: () {
                          profileController.role.value = "Student";
                        },
                        selectedCol: profileController.role.value == "Student"
                            ? ConstantColors.buttonClr
                            : ConstantColors.textFieldClr,
                      ),
                      CategoryWidget(
                        text: ConstantString.str15,
                        callback: () {
                          profileController.role.value = "Teacher";
                        },
                        selectedCol: profileController.role.value == "Teacher"
                            ? ConstantColors.buttonClr
                            : ConstantColors.textFieldClr,
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.04),
                      child: CategoryWidget(
                        text: ConstantString.str16,
                        callback: () {
                          profileController.role.value = "Parent";
                        },
                        selectedCol: profileController.role.value == "Parent"
                            ? ConstantColors.buttonClr
                            : ConstantColors.textFieldClr,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child: Center(
                      child: CustomButton(
                          callback: () async {
                            print(profileController.name.value);
                            print(profileController.role.value);
                            print(profileController.region.value);
                          },
                          text: ConstantString.str17)),
                )
              ]),
        ),
      ),
    );
  }
}
