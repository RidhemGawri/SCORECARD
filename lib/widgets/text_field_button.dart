import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextFieldButton extends StatelessWidget {
  String lable;
  TextEditingController controller;
  var icon;
   TextFieldButton({Key? key,required this.lable,required this.controller,required this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    return TextFormField(
      controller: controller,
      style: GoogleFonts.inter(
        fontSize: 16.0,
        color: const Color(0xFF15224F),
      ),
      maxLines: 1,
      cursorColor: const Color(0xFF15224F),
      decoration: InputDecoration(
        prefixIcon: Icon(icon),
          labelText: lable,
          labelStyle: GoogleFonts.inter(
            fontSize: 12.0,
            color: const Color(0xFF969AA8),
          ),
          border:const OutlineInputBorder()),


    );
  }
}
