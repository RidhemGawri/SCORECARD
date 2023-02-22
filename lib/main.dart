import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:resultproject/screens/auth/splash_screen.dart';
void main() async {
  AwesomeNotifications().initialize(
    null,
    [
      NotificationChannel(
          channelKey: 'basic_channel',
          channelName: 'Basic notification',
          channelDescription: 'Notification channel'),
    ],
    debug: true,
  );
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const ProviderScope(child: MyApp()));

}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) => {
       if(!isAllowed){
         AwesomeNotifications().requestPermissionToSendNotifications(),
       } 
    });
    super.initState();
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: const SplashScreen(),

    );
  }
}
