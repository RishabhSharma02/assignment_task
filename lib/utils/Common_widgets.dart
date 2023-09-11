import 'package:assign_task/constants/ConstantColors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CommonTextfield extends StatelessWidget {
  final String Text;
  final TextEditingController inputcontroller;
  const CommonTextfield(
      {super.key, required this.Text, required this.inputcontroller});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Color.fromARGB(255, 241, 234, 250),
          borderRadius: BorderRadius.circular(32)),
      width: MediaQuery.of(context).size.width * 0.9,
      height: 65,
      child: TextField(
        controller: inputcontroller,
        decoration: InputDecoration(
            hintText: Text,
            hintStyle: GoogleFonts.lato(),
            border: OutlineInputBorder(borderSide: BorderSide.none)),
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback callback;
  const CustomButton({
    super.key,
    required this.callback,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: MediaQuery.of(context).size.width*0.9,
      child: ElevatedButton(
         style: ElevatedButton.styleFrom(
      backgroundColor: ColorConstants.buttonClr
      ),
        onPressed: callback,
        child: Text(
          text,
          style: GoogleFonts.lato(fontSize: 14,color: Colors.white),
        ),
      ),
    );
  }
}
class CategoryWidget extends StatelessWidget {
  final String text;
  const CategoryWidget({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(child: Text(text,style: GoogleFonts.lato(fontSize: 14),)),
      width: 120,
      height: 55,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(30),color: ColorConstants.textFieldClr),
    );
  }
}
