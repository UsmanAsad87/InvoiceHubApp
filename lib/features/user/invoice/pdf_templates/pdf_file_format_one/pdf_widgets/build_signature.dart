import 'dart:typed_data';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:invoice_producer/features/user/invoice/pdf_templates/pdf_file_format_one/pdf_widgets/pdf_text.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import '../../../../../../utils/constants/app_constants.dart';
import '../../../../../../utils/constants/font_manager.dart';

Widget buildSignature(Uint8List? signature) {
    return Container(
    alignment: Alignment.centerRight,
    child: Padding(
        padding: EdgeInsets.all(AppConstants.padding),
        child: Column(
            children: [
              signature != null? Image(MemoryImage(signature!), height: 80.h, width: 100.w): SizedBox(
                height: 80.h
              ),
              Container(
                  padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 8.w),
                // padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 8.w),
                  width: 130, height: 1, color: PdfColors.black),
              pdfText(text: 'Authorised Sign',
                  color: PdfColors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: MyFonts.size16),
            ])));
}