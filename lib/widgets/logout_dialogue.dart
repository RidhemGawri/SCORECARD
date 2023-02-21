import 'package:flutter/material.dart';

dialogBox(context) {
  return showDialog(
    context: context,
    builder: (context) => Theme(
      data: ThemeData(backgroundColor: Colors.white),
      child: AlertDialog(
        title: const Text('Are you sure?'),
        content: const Text('Do you want to go back?'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.pop(context, false);
            },
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context, true);
            },
            child: const Text('Yes'),
          ),
        ],
      ),
    ),
  );
}