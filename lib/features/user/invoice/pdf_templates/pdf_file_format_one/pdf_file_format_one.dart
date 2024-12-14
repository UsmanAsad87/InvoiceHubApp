import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:invoice_producer/features/user/invoice/api/pdf_api.dart';
import 'package:invoice_producer/features/user/invoice/pdf_templates/pdf_constants/pdf_constants.dart';
import 'package:invoice_producer/features/user/invoice/pdf_templates/pdf_file_format_one/pdf_widgets/build_bank_detail.dart';
import 'package:invoice_producer/features/user/invoice/pdf_templates/pdf_file_format_one/pdf_widgets/build_invoice.dart';
import 'package:invoice_producer/features/user/invoice/pdf_templates/pdf_file_format_one/pdf_widgets/build_signature.dart';
import 'package:invoice_producer/features/user/invoice/pdf_templates/pdf_file_format_one/pdf_widgets/build_thank_you.dart';
import 'package:invoice_producer/features/user/invoice/pdf_templates/pdf_file_format_one/pdf_widgets/build_total.dart';
import 'package:invoice_producer/features/user/invoice/pdf_templates/pdf_file_format_one/pdf_widgets/footer_container.dart';
import 'package:invoice_producer/features/user/invoice/pdf_templates/pdf_file_format_one/pdf_widgets/header.dart';
import 'package:invoice_producer/models/invoice_model/invoice_model.dart';
import 'package:invoice_producer/utils/constants/assets_manager.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';
import '../../../../../core/enums/account_type.dart';
import '../pdf_format_two/widgets/pay_button.dart';

class PdfFileFormatOne {
  static Future<File> generate(
      {required InVoiceModel invoice,
      required PdfColor color,
        required WidgetRef ref,
        String? imagePath}) async {
    final fallbackFontByteData  = await rootBundle.load("assets/fonts/arial.ttf");
    final fallbackFontByteData2  = await rootBundle.load("assets/fonts/Durga_Bold.ttf");

    final pdf = Document(
      theme: pw.ThemeData.withFont(
      fontFallback:  [
        Font.ttf(fallbackFontByteData),
        Font.ttf(fallbackFontByteData2),
      ],
    ),);

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

    Uint8List? signature = invoice.signature != null ?  (await NetworkAssetBundle(Uri.parse(invoice.image!))
            .load(invoice.signature?.image ?? ''))
        .buffer
        .asUint8List(): null;

    Uint8List location =
        await PdfConstants.convertAssetToUnit8(AppAssets.locationIconImage);

    Uint8List contact =
        await PdfConstants.convertAssetToUnit8(AppAssets.contactIconImage);

    Uint8List mail =
        await PdfConstants.convertAssetToUnit8(AppAssets.mailIconImage);

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
        SizedBox(height: .3.h * PdfPageFormat.cm),
        buildInvoice(invoice: invoice, color: PdfConstants.pdfOneHeaderCol),
        Row(children: [
          buildTankYou(
              color: PdfConstants.pdfOneHeaderCol,
              termsAndCond: invoice.termsAndCond),
          buildTotal(invoice: invoice, ref: ref,),
        ]),
        Row(children: [
          invoice.paymentAccount?.accountType == AccountTypeEnum.bank
              ? buildBankDetail(payment: invoice.paymentAccount)
              : buildPayButton(color: PdfConstants.pdfOneHeaderCol),
          Expanded(flex: 1, child: buildSignature(signature)),
        ])
      ],
      footer: (context) => buildFooter(
          invoice: invoice,
          imageData: imageData,
          locationIcon: location,
          contactIcon: contact,
          mailIcon: mail),
    ));
    return PdfApi.saveDocument(name: 'my_invoice.pdf', pdf: pdf);
  }

  static pw.Widget buildFooter({
    required InVoiceModel invoice,
    Uint8List? imageData,
    Uint8List? locationIcon,
    Uint8List? contactIcon,
    Uint8List? mailIcon,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
            flex: 1,
            child: Container(
                color: PdfConstants.pdfOneHeaderCol,
                padding: EdgeInsets.all(12.r),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    buildFooterContainer(
                        text: invoice.company!.street,
                        locationIcon: locationIcon),
                    Row(children: [
                      Container(
                        height: 30.h,
                        width: 2.w,
                        margin: EdgeInsets.only(right: 15.w, left: 30.w),
                        decoration: const BoxDecoration(
                          color: PdfColors.white,
                        ),
                      ),
                      buildFooterContainer(
                          text: invoice.company!.phoneNo,
                          locationIcon: contactIcon),
                      Container(
                        height: 30.h,
                        width: 2.w,
                        margin: EdgeInsets.only(right: 30.w, left: 15.w),
                        decoration: const BoxDecoration(
                          color: PdfColors.white,
                        ),
                      ),
                    ]),
                    buildFooterContainer(
                        text: invoice.company!.websiteName,
                        locationIcon: mailIcon),
                  ],
                ))),
        Container(color: PdfColors.black, width: 200.w, height: 50.h)
      ],
    );
  }

  static formatPrice({required double price, required WidgetRef ref, required InVoiceModel invoice}) {
    // final dashBoardCtr = ref.watch(dashBoardNotifierCtr);
    return '${invoice.currency?.type} ${price.toStringAsFixed(2)}';
  }
}
