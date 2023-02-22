import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Button extends StatelessWidget {
  var onTap;
  String title;
  Color titlecolor;
  Color buttoncolor;

  Button(
      {Key? key,
      this.onTap,
      required this.buttoncolor,
      required this.title,
      required this.titlecolor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final wsize = MediaQuery.of(context).size.width;
    final hsize = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        height:50.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          color: buttoncolor,
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF4C2E84).withOpacity(0.2),
              offset: const Offset(0, 15.0),
              blurRadius: 60.0,
            ),
          ],
        ),
        child: Text(
          title,
          style: GoogleFonts.inter(
            fontSize: 16.0,
            color: titlecolor,
            fontWeight: FontWeight.w600,
            height: 1.5,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

