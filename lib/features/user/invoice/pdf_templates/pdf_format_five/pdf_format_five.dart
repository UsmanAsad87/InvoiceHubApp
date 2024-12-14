import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:invoice_producer/features/user/invoice/api/pdf_api.dart';
import 'package:invoice_producer/features/user/invoice/pdf_templates/pdf_constants/pdf_constants.dart';
import 'package:invoice_producer/features/user/invoice/pdf_templates/pdf_format_five/widgets/build_invoice.dart';
import 'package:invoice_producer/features/user/invoice/pdf_templates/pdf_format_five/widgets/build_last_container.dart';
import 'package:invoice_producer/features/user/invoice/pdf_templates/pdf_format_five/widgets/build_thankyou_total.dart';
import 'package:invoice_producer/features/user/invoice/pdf_templates/pdf_format_five/widgets/footer.dart';
import 'package:invoice_producer/features/user/invoice/pdf_templates/pdf_format_five/widgets/pay_button.dart';
import 'package:invoice_producer/models/invoice_model/invoice_model.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';
import '../../../../../core/enums/account_type.dart';
import '../pdf_file_format_one/pdf_widgets/build_bank_detail.dart';
import '../pdf_format_Five/widgets/build_header.dart';

class PdfFormatFive{
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
      ),
    );

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
        buildThankYouTotal(invoice: invoice),
        invoice.paymentAccount?.accountType == AccountTypeEnum.bank ?
        buildBankDetail(payment: invoice.paymentAccount, leftPadding: 30.w)
            : PayButton(),
        SizedBox(height: .3.h * PdfPageFormat.cm),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.w),
          child: buildLastContainer(invoice: invoice, imageData: signature),
        ),
      ],
      footer: (context) => buildFooter()));

    return PdfApi.saveDocument(name: 'my_invoice.pdf', pdf: pdf);
  }
}
