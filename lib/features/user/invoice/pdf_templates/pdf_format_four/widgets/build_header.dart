import 'dart:typed_data';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:invoice_producer/commons/common_functions/date_time_methods.dart';
import 'package:invoice_producer/features/user/invoice/pdf_templates/pdf_file_format_one/pdf_widgets/pdf_text.dart';
import 'package:invoice_producer/features/user/invoice/pdf_templates/pdf_format_two/widgets/pay_button.dart';
import 'package:invoice_producer/utils/constants/font_manager.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import '../../../../../../models/invoice_model/invoice_model.dart';
import '../../pdf_constants/pdf_constants.dart';

Widget buildHeader({required InVoiceModel invoice, Uint8List? companyLogo}) =>
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(children: [
              if(companyLogo != null) ...[
              Image(MemoryImage(companyLogo), height: 55.h, width: 60.w),
              SizedBox(width: 10.w)],
              SizedBox(
              width: 200.w,
              child: FittedBox(
                  // width: 250.w,
                alignment: AlignmentDirectional.centerStart,
                fit: BoxFit.scaleDown,
                  child: pdfText(
                  text: invoice.company!.name,
                  color: PdfColors.black,
                  fontSize: MyFonts.size28,
                  fontWeight: FontWeight.bold),)),
            ]),
            Padding(
                padding: EdgeInsets.symmetric(vertical: 12.h),
                child: pdfText(
                    text: 'INVOICE',
                    color: PdfColors.black,
                    fontSize: MyFonts.size34,
                    fontWeight: FontWeight.bold),
              ),
          ],
        ),
        SizedBox(height: 10.h),
        Container(
          padding: EdgeInsets.all(16.h),
          decoration: const BoxDecoration(
            color: PdfColors.grey200,
          ),
          child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 70.w,
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text('Billed to: ',
                      style: TextStyle(
                          color: PdfColors.black,
                          fontSize: MyFonts.size12,
                          fontWeight: FontWeight.bold)),
                  SizedBox(height: 12.h),
                  Text(invoice.customer!.name,
                      style: TextStyle(
                          color: PdfColors.black,
                          fontSize: MyFonts.size18,
                          fontWeight: FontWeight.bold)),
                  SizedBox(height: 8.h),
                  Text(invoice.customer!.companyName,
                      style: TextStyle(
                          color: PdfColors.black,
                          fontSize: MyFonts.size8,
                          fontWeight: FontWeight.normal)),
                ]),),
                SizedBox(
                    width: 130.w,
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text('Address:',
                      style: TextStyle(
                          color: PdfColors.black,
                          fontSize: MyFonts.size12,
                          fontWeight: FontWeight.bold)),
                  SizedBox(height: 12.h),
                  Text(invoice.customer!.billingAddress1,
                      style: TextStyle(
                          color: PdfColors.black,
                          fontSize: MyFonts.size10,
                          fontWeight: FontWeight.normal)),
                  SizedBox(height: 4.h),
                  Text(
                      invoice.customer!.billingAddress2,
                      style: TextStyle(
                          color: PdfColors.black,
                          fontSize: MyFonts.size10,
                          fontWeight: FontWeight.normal)),
                  SizedBox(height: 4.h),
                  Text(invoice.customer?.country?.name ?? '',
                      style: TextStyle(
                          color: PdfColors.black,
                          fontSize: MyFonts.size10,
                          fontWeight: FontWeight.normal)),
                ])),
                SizedBox(
                    width: 70.w,
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text('Total Due: ',
                      style: TextStyle(
                          color: PdfColors.black,
                          fontSize: MyFonts.size12,
                          fontWeight: FontWeight.bold)),
                  SizedBox(height: 12.h),
                  Text('\$${invoice.dueBalance ?? 00}',
                      style: TextStyle(
                          color: PdfColors.black,
                          fontSize: MyFonts.size18,
                          fontWeight: FontWeight.bold)),
                  SizedBox(height: 8.h),
                ])),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  SizedBox(
                    width: 140.w,
                    child: Text('Invoice Number: ${invoice.invoiceNo ?? ''}',
                        style: TextStyle(
                            color: PdfColors.black,
                            fontSize: MyFonts.size15,
                            fontWeight: FontWeight.normal)),
                  ),
                  Text('Date Issued: ${formatDayMonthYear(invoice.issueDate)}',
                      style: TextStyle(
                          color: PdfColors.black,
                          fontSize: MyFonts.size15,
                          fontWeight: FontWeight.normal)),
                  Text('Due Date: ${formatDayMonthYear(invoice.dueDate)}',
                      style: TextStyle(
                          color: PdfColors.black,
                          fontSize: MyFonts.size15,
                          fontWeight: FontWeight.normal)),
                ]),
              ]),
        ),
      ],
    );
