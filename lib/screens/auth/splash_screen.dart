import 'package:flutter/material.dart';
import 'package:resultproject/services/splash_services.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  SplashServices splashscreen = SplashServices();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    splashscreen.isActive(context);
  }

  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('PUP CSE RESULT',style: TextStyle(fontSize: 40),),
      ),
    );
  }
}
