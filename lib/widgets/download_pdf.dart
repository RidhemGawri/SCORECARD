import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:printing/printing.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

// convertImageToPDF(img) async {
//   final netImage = await networkImage(img);
//   final pdf = pw.Document();
//   pdf.addPage(pw.Page(
//       pageFormat: PdfPageFormat.a4,
//       build: (pw.Context context) {
//         return pw.Center(
//           child: netImage.toString().isEmpty
//               ? pw.CircularProgressIndicator(value: 5.0)
//               : pw.Image(netImage),
//         ); // Center
//       })); //
// }
Future<Uint8List> convertImageToPDF(img) async {
    final netImage = await networkImage(img);
  final pdf = pw.Document();

  pdf.addPage(pw.Page(
      pageFormat: PdfPageFormat.a4,
      build: (pw.Context context) {
        return pw.Center(
          child: netImage.toString().isEmpty
              ? pw.CircularProgressIndicator(value: 5.0)
              : pw.Image(netImage),
        ); // Center
      }));
  return pdf.save();
}