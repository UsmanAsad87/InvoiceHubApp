import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:invoice_producer/commons/common_imports/apis_commons.dart';
import 'package:invoice_producer/core/enums/currency_sign_enum.dart';
import 'package:invoice_producer/features/user/invoice/pdf_templates/pdf_file_format_one/pdf_widgets/pdf_text.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

import '../../../../../../models/invoice_model/invoice_model.dart';
import '../../../../../../utils/constants/app_constants.dart';
import '../../../../../../utils/constants/font_manager.dart';
import '../../pdf_constants/pdf_constants.dart';

Widget buildTotal(InVoiceModel invoice) {
final currency = getCurrencySymbol(invoice.currency?.name);
  return Row(children: [
    SizedBox(height: 4.h),
    Expanded(
        flex: 1,
        child: Container(
            alignment: Alignment.centerLeft,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              pdfText(
                text: 'TOTAL:',
                color: PdfColors.black,
                fontSize: MyFonts.size14,
                fontWeight: FontWeight.bold,
              ),
                  SizedBox(height: 8.h),
              pdfText(
                text: '$currency ${invoice.total}',
                color: PdfColors.black,
                fontSize: MyFonts.size20,
                fontWeight: FontWeight.bold,
              ),
            ]))),
    Expanded(
        // flex: 1,
        child: Container(
            alignment: Alignment.center,
            child:
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              pdfText(
                text: 'PAID:',
                color: PdfColors.black,
                fontSize: MyFonts.size14,
                fontWeight: FontWeight.bold,
              ),
              SizedBox(height: 8.h),
              pdfText(
                text: '$currency ${invoice.paid ?? 0}',
                color: PdfColors.black,
                fontSize: MyFonts.size20,
                fontWeight: FontWeight.bold,
              ),
            ]))),
    Expanded(
        flex: 1,
        child: Container(
            alignment: Alignment.centerRight,
            child:
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              pdfText(
                text: 'TOTAL DUE:',
                color: PdfColors.black,
                fontSize: MyFonts.size14,
                fontWeight: FontWeight.bold,
              ),
              SizedBox(height: 8.h),
              pdfText(
                text: '$currency ${invoice.dueBalance ?? 0}',
                color: PdfConstants.pdfThreeCol,
                fontSize: MyFonts.size20,
                fontWeight: FontWeight.bold,
              ),
            ])))
  ]);
}

// formatPrice(double price) => '$currency ${price.toStringAsFixed(2)}';
