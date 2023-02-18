import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:resultproject/screens/home/semester_screen.dart';

import '../result/result_view_screen.dart';

class RollNumberScreen extends StatelessWidget {
  String branch;
   RollNumberScreen({Key? key,required this.branch}) : super(key: key);
  TextEditingController rollnumber = TextEditingController();

  @override
  triggerNotification(){
    AwesomeNotifications().createNotification(
      content:NotificationContent(
        id: 10, 
        channelKey: 'basic_channel',
        title: 'Simple_notification',
        body: 'Simple',
        ),
      );
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // automaticallyImplyLeading: false,
        title:  Text('PUP $branch RESULT'),
        shadowColor: Colors.blueGrey,
        actions: [
          IconButton(
            onPressed: triggerNotification,
            icon: Icon(Icons.notifications),
          ),
          SizedBox(
            width: 10,
          )
        ],
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 80,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 70),
            child: TextField(
              controller: rollnumber,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                  contentPadding: EdgeInsets.all(10),
                  border: OutlineInputBorder(),
                  labelText: "  Enter Student's Roll-number"),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              shadowColor: Colors.blueGrey,
            ),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => ViewAllSem(),));
            },
            child: const Text(
              'Submit',
              style: TextStyle(fontSize: 15.0),
            ),
          ),
        ],
      ),
    );
  }
}
