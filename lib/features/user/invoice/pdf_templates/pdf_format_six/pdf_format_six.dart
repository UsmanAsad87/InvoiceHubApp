import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:invoice_producer/features/user/invoice/api/pdf_api.dart';
import 'package:invoice_producer/features/user/invoice/pdf_templates/pdf_constants/pdf_constants.dart';
import 'package:invoice_producer/models/invoice_model/invoice_model.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';
import '../../../../../commons/common_imports/apis_commons.dart';
import '../../../../../utils/constants/font_manager.dart';
import '../pdf_format_Six/widgets/build_invoice.dart';
import '../pdf_format_Six/widgets/build_total.dart';
import '../pdf_format_six/widgets/build_header.dart';


class PdfFormatSix {
  static Future<File> generate(
      {required InVoiceModel invoice,
      required PdfColor color,
      required WidgetRef ref,
        String? imagePath}) async {

    final fallbackFontByteData  = await rootBundle.load("assets/fonts/arial.ttf");
    final fallbackFontByteData2  = await rootBundle.load("assets/fonts/Durga_Bold.ttf");

    final pdf = Document(
      theme: ThemeData.withFont(
        fontFallback:  [
          Font.ttf(fallbackFontByteData),
          Font.ttf(fallbackFontByteData2),
        ],
      ),);

    // final pdf = Document();

    Uint8List? imageData;

    if (imagePath != null) {
      final ByteData image = await rootBundle.load(imagePath ?? '');
      imageData = (image).buffer.asUint8List();
    }

    Uint8List? companyLogo;

    if (invoice.image != '') {
      companyLogo = (await NetworkAssetBundle(Uri.parse(invoice.image!))
          .load(invoice.image!))
          .buffer
          .asUint8List();
    }

    Uint8List? signature = invoice.signature != null ? (
        await NetworkAssetBundle(Uri.parse(invoice.image!))
        .load(invoice.signature!.image)
    ).buffer.asUint8List(): null;

    pdf.addPage(MultiPage(
        pageTheme: PageTheme(
          pageFormat: PdfPageFormat.a4,
          margin: EdgeInsets.zero,
          buildForeground: (context) {
            return imagePath == null
                ? Container()
                : Center(
                    child: Container(
                        width: 150.w,
                        height: 150.h,
                        child: pw.Image(pw.MemoryImage(imageData!))));
          },
          buildBackground: (context) => pw.FullPage(
            ignoreMargins: true,
            child: pw.Container(color: color),
          ),
        ),
        build: (context) => [
              buildHeader(invoice: invoice, companyLogo: companyLogo),
              SizedBox(height: .1.h * PdfPageFormat.cm),
              buildInvoice(
                  invoice: invoice,
                  color: PdfConstants.pdfFiveCol,
                ref: ref
              ),
              buildTotal(invoice),
              SizedBox(height: .3.h * PdfPageFormat.cm),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.w),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      item(title: 'Phone', subtitle: invoice.company!.phoneNo),
                      item(title: 'Email', subtitle: invoice.company!.email),
                      item(title: 'Address', subtitle: invoice.company!.street),
                      Column(children: [
                        signature != null ? Image(MemoryImage(signature!),
                            height: 70.h, width: 100.w): SizedBox(height: 70.h),
                        Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 10.h, horizontal: 8.w),
                            // padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 8.w),
                            width: 130.w,
                            height: 1.h,
                            color: PdfColors.black),
                        Text('Authorised Sign',
                            style: TextStyle(
                                color: PdfConstants.pdfFiveTextCol,
                                fontSize: MyFonts.size16,
                                fontWeight: FontWeight.bold)),
                      ])
                    ],
                  ))
            ],
        footer: (context) => Container(
            color: PdfConstants.pdfFiveTextCol,
            padding: EdgeInsets.all(18.r),
            child: Row(children: [
              if(invoice.termsAndCond != '')
              ...[Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                Text('Terms and Conditions ',
                    style: TextStyle(
                        color: PdfColors.white,
                        fontSize: MyFonts.size16,
                        fontWeight: FontWeight.bold)),
                SizedBox(height: 10.h),
                SizedBox(
                    width: 500.w,
                    child: Text(invoice.termsAndCond,
                    style: TextStyle(
                        color: PdfColors.white,
                        fontSize: MyFonts.size13,
                        fontWeight: FontWeight.normal))),
              ])]
            ]))));

    return PdfApi.saveDocument(name: 'my_invoice.pdf', pdf: pdf);
  }
  static item({required title, required subtitle}) =>
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(title,
            style: TextStyle(
                color: PdfConstants.pdfFiveTextCol,
                fontSize: MyFonts.size13,
                fontWeight: FontWeight.bold)),
        Padding(
            padding: EdgeInsets.symmetric(vertical: 2.h),
            child: Text(subtitle,
                style: TextStyle(
                    color: PdfConstants.pdfFiveTextCol,
                    fontSize: MyFonts.size13,
                    fontWeight: FontWeight.normal))),
      ]);

  static formatPrice(double price) => '\$ ${price.toStringAsFixed(2)}';
}
