import 'package:flutter/material.dart';

import '../../screens/auth/login_screen.dart';
import '../../screens/home/all_branch_screen.dart';
import '../../widgets/logout_dialogue.dart';
import 'add_result.dart';

class AdminHomePage extends StatelessWidget {
  const AdminHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          final shouldPop = await dialogBox(context);
          return shouldPop!;
        },
        child: SafeArea(
          child: Scaffold(
            appBar: AppBar(
              title: const Text("Admin"),
              actions: [
                PopupMenuButton(
                  onSelected: (value) {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                          builder: (context) => const AllBranchScreen(),
                        ),
                            (route) => false);
                  },
                  itemBuilder: (context) => [
                    const PopupMenuItem(
                      value: 1,
                      child: Text("Log out"),
                    ),
                  ],
                  elevation: 2,
                ),
              ],
            ),
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
                                builder: (context) =>
                                    AddResultScreen(branch: branches[index]),
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
          ),
        ));
  }
}
