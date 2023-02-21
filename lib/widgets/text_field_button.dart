import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextFieldButton extends StatelessWidget {
  String lable;
   TextFieldButton({Key? key,required this.lable}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    return TextFormField(
      // keyboardType: TextInputType.phone,
      style: GoogleFonts.inter(
        fontSize: 16.0,
        color: const Color(0xFF15224F),
      ),
      maxLines: 1,
      cursorColor: const Color(0xFF15224F),
      decoration: InputDecoration(
          labelText: lable,
          labelStyle: GoogleFonts.inter(
            fontSize: 12.0,
            color: const Color(0xFF969AA8),
          ),
          border:const OutlineInputBorder()),
    );
  }
}


// Widget textfieldbtn(Size size, lable, controlname, validation, obsecure) {
//   return
// }
