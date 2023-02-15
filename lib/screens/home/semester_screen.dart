import 'package:flutter/material.dart';
import 'package:resultproject/screens/result/result_view_screen.dart';

class ViewAllSem extends StatelessWidget {
  const ViewAllSem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(title: const Text("Choose Semester",)),
      body: ListView.builder(
        itemCount: 8,
        itemBuilder: (context, index) {
        return GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => ResultViewScreen(index: index+1),));
            },
            child: Semester(sem: index));
      },)
    );
  }
}
class Semester extends StatelessWidget {
  int sem;
   Semester({Key? key,required this.sem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 50.0,
        width: 200.0,
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black,
              blurRadius: 5.0, // soften the shadow
              spreadRadius: -1.0, //extend the shadow
              offset: Offset(
                -2.0, // Move to right 10  horizontally
                2.0, // Move to bottom 5 Vertically
              ),
            )
          ],
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
        ),
        child: Center(child: Text("SEMESTER ${sem+1}")),
      ),
    );
  }
}
