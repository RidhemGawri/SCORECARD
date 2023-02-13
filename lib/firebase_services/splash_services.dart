import 'dart:async';
import 'package:flutter/material.dart';
import 'package:resultproject/ui/auth/home_page.dart';

class splashServices {
  void isActive(BuildContext context) {
   Timer(const Duration(seconds: 3), 
    ()=> Navigator.push(context,MaterialPageRoute(builder: (context) => HomePage()))
    );
  }
}
