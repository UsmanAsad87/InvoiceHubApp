import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:invoice_producer/features/user/invoice/pdf_templates/pdf_constants/pdf_constants.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

import '../../../../../../core/enums/currency_sign_enum.dart';
import '../../../../../../models/invoice_model/invoice_model.dart';
import '../../../../../../utils/constants/app_constants.dart';
import '../../../../../../utils/constants/font_manager.dart';

Widget buildTotal(InVoiceModel invoice) {
  // List<List<dynamic>> data = [];
  final currency = getCurrencySymbol(invoice.currency?.name);
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 45.h),
      child: Container(
      decoration: const BoxDecoration(
        color: PdfColor.fromInt(0xFFFFFFFF),
      ),
      child: Padding(
        padding: EdgeInsets.all(
            4.r),
        child: Row(children: [
          Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
            SizedBox(height: 4.h),
            Text('Total',
                style: TextStyle(
                    color: PdfConstants.pdfFiveTextCol,
                    fontSize: MyFonts.size13,
                    fontWeight: FontWeight.normal)),
            SizedBox(height: 4.h),
            Text('Paid',
                style: TextStyle(
                    color: PdfConstants.pdfFiveTextCol,
                    fontSize: MyFonts.size13,
                    fontWeight: FontWeight.normal)),
            SizedBox(height: 4.h),
            Text('Balance Due',
                style: TextStyle(
                    color: PdfConstants.pdfFiveTextCol,
                    fontSize: MyFonts.size18,
                    fontWeight: FontWeight.bold)),
          ]),
          SizedBox(width: 8.w),
          Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
            SizedBox(height: 4.h),
            Text('$currency${invoice.total}',
                style: TextStyle(
                    color: PdfConstants.pdfFiveTextCol,
                    fontSize: MyFonts.size13,
                    fontWeight: FontWeight.normal)),
            SizedBox(height: 4.h),
            Text('$currency${invoice.paid ?? 0}',
                style: TextStyle(
                    color: PdfConstants.pdfFiveTextCol,
                    fontSize: MyFonts.size13,
                    fontWeight: FontWeight.normal)),
            SizedBox(height: 4.h),
            Text('$currency${invoice.dueBalance ?? 0}',
                style: TextStyle(
                    color: PdfConstants.pdfFiveTextCol,
                    fontSize: MyFonts.size18,
                    fontWeight: FontWeight.bold)),
          ]),
        ]),
      )));
}

buildText({
  required String title,
  required String value,
  double width = double.infinity,
  TextStyle? titleStyle,
  bool unite = false,
}) {
  final style = titleStyle ?? TextStyle(fontWeight: FontWeight.bold);

  return Container(
    width: width,
    child: Row(
      children: [
        Expanded(child: Text(title, style: style)),
        Text(value, style: unite ? style : null),
      ],
    ),
  );
}

formatPrice(double price) => '\$ ${price.toStringAsFixed(2)}';
