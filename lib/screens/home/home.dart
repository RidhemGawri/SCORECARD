import 'package:flutter/material.dart';
import 'package:resultproject/admin/screens/admin_home_page.dart';
import 'package:resultproject/screens/home/all_branch_screen.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Home")),
      body: SingleChildScrollView(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
          GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AllBranchScreen(),
                    ));
              },
              child: SizedBox(
                  width: 200.0,
                  height: 200.0,
                  child: BuildCard(text: "Result", fullname: "See Result"))),
          GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AdminHomePage(),
                    ));
              },
              child: SizedBox(
                  height: 200.0,
                  width: 200.0,
                  child: BuildCard(text: "Admin", fullname: "Add Result"))),
        ]),
      ),
    );
  }
}
