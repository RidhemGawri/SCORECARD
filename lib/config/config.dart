import 'package:flutter/material.dart';

class AppConfig {
  static Color primaryColor = const Color(0xff134074);
  static Color greyColor = const Color(0xfffafafa);
  static Color secmainColor = const Color(0xfff3f3f3);
  static Color blackColor = const Color(0xff606060);

  //typography
  // TextStyle greySmallText = TextStyle(fontSize: 15, color: AppConfig.greyColor);
  static TextStyle blackTitle = const TextStyle(color: Colors.black);
  static TextStyle greytext =
      TextStyle(color: Colors.grey.shade900, fontWeight: FontWeight.w500);
  static TextStyle blacktext =
      TextStyle(color: Colors.grey.shade900, fontWeight: FontWeight.w500);
  static TextStyle blacklargetext =  const TextStyle(color: Colors.black54,fontWeight: FontWeight.w500,fontSize: 17.0);
  static TextStyle whitetext =  const TextStyle(color: Colors.white,fontWeight: FontWeight.w500);
}
