import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:invoice_producer/core/enums/currency_sign_enum.dart';
import 'package:invoice_producer/features/user/invoice/pdf_templates/pdf_constants/pdf_constants.dart';
import 'package:invoice_producer/features/user/invoice/pdf_templates/pdf_format_four/widgets/build_due_button.dart';
import 'package:invoice_producer/features/user/invoice/pdf_templates/pdf_format_four/widgets/build_footer_row.dart';
import 'package:invoice_producer/features/user/invoice/pdf_templates/pdf_format_four/widgets/build_header.dart';
import 'package:invoice_producer/features/user/invoice/pdf_templates/pdf_format_four/widgets/build_invoice.dart';
import 'package:invoice_producer/features/user/invoice/pdf_templates/pdf_format_four/widgets/build_signature.dart';
import 'package:invoice_producer/features/user/invoice/pdf_templates/pdf_format_four/widgets/build_terms_and_cond.dart';
import 'package:invoice_producer/features/user/invoice/pdf_templates/pdf_format_two/widgets/pay_button.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import '../../../../../commons/common_imports/apis_commons.dart';
import '../../../../../core/enums/account_type.dart';
import '../../../../../models/invoice_model/invoice_model.dart';
import '../../../../../utils/constants/assets_manager.dart';
import '../../../../../utils/constants/font_manager.dart';
import '../../api/pdf_api.dart';
import '../pdf_file_format_one/pdf_widgets/build_bank_detail.dart';
import '../pdf_format_four/widgets/build_total.dart';

class PdfFormatFour {
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
      build: (context) {
        // final dashBoardCtr = ref.watch(dashBoardNotifierCtr);
        final currency = getCurrencySymbol(invoice.currency?.name);
        return [
          buildHeader(invoice: invoice, companyLogo: companyLogo),
          SizedBox(height: .2.h * PdfPageFormat.cm),
          buildInvoice(
              invoice: invoice,
              color: PdfConstants.pdfFourCol,
              padding: EdgeInsets.zero,
              ref: ref,
              headerTextCol: PdfColors.white),
          SizedBox(height: 1 * PdfPageFormat.cm),
          buildTotal(invoice),
          Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  invoice.paymentAccount?.accountType == AccountTypeEnum.bank
                      ? buildBankDetail(
                      payment: invoice.paymentAccount,
                      leftPadding: 0,
                      topPadding: 12.h)
                      : buildPayButton(
                      color: PdfConstants.pdfFourCol, margin: 0.0),
                  SizedBox(height: 1.h * PdfPageFormat.cm),
                  if(invoice.termsAndCond != '')
                    buildTermsAndCond(
                        color: PdfColors.black, termsAndCond: invoice.termsAndCond),
                ]),
                Column(children: [
                  buildDueButton(
                      color: PdfConstants.pdfFourCol,
                      text: 'Balance Due:      $currency ${(invoice.dueBalance ?? 00)}',
                      horizontalPad: 6.w),
                  SizedBox(height: .5.h * PdfPageFormat.cm),
                  buildSignature(
                      signature: signature, customerName: invoice.customer!.name),
                ]),
              ]),
        ];
      },
      footer: (context) => buildFooter(
          invoice: invoice,
          imageData: imageData,
          locationIcon: location,
          contactIcon: contact,
          mailIcon: mail),
    ));

    return PdfApi.saveDocument(name: 'my_invoice.pdf', pdf: pdf);
  }

  static Widget buildFooter({
    required InVoiceModel invoice,
    Uint8List? imageData,
    Uint8List? locationIcon,
    Uint8List? contactIcon,
    Uint8List? mailIcon,
  }) {
    return Container(
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: PdfConstants.pdfFourCol,
      ),
      child: Row(
        children: [
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('Thanks for business with us!',
                style:
                    TextStyle(color: PdfColors.white, fontSize: MyFonts.size8)),
            Text('we make easy for your problems.',
                style:
                    TextStyle(color: PdfColors.white, fontSize: MyFonts.size8)),
          ]),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10.w),
            width: 1.3.w,
            height: 20.h,
            color: PdfColors.white,
          ),
          buildFooterRow(text: invoice.company!.street, icon: locationIcon),
          buildFooterRow(text: invoice.company!.phoneNo, icon: contactIcon),
          buildFooterRow(text: invoice.company!.email, icon: mailIcon),
        ],
      ),
    );
  }
}
