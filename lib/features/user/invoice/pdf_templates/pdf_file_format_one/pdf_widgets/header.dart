import 'dart:typed_data';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:invoice_producer/commons/common_functions/date_time_methods.dart';
import 'package:invoice_producer/features/user/invoice/pdf_templates/pdf_file_format_one/pdf_widgets/pdf_text.dart';
import 'package:invoice_producer/utils/constants/font_manager.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import '../../../../../../models/invoice_model/invoice_model.dart';
import '../../pdf_constants/pdf_constants.dart';

Widget buildHeader({required InVoiceModel invoice, Uint8List? companyLogo}) =>
    Column(
      children: [
        Stack(
            overflow: Overflow.visible,
            children: [
          Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.only(
                    right: 30.w, left: 20.w, top: 25.h, bottom: 25.h),
                color: PdfConstants.pdfOneHeaderCol,
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  if (companyLogo != null)
                    Image(MemoryImage(companyLogo), height: 80.h, width: 100.w)
                ]),
              ),
            ),
            Container(
                padding: EdgeInsets.only(
                    top: 40.h, left: 40.w, bottom: 10.h, right: 25.w),
                color: PdfColors.blue,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      pdfText(
                          text: 'INVOICE',
                          color: PdfColors.white,
                          fontSize: MyFonts.size40,
                          fontWeight: FontWeight.bold,
                      ),
                      pdfText(
                          text: invoice.company?.name,
                          color: PdfColors.white,
                          fontSize: MyFonts.size15,
                          fontWeight: FontWeight.bold,
                      ),
                      pdfText(
                          text: invoice.company?.city?.name,
                          color: PdfColors.white,
                          fontSize: MyFonts.size15,
                          fontWeight: FontWeight.bold,
                      ),
                      pdfText(
                          text: invoice.company?.city?.name,
                          color: PdfColors.white,
                          fontSize: MyFonts.size15,
                          fontWeight: FontWeight.normal,
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                    ]))
          ]),
        ]),
        Padding(
            padding: EdgeInsets.all(16.r),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(
                    width: 130.w,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text('Bill To',
                              style: TextStyle(
                                  color: PdfConstants.pdfOneHeaderCol,
                                  fontSize: MyFonts.size22,
                                  fontWeight: FontWeight.bold)),
                          Text(
                              invoice.customer?.name ?? '',
                              overflow: TextOverflow.visible,
                              style: TextStyle(
                                  color: PdfColors.black,
                                  fontSize: MyFonts.size26,
                                  fontWeight: FontWeight.bold)),
                          SizedBox(height: 4.h),
                          Text(invoice.customer?.billingAddress1 ?? '',
                              style: TextStyle(
                                  color: PdfColors.black,
                                  fontSize: MyFonts.size15,
                                  fontWeight: FontWeight.normal)),
                          Text(invoice.customer?.billingAddress2 ?? '',
                              style: TextStyle(
                                  color: PdfColors.black,
                                  fontSize: MyFonts.size15,
                                  fontWeight: FontWeight.normal)),
                          SizedBox(height: 4.h),
                          Text(invoice.customer?.country?.name ?? '',
                              style: TextStyle(
                                  color: PdfColors.black,
                                  fontSize: MyFonts.size14,
                                  fontWeight: FontWeight.normal)),
                        ]),
                  ),
                  SizedBox(width: 20.w),
                  Column(mainAxisAlignment: MainAxisAlignment.end, children: [
                    Row(children: [
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Invoice Number',
                                style: TextStyle(
                                    color: PdfColors.black,
                                    fontSize: MyFonts.size15,
                                    fontWeight: FontWeight.normal)),
                            Text('Date Issued',
                                style: TextStyle(
                                    color: PdfColors.black,
                                    fontSize: MyFonts.size15,
                                    fontWeight: FontWeight.normal)),
                            Text('Due Date',
                                style: TextStyle(
                                    color: PdfColors.black,
                                    fontSize: MyFonts.size15,
                                    fontWeight: FontWeight.normal)),
                          ]),
                      SizedBox(width: 8.w),
                      Column(children: [
                        SizedBox(
                            width: 100.h,
                            child: Text(invoice.invoiceNo ?? '',
                                style: TextStyle(
                                    color: PdfColors.black,
                                    fontSize: MyFonts.size15,
                                    fontWeight: FontWeight.normal))),
                        Text(formatDayMonthYear(invoice.issueDate),
                            style: TextStyle(
                                color: PdfColors.black,
                                fontSize: MyFonts.size15,
                                fontWeight: FontWeight.normal)),
                        Text(formatDayMonthYear(invoice.dueDate),
                            style: TextStyle(
                                color: PdfColors.black,
                                fontSize: MyFonts.size15,
                                fontWeight: FontWeight.normal)),
                      ]),
                    ]),
                  ]),
                  SizedBox(width: 20.w),
                  /// make it the working address
                  SizedBox(
                      width: 160.w,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(invoice.addressType?.type ?? '',
                                style: TextStyle(
                                    color: PdfConstants.pdfOneHeaderCol,
                                    fontSize: MyFonts.size22,
                                    fontWeight: FontWeight.bold)),
                            Text(invoice.addressLine1 ?? '',
                                style: TextStyle(
                                   color: PdfColors.black,
                                   fontSize: MyFonts.size15,
                                   fontWeight: FontWeight.normal,
                                )),
                            SizedBox(height: 4.h),
                            Text(invoice.addressLine2 ?? '',
                                style: TextStyle(
                                    color: PdfColors.black,
                                    fontSize: MyFonts.size15,
                                    fontWeight: FontWeight.normal)),
                  //           Text('Work Address',
                  //               style: TextStyle(
                  //                   color: PdfConstants.pdfOneHeaderCol,
                  //                   fontSize: MyFonts.size22,
                  //                   fontWeight: FontWeight.bold)),
                  //           Text(invoice.customer?.workingAddress1 ?? '',
                  //               style: TextStyle(
                  //                   color: PdfColors.black,
                  //                   fontSize: MyFonts.size15,
                  //                   fontWeight: FontWeight.normal)),
                  //           SizedBox(height: 4.h),
                  //           Text(invoice.customer?.workingAddress2 ?? '',
                  //               style: TextStyle(
                  //                   color: PdfColors.black,
                  //                   fontSize: MyFonts.size15,
                  //                   fontWeight: FontWeight.normal)),
                  //           SizedBox(height: 4.h),
                  //           Text(invoice.customer?.country ?? '',
                  //               style: TextStyle(
                  //                   color: PdfColors.black,
                  //                   fontSize: MyFonts.size15,
                  //                   fontWeight: FontWeight.normal)),
                          ])),
                ]))
        //   SizedBox(height: 2.h * PdfPageFormat.cm),
      ],
    );
