import 'package:flutter/material.dart';
import 'package:printing/printing.dart';

import '../../widgets/download_pdf.dart';

class PdfViewScreen extends StatelessWidget {
  const PdfViewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: PdfPreview(
        build: (context) => convertImageToPDF(''),
      )
    );
  }
}
