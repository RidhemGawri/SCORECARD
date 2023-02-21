import 'package:flutter/material.dart';

import '../../screens/home/all_branch_screen.dart';
import 'add_result.dart';

class AdminHomePage extends StatelessWidget {
  const AdminHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Admin")),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GridView.builder(
            itemCount: 5,
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2),
            itemBuilder: (context, index) {
              return GestureDetector(
                  onTap: () {
                    Navigator.push(
                    context,
                    MaterialPageRoute(
                    builder: (context) => AddResultScreen(branch: branches[index]),
                    ));
                  },
                  child: BuildCard(
                    text: branches[index],
                    fullname: fullname[index],
                  ));
            },
          ),
        ),
      ),
    );
  }
}
