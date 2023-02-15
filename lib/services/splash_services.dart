import 'dart:async';
import 'package:flutter/material.dart';
import 'package:resultproject/screens/home/home_page.dart';

import '../screens/home/all_branch_screen.dart';

class SplashServices {
  void isActive(BuildContext context) {
   Timer(const Duration(seconds: 3), 
    ()=> Navigator.push(context,MaterialPageRoute(builder: (context) => AllBranches()))
    );
  }
}
