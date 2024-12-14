import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:invoice_producer/features/user/invoice/pdf_templates/pdf_constants/pdf_constants.dart';
import 'package:invoice_producer/features/user/invoice/pdf_templates/pdf_format_two/widgets/build_header.dart';
import 'package:invoice_producer/features/user/invoice/pdf_templates/pdf_format_two/widgets/build_total.dart';
import 'package:invoice_producer/features/user/invoice/pdf_templates/pdf_format_two/widgets/footer_row_container.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import '../../../../../commons/common_imports/apis_commons.dart';
import '../../../../../models/invoice_model/invoice_model.dart';
import '../../../../../utils/constants/assets_manager.dart';
import '../../api/pdf_api.dart';
import '../pdf_file_format_one/pdf_widgets/build_invoice.dart';
import '../pdf_file_format_one/pdf_widgets/build_signature.dart';
import '../pdf_file_format_one/pdf_widgets/build_thank_you.dart';

class PdfFormatTwo {
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

    Uint8List? signature = invoice.signature != null ?  (await NetworkAssetBundle(Uri.parse(invoice.image!))
            .load(invoice.signature!.image))
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
        buildForeground: (context) {
          return imagePath == null
              ? Container()
              : Center(
                  child: Container(
                      width: 150.w,
                      height: 150.h,
                      child: Image(MemoryImage(imageData!))));
        },
        buildBackground: (context) => FullPage(
          ignoreMargins: true,
          child: Container(color: color),
        ),
      ),
      build: (context) => [
        buildHeader(invoice, companyLogo),
        SizedBox(height: 1.h * PdfPageFormat.cm),
        buildInvoice(
            invoice: invoice,
            color: PdfConstants.pdfTwoCol,
            padding: EdgeInsets.zero,
            headerTextCol: PdfColors.white),
        SizedBox(height: 1 * PdfPageFormat.cm),
        buildTotal(invoice),
        Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
          buildTankYou(
              color: PdfConstants.pdfTwoCol,
              termsAndCond: invoice.termsAndCond),
          buildSignature(signature)
        ]),
      ],
      footer: (context) => buildFooter(
          invoice: invoice,
          // imageData: imageData,
          locationIcon: location,
          contactIcon: contact,
          mailIcon: mail),
    ));

    return PdfApi.saveDocument(name: 'my_invoice.pdf', pdf: pdf);
  }

  static Widget buildFooter({
    required InVoiceModel invoice,
    Uint8List? locationIcon,
    Uint8List? contactIcon,
    Uint8List? mailIcon,
  }) {
    return Row(children: [
      buildFooterRowContainer(
          text: invoice.company!.street, icon: locationIcon),
      buildFooterRowContainer(
          text: invoice.company!.phoneNo, icon: contactIcon),
      buildFooterRowContainer(text: invoice.company!.email, icon: mailIcon),
    ]);
  }
}
