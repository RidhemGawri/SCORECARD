

import 'package:flutter/material.dart';
import 'package:printing/printing.dart' ;
import 'package:pdf/pdf.dart' ;
import 'package:pdf/widgets.dart' as pw;
 convertImageToPDF(img) async {
  final netImage = await networkImage('https://firebasestorage.googleapis.com/v0/b/ucoe-result.appspot.com/o/cse%2FScreenshot%202023-02-15%20181155.png?alt=media&token=51e9fb0d-a16b-4bc6-8d95-cb73c533aa66');
  final pdf = pw.Document();
  pdf.addPage(pw.Page(
      pageFormat: PdfPageFormat.a4,
      build: (pw.Context context) {
        return pw.Center(
          child: netImage.toString().isEmpty? pw.CircularProgressIndicator(value: 5.0) : pw.Image(netImage),
        ); // Center
      })); //
}
