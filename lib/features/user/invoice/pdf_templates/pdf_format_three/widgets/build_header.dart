import 'dart:typed_data';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:invoice_producer/commons/common_functions/date_time_methods.dart';
import 'package:invoice_producer/core/enums/account_type.dart';
import 'package:invoice_producer/features/user/invoice/pdf_templates/pdf_file_format_one/pdf_widgets/pdf_text.dart';
import 'package:invoice_producer/features/user/invoice/pdf_templates/pdf_format_two/widgets/pay_button.dart';
import 'package:invoice_producer/utils/constants/font_manager.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import '../../../../../../models/invoice_model/invoice_model.dart';
import '../../pdf_constants/pdf_constants.dart';

Widget buildHeader({required InVoiceModel invoice, Uint8List? companyLogo}) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          if(companyLogo != null)
          Image(MemoryImage(companyLogo), height: 100.h, width: 100.w),
          SizedBox(width: 20.w),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(invoice.company?.name ?? '',
                style: TextStyle(
                    letterSpacing: 6.w,
                    color: PdfColors.black,
                    fontSize: MyFonts.size20,
                    fontWeight: FontWeight.normal)),
            Text(invoice.company!.companyType,
                style: TextStyle(
                    letterSpacing: 6.w,
                    color: PdfColors.black,
                    fontSize: MyFonts.size20,
                    fontWeight: FontWeight.normal)),
            SizedBox(height: 10.h,),
            Row(children: [
              pdfText(
                  text: 'office: ',
                  color: PdfColors.black,
                  fontSize: MyFonts.size14,
                  fontWeight: FontWeight.bold),
              pdfText(
                  text: invoice.company!.street,
                  color: PdfColors.black,
                  fontSize: MyFonts.size14,
                  fontWeight: FontWeight.normal),
            ]),
            SizedBox(height: 2.h),
          ]),
        ]),
        SizedBox(height: 20.h),
        Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Expanded(
              flex: 1,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Bill To:',
                        style: TextStyle(
                            color: PdfColors.black,
                            fontSize: MyFonts.size20,
                            fontWeight: FontWeight.bold)),
                    // Text('Safraz',
                    //     style: TextStyle(
                    //         color: PdfColors.black,
                    //         fontSize: MyFonts.size30,
                    //         fontWeight: FontWeight.bold)),

                    Text(invoice.customer?.name ?? '',
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
                    SizedBox(height: 20.h),
                    Text(invoice.addressType?.type ?? '',
                        style: TextStyle(
                            color: PdfConstants.pdfTwoCol,
                            fontSize: MyFonts.size22,
                            fontWeight: FontWeight.bold)),
                    Text(invoice.addressLine1 ?? '',//invoice.customer!.billingAddress1,
                        style: TextStyle(
                            color: PdfColors.black,
                            fontSize: MyFonts.size15,
                            fontWeight: FontWeight.normal)),
                    SizedBox(height: 4.h),
                    Text(invoice.addressLine2 ?? '', //invoice.customer!.billingAddress2,
                        style: TextStyle(
                            color: PdfColors.black,
                            fontSize: MyFonts.size15,
                            fontWeight: FontWeight.normal)),
                  ])),
          Container(
              alignment: Alignment.topRight,
              child:
                  Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                  child: pdfText(
                      text: 'INVOICE',
                      color: PdfConstants.pdfTwoCol,
                      fontSize: MyFonts.size48,
                      fontWeight: FontWeight.bold),
                ),
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
                  Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                    SizedBox(width: 100.h, child:
                    Text(invoice.invoiceNo ?? '',
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
              ])),
        ]),
      ],
    );
