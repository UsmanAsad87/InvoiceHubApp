import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:invoice_producer/models/payment_account_model/payment_account_model.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

import '../../../../../../utils/constants/font_manager.dart';

Widget buildBankDetail(
        {PaymentAccountModel? payment,
        double? leftPadding,
        double? topPadding}) =>
    payment == null ? SizedBox() : Padding(
        padding:
            EdgeInsets.only(left: leftPadding ?? 12.w, top: topPadding ?? 0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
          Text('Bank details',
              style: TextStyle(
                  color: PdfColors.black,
                  fontSize: MyFonts.size18,
                  fontWeight: FontWeight.bold)),
          Row(children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Account Number',
                  style: TextStyle(
                      color: PdfColors.black,
                      fontSize: MyFonts.size15,
                      fontWeight: FontWeight.normal)),
              Text('Account Holder',
                  style: TextStyle(
                      color: PdfColors.black,
                      fontSize: MyFonts.size15,
                      fontWeight: FontWeight.normal)),
              Text('Bank Name',
                  style: TextStyle(
                      color: PdfColors.black,
                      fontSize: MyFonts.size15,
                      fontWeight: FontWeight.normal)),
              Text('Sort Code',
                  style: TextStyle(
                      color: PdfColors.black,
                      fontSize: MyFonts.size15,
                      fontWeight: FontWeight.normal)),
            ]),
            SizedBox(width: 8.w),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(payment.accountNo ?? '',
                  style: TextStyle(
                      color: PdfColors.black,
                      fontSize: MyFonts.size15,
                      fontWeight: FontWeight.normal)),
              Text(payment.holderName,
                  style: TextStyle(
                      color: PdfColors.black,
                      fontSize: MyFonts.size15,
                      fontWeight: FontWeight.normal)),
              Text(payment.bankName,
                  style: TextStyle(
                      color: PdfColors.black,
                      fontSize: MyFonts.size15,
                      fontWeight: FontWeight.normal)),
              Text(payment.sortCode,
                  style: TextStyle(
                      color: PdfColors.black,
                      fontSize: MyFonts.size15,
                      fontWeight: FontWeight.normal)),
            ]),
          ])
        ]));
