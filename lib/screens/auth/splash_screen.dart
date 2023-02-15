import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../home/all_branch_screen.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(
        const Duration(milliseconds: 1000),
            () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const AllBranchScreen(),
            )));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              richText(context),

            ],
          )),
    );
  }
}

Widget richText(context) {
  return Text.rich(
    TextSpan(
      style: GoogleFonts.inter(
        fontSize: MediaQuery.of(context).size.width * 0.05,
        color: const Color(0xFF21899C),
        letterSpacing: 2.000000061035156,
      ),
      children: const [
        TextSpan(
          text: 'PUNJABI UNIVERSITY ',
          style: TextStyle(
            fontWeight: FontWeight.w800,
          ),
        ),
        TextSpan(
          text: 'PATIALA',
          style: TextStyle(
            color: Color(0xFFFE9879),
            fontWeight: FontWeight.w800,
          ),
        ),
      ],
    ),
  );
}
