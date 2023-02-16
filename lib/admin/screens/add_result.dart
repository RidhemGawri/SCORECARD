import 'package:flutter/material.dart';
import 'package:resultproject/widgets/large_button.dart';

import '../../widgets/text_field_button.dart';

class AddResultScreen extends StatelessWidget {
  String branch;
   AddResultScreen({Key? key,required this.branch}) : super(key: key);
  String? selected='';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(branch)),
      body: Column(children: [
        const SizedBox(height: 16.0,),
        Center(
          child: Container(height: 150.0,
          width: 300.0,
            decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black,
                  blurRadius: 2.0, // soften the shadow
                  spreadRadius: -2.0, //extend the shadow
                )
              ],

            ),
            child: const Center(child: Text("Choose Image")),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextFieldButton(lable: 'Enter Student Roll No',),
        ),

        Padding(
          padding: const EdgeInsets.all(16.0),
          child: DropdownButtonFormField<String>(
            dropdownColor: Colors.white,
            style:
            const TextStyle(color: Colors.black),
            borderRadius: const BorderRadius.all(
                Radius.circular(5.0)),
            elevation: 5,
            value: allSem[0],
            hint: const Text('Select Item',
                style: TextStyle(
                    color: Colors.grey)),
            icon: const Icon(
                Icons.keyboard_arrow_down,
                color: Colors.black),
            items: allSem
                .map((items) {
              return DropdownMenuItem<String>(
                value: items,
                child: Text(items),
              );
            }).toList(),
            onChanged: (String? newValue) {
              // provider.changeCurrent(newValue);
            },
            decoration: InputDecoration(
              border: OutlineInputBorder()
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Button(buttoncolor: Colors.black, title: "Save", titlecolor: Colors.white),
        )
      ]),
    );
  }
}

List allSem=[
  "SEM I",
  "SEM II",
  "SEM III",
  "SEM IV",
  "SEM V",
  "SEM VI",
  "SEM VII",
  "SEM VIII",
];