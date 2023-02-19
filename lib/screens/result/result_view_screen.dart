import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:resultproject/provider/cse_result_provider.dart';
import 'package:resultproject/screens/result/pdf_view_screen.dart';

import '../../widgets/download_pdf.dart';

class ResultViewScreen extends ConsumerWidget {
  int index;
   ResultViewScreen({Key? key,required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final cseprovider=ref.watch(resultProvider);
    return Scaffold(
      appBar: AppBar(
        title:  Text(cseprovider.semester[index].title),
        actions: [
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => const PdfViewScreen(),));
          }, icon: const Icon(Icons.download))
        ],
      ),
      body: Column(children: [
        CachedNetworkImage(
          imageUrl: cseprovider.semester[index].img,
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
