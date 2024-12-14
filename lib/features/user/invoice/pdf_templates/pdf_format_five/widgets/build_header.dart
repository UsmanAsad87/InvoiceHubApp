import 'dart:typed_data';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:invoice_producer/commons/common_functions/date_time_methods.dart';
import 'package:invoice_producer/core/enums/currency_sign_enum.dart';
import 'package:invoice_producer/features/user/invoice/pdf_templates/pdf_file_format_one/pdf_widgets/pdf_text.dart';
import 'package:invoice_producer/utils/constants/font_manager.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import '../../../../../../models/invoice_model/invoice_model.dart';
import '../../pdf_constants/pdf_constants.dart';

Widget buildHeader({
  required InVoiceModel invoice,
  Uint8List? companyLogo,
}) =>
    Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Stack(children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: PdfConstants.pdfFiveTextCol,
              height: 70.h,
              width: double.infinity,
            ),
            Container(
              color: PdfConstants.pdfFiveCol,
              height: 15.h,
              width: double.infinity,
            ),
          ],
        ),
        Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.w),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    color: PdfConstants.pdfFiveTranCol,
                    width: 220.w,
                    height: 100.h,
                    child:
                        // Center(
                        //     child:
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                          if (companyLogo != null) ...[
                          Expanded(child:Image(MemoryImage(companyLogo),
                             height: 70.h, width: 70.w
                          ),)],
                          SizedBox(width: 20.w),
                          SizedBox(
                             width: 130.w,
                              child: pdfText(
                                  text: invoice.company?.name,
                                  color: PdfColors.white,
                                  fontSize: MyFonts.size30,
                                  fontWeight: FontWeight.bold)),
                        ]
// )
                            ),
                  ),
                  pdfText(
                      text: 'INVOICE',
                      color: PdfColors.white,
                      fontSize: MyFonts.size30,
                      fontWeight: FontWeight.bold),
                ]))
      ]),
      SizedBox(height: .5.h * PdfPageFormat.cm),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 10.h),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('To: ${invoice.customer?.name}',
                  style: TextStyle(
                      color: PdfConstants.pdfFiveTextCol,
                      fontSize: MyFonts.size18,
                      fontWeight: FontWeight.bold)),
              SizedBox(height: 4.h),
              Text(invoice.customer?.billingAddress1 ?? '',
                  style: TextStyle(
                      color: PdfConstants.pdfFiveTextCol,
                      fontSize: MyFonts.size13,
                      fontWeight: FontWeight.normal)),
              SizedBox(height: 4.h),
              Text(invoice.customer?.billingAddress2 ?? '',
                  style: TextStyle(
                      color: PdfConstants.pdfFiveTextCol,
                      fontSize: MyFonts.size13,
                      fontWeight: FontWeight.normal)),
              Row(children: [
                Text('Phone',
                    style: TextStyle(
                        color: PdfConstants.pdfFiveTextCol,
                        fontSize: MyFonts.size13,
                        fontWeight: FontWeight.bold)),
                SizedBox(width: 2.w),
                Text(invoice.customer?.phoneNo ?? '',
                    style: TextStyle(
                        color: PdfConstants.pdfFiveTextCol,
                        fontSize: MyFonts.size13,
                        fontWeight: FontWeight.normal)),
              ]),
            ]),
            Container(
                margin: EdgeInsets.symmetric(horizontal: 10.w),
                width: 1.w,
                height: 100.h,
                color: PdfConstants.pdfFiveCol),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Invoice Details',
                  style: TextStyle(
                      color: PdfConstants.pdfFiveTextCol,
                      fontSize: MyFonts.size18,
                      fontWeight: FontWeight.bold)),
              SizedBox(height: 4.h),
              SizedBox(
                  width: 130.h,
                  child: Text('InvoiceNo: #${invoice.invoiceNo}',
                      style: TextStyle(
                          color: PdfConstants.pdfFiveTextCol,
                          fontSize: MyFonts.size13,
                          fontWeight: FontWeight.normal))),
              Text('Date Issued: ${formatDayMonthYear(invoice.issueDate)}',
                  style: TextStyle(
                      color: PdfConstants.pdfFiveTextCol,
                      fontSize: MyFonts.size13,
                      fontWeight: FontWeight.normal)),
              Text('Due Date: ${formatDayMonthYear(invoice.dueDate)}',
                  style: TextStyle(
                      color: PdfColors.black,
                      fontSize: MyFonts.size13,
                      fontWeight: FontWeight.normal)),
            ])
          ]),
          Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
            Text(
              'TOTAL DUE',
              style: TextStyle(
                  color: PdfConstants.pdfFiveTextCol,
                  fontSize: MyFonts.size18,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              '${getCurrencySymbol(invoice.currency?.name)}${invoice.dueBalance}',
              style: TextStyle(
                  color: PdfConstants.pdfFiveTextCol,
                  fontSize: MyFonts.size23,
                  fontWeight: FontWeight.bold),
            ),
          ])
        ]),
      ),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 10.h),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(invoice.addressType?.type ?? '',
              style: TextStyle(
                  color: PdfConstants.pdfTwoCol,
                  fontSize: MyFonts.size22,
                  fontWeight: FontWeight.bold)),
          Text(invoice.addressLine1 ?? '',
              style: TextStyle(
                  color: PdfColors.black,
                  fontSize: MyFonts.size15,
                  fontWeight: FontWeight.normal)),
          SizedBox(height: 4.h),
          Text(invoice.addressLine2 ?? '',
              style: TextStyle(
                  color: PdfColors.black,
                  fontSize: MyFonts.size15,
                  fontWeight: FontWeight.normal)),
        ]),
      )
    ]);
