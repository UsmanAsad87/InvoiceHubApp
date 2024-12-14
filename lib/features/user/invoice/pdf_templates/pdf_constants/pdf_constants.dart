import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:invoice_producer/utils/constants/assets_manager.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

class PdfConstants {
  static const PdfColor pdfOneHeaderCol = PdfColor.fromInt(0xFF023e6d);
  static const PdfColor pdfOneHeaderBlackCol = PdfColor.fromInt(0xFF07060c);
  static const PdfColor pdfTwoCol = PdfColor.fromInt(0xFFb0401b);
  static const PdfColor pdfThreeCol = PdfColor.fromInt(0xFFee5322);
  static const PdfColor pdfFourCol = PdfColor.fromInt(0xFF0b8278);
  static const PdfColor pdfFiveCol = PdfColor.fromInt(0xFF12b5d0);
  static const PdfColor pdfFiveTextCol = PdfColor.fromInt(0xFF2e3543);
  static const PdfColor pdfFiveTranCol = PdfColor.fromInt(0xFCC12b5d0);
  static const PdfColor pdfSixTextCol = PdfColor.fromInt(0xFF8c8385);




  static final padding = SizedBox(width: 8, height: 9);
  static final horizontalPadding = SizedBox(
    width: 8,
  );
  static final verticalPadding = SizedBox(
    height: 8,
  );

  convertAsset() async {
    final ByteData image = await rootBundle.load(AppAssets.customerIcon);
    return  (image).buffer.asUint8List();
  }

  static Future<Uint8List> convertAssetToUnit8(String iconImg) async {
    final ByteData image = await rootBundle.load(iconImg);
    return  (image).buffer.asUint8List();
  }
}
