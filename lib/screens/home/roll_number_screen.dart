import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:resultproject/config/config.dart';


import 'package:resultproject/screens/home/semester_screen.dart';

import '../../provider/cse_result_provider.dart';
import '../../widgets/large_button.dart';
import '../result/result_view_screen.dart';

class RollNumberScreen extends ConsumerWidget {
  String branch;
   RollNumberScreen({Key? key,required this.branch}) : super(key: key);
  TextEditingController controller = TextEditingController();
  final GlobalKey<FormState> formkey = GlobalKey();
  @override

  Widget build(BuildContext context,WidgetRef ref) {
    final cseprovider=ref.watch(resultProvider);

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

      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: formkey,

          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                  controller: controller,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp(r'\d')),
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  validator: (value) {

                    if (value!.isEmpty) {
                      return "roll number can't be empty";
                    } else if (value.length !=8) {
                      return 'Roll number is not correct';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                      labelText: "Enter Roll number",
                      border: OutlineInputBorder()
                      // hintText: "whatever you want",
                  )
              ),
              const SizedBox(height: 20.0,),
              Button(onTap: ()async {
                if(formkey.currentState!.validate()){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ViewAllSem(rollno: controller.text,branch:branch),));

                }
              },buttoncolor: AppConfig.primaryColor, title: 'Submit', titlecolor: Colors.white,),
            ],
          ),
        ),
      ),
    );
  }
}
