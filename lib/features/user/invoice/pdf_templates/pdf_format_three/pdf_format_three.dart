import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:invoice_producer/features/user/invoice/pdf_templates/pdf_constants/pdf_constants.dart';
import 'package:invoice_producer/features/user/invoice/pdf_templates/pdf_format_three/widgets/build_header.dart';
import 'package:invoice_producer/features/user/invoice/pdf_templates/pdf_format_three/widgets/build_invoice.dart';
import 'package:invoice_producer/features/user/invoice/pdf_templates/pdf_format_three/widgets/build_total.dart';
import 'package:invoice_producer/features/user/invoice/pdf_templates/pdf_format_two/widgets/pay_button.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import '../../../../../commons/common_imports/apis_commons.dart';
import '../../../../../core/enums/account_type.dart';
import '../../../../../models/invoice_model/invoice_model.dart';
import '../../../../../utils/constants/font_manager.dart';
import '../../api/pdf_api.dart';
import '../pdf_file_format_one/pdf_widgets/build_bank_detail.dart';
import '../pdf_file_format_one/pdf_widgets/build_signature.dart';
import '../pdf_file_format_one/pdf_widgets/build_thank_you.dart';
import '../pdf_file_format_one/pdf_widgets/pdf_text.dart';

class PdfFormatThree {
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

    Uint8List? signature = invoice.signature != null ? (await NetworkAssetBundle(Uri.parse(invoice.image!))
            .load(invoice.signature!.image))
        .buffer
        .asUint8List(): null;

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
        buildHeader(invoice: invoice, companyLogo: companyLogo),
        SizedBox(height: 1 * PdfPageFormat.cm),
        buildInvoice(
          invoice: invoice,
          ref: ref
        ),
        SizedBox(height: 1.h * PdfPageFormat.cm),
        buildTotal(invoice),
        SizedBox(height: 1.h * PdfPageFormat.cm),
        Container(
            width: 250.w,
            child:
            invoice.paymentAccount?.accountType == AccountTypeEnum.bank ?
            buildBankDetail(payment: invoice.paymentAccount, leftPadding : 0)
                : buildPayButton(color: PdfConstants.pdfThreeCol, margin: 0.0)),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
          buildTankYou(
              color: PdfColors.black,
              termsAndCond: invoice.termsAndCond,
            horizontalPadding: 0
          ),
          buildSignature(signature)
        ]),
      ],
      footer: (context) => buildFooter(invoice, imageData),
    ));

    return PdfApi.saveDocument(name: 'my_invoice.pdf', pdf: pdf);
  }

  static Widget buildFooter(InVoiceModel invoice, [Uint8List? imageData]) {
    return Row(children: [
      Expanded(
          flex: 1,
          child: Container(
            padding: EdgeInsets.all(4.r),
            child: pdfText(
                text: 'web: ${invoice.company!.websiteName}',
                color: PdfConstants.pdfThreeCol,
                fontSize: MyFonts.size14),
          )),
      Expanded(
          flex: 1,
          child: Container(
            padding: EdgeInsets.all(4.r),
            child: pdfText(
                text: 'Info: ${invoice.company!.email}',
                color: PdfConstants.pdfThreeCol,
                fontSize: MyFonts.size14),
          )),
      Expanded(
          flex: 1,
          child: Container(
            padding: EdgeInsets.all(4.r),
            child: pdfText(
                text: 'phone: ${invoice.company!.phoneNo}',
                color: PdfConstants.pdfThreeCol,
                fontSize: MyFonts.size14),
          )),
    ]);
  }
}
