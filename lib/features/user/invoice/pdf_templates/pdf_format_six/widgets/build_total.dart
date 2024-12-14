import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:invoice_producer/features/user/invoice/pdf_templates/pdf_constants/pdf_constants.dart';
import 'package:invoice_producer/features/user/invoice/pdf_templates/pdf_format_two/widgets/pay_button.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

import '../../../../../../core/enums/account_type.dart';
import '../../../../../../core/enums/currency_sign_enum.dart';
import '../../../../../../models/invoice_model/invoice_model.dart';
import '../../../../../../utils/constants/app_constants.dart';
import '../../../../../../utils/constants/font_manager.dart';
import '../../pdf_file_format_one/pdf_widgets/build_bank_detail.dart';

Widget buildTotal(InVoiceModel invoice) {
  final currency = getCurrencySymbol(invoice.currency?.name);
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 30.w,vertical: 55.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            invoice.paymentAccount?.accountType == AccountTypeEnum.bank ?
            buildBankDetail(payment: invoice.paymentAccount)
                : buildPayButton(color: PdfColors.red),
        Padding(
        padding: EdgeInsets.all(
            4.r),
        child: Row(children: [
          Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
            SizedBox(height: 4.h),
            Text('Total:  ',
                style: TextStyle(
                    color: PdfConstants.pdfFiveTextCol,
                    fontSize: MyFonts.size13,
                    fontWeight: FontWeight.normal)),
            SizedBox(height: 4.h),
            Text('Paid:  ',
                style: TextStyle(
                    color: PdfConstants.pdfFiveTextCol,
                    fontSize: MyFonts.size13,
                    fontWeight: FontWeight.normal)),
            // SizedBox(height: 4.h),
            Container(
                height: 1.5.h,
                width: 90.w,
                margin: EdgeInsets.symmetric(vertical: 14.h),
                color: PdfColors.grey300
            ),
            Text('Balance Due:',
                style: TextStyle(
                    color: PdfConstants.pdfFiveTextCol,
                    fontSize: MyFonts.size18,
                    fontWeight: FontWeight.bold)),
          ]),
          //SizedBox(width: 8.w),
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
            // SizedBox(height: 4.h),
            Container(
                height: 1.5.h,
                width: 90.w,
                margin: EdgeInsets.symmetric(vertical: 14.h),
                color: PdfColors.grey300,
            ),
            Text('$currency${invoice.dueBalance ?? 0}',
                style: TextStyle(
                    color: PdfConstants.pdfFiveTextCol,
                    fontSize: MyFonts.size18,
                    fontWeight: FontWeight.bold)),
          ]),
        ]),
      )]));
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

// formatPrice(double price) => '\$ ${price.toStringAsFixed(2)}';
