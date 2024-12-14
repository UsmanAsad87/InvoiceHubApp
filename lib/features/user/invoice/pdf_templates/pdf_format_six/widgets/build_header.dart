import 'dart:typed_data';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:invoice_producer/commons/common_functions/date_time_methods.dart';
import 'package:invoice_producer/features/user/invoice/pdf_templates/pdf_file_format_one/pdf_widgets/pdf_text.dart';
import 'package:invoice_producer/utils/constants/font_manager.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import '../../../../../../core/enums/currency_sign_enum.dart';
import '../../../../../../models/invoice_model/invoice_model.dart';
import '../../pdf_constants/pdf_constants.dart';

Widget buildHeader({
  required InVoiceModel invoice,
  Uint8List? companyLogo,
}) =>
    Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      SizedBox(height: 2.h * PdfPageFormat.cm),
      Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.w),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              if(companyLogo != null) ...[
              Image(MemoryImage(companyLogo), height: 60.h, width: 70.w),
              SizedBox(width: 20.w)],
              pdfText(
                  text: invoice.company?.name,
                  color: PdfColors.black,
                  fontSize: MyFonts.size30,
                  fontWeight: FontWeight.bold),
            ]),
            pdfText(
                text: 'INVOICE',
                color: PdfColors.red,
                fontSize: MyFonts.size28,
                fontWeight: FontWeight.bold),
          ])),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 12.h),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('In Voice to:',
                  style: TextStyle(
                      color: PdfConstants.pdfSixTextCol,
                      fontSize: MyFonts.size15,
                      fontWeight: FontWeight.normal)),
              Text('${invoice.customer?.name}',
                  style: TextStyle(
                      color: PdfConstants.pdfSixTextCol,
                      fontSize: MyFonts.size18,
                      fontWeight: FontWeight.bold)),
              // Text('Accountant',
              //     style: TextStyle(
              //         color: PdfConstants.pdfSixTextCol,
              //         fontSize: MyFonts.size15,
              //         fontWeight: FontWeight.normal)),
            ]),
          ]),
          Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
            Text(
              'TOTAL:  ',
              style: TextStyle(
                  color: PdfConstants.pdfFiveTextCol,
                  fontSize: MyFonts.size18,
                  fontWeight: FontWeight.bold
              ),
            ),
            Text(
              '${getCurrencySymbol(invoice.currency?.name)} ${invoice.total}', //'${getCurrencySymbol(invoice.currency?.name)}${invoice.total}',
              style: TextStyle(
                  color: PdfConstants.pdfFiveTextCol,
                  fontSize: MyFonts.size23,
                  fontWeight: FontWeight.bold),
            ),
          ])
        ]),
      ),
      Container(
        height: 1.5.h,
        color: PdfColors.red,
      ),
      Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 10.h),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text('Address',
                      style: TextStyle(
                          color: PdfConstants.pdfSixTextCol,
                          fontSize: MyFonts.size18,
                          fontWeight: FontWeight.bold)),
                  Text(invoice.customer?.billingAddress1 ?? '',
                      style: TextStyle(
                          color: PdfConstants.pdfSixTextCol,
                          fontSize: MyFonts.size13,
                          fontWeight: FontWeight.normal)),
                  Text(invoice.customer?.billingAddress2 ?? '',
                      style: TextStyle(
                          color: PdfConstants.pdfSixTextCol,
                          fontSize: MyFonts.size13,
                          fontWeight: FontWeight.normal)),
                  Text('Call ${invoice.customer!.phoneNo}',
                      style: TextStyle(
                          color: PdfConstants.pdfSixTextCol,
                          fontSize: MyFonts.size13,
                          fontWeight: FontWeight.normal)),
                  Text('${invoice.customer!.email}',
                      style: TextStyle(
                          color: PdfConstants.pdfSixTextCol,
                          fontSize: MyFonts.size13,
                          fontWeight: FontWeight.normal)),
                ]),
                Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  customContainer(title: 'Invoice No', subtitle: '12222098'),
                  //subtitle: invoice.invoiceNo ?? ''),
                  customContainer(
                      title: 'Date Issued',
                      subtitle: formatDayMonthYear(invoice.issueDate)),
                  customContainer(
                      title: 'Due Date',
                      subtitle: formatDayMonthYear(invoice.dueDate)),
                ])
              ]))
    ]);

Widget customContainer({required String title, required String subtitle}) =>
    Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        width: 90.w,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(title,
              style: TextStyle(
                  color: PdfConstants.pdfSixTextCol,
                  fontSize: MyFonts.size12,
                  fontWeight: FontWeight.normal)),
          Text(subtitle,
              style: TextStyle(
                  color: PdfConstants.pdfSixTextCol,
                  fontSize: MyFonts.size12,
                  fontWeight: FontWeight.bold)),
        ]));
