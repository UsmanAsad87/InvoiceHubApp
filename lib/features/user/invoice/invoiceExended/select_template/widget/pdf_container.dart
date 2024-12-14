import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:invoice_producer/commons/common_imports/common_libs.dart';
import 'package:invoice_producer/utils/loading.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfContainer extends StatelessWidget {
  final file;
  const PdfContainer({super.key,required this.file});

  @override
  Widget build(BuildContext context) {
    return file == null ? LoadingWidget(color: Colors.red, size: 140,) :  SfPdfViewerTheme(
      data: SfPdfViewerThemeData(
        backgroundColor: context.scaffoldBackgroundColor,
      ),
      child: SfPdfViewer.file(
        File(file.absolute.path),
        pageLayoutMode: PdfPageLayoutMode.single,
        pageSpacing: 0,
      ),
    );
  }
}
