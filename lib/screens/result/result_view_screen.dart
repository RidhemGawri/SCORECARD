import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ResultViewScreen extends StatelessWidget {
  int index;
   ResultViewScreen({Key? key,required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text("SEMESTER $index"),
      ),
      body: Column(children: [
        CachedNetworkImage(
          imageUrl: "https://firebasestorage.googleapis.com/v0/b/ucoe-result.appspot.com/o/cse%2FScreenshot%202023-02-15%20181155.png?alt=media&token=51e9fb0d-a16b-4bc6-8d95-cb73c533aa66",
          fit: BoxFit.fill,
          progressIndicatorBuilder: (context, url, downloadProgress) =>
              Center(
                  child: CircularProgressIndicator(
                      value: downloadProgress.progress)),
          errorWidget: (context, url, error) =>
          const Icon(Icons.error, color: Colors.black),
        ),
      ]),
    );
  }
}
