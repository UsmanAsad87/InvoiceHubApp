import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:invoice_producer/features/user/invoice/pdf_templates/pdf_file_format_one/pdf_file_format_one.dart';
import 'package:invoice_producer/features/user/invoice/pdf_templates/pdf_format_five/pdf_format_five.dart';
import 'package:invoice_producer/features/user/invoice/pdf_templates/pdf_format_two/pdf_format_two.dart';
import 'package:invoice_producer/features/user/invoice/pdf_templates/pdf_format_three/pdf_format_three.dart';
import 'package:invoice_producer/models/invoice_model/invoice_model.dart';
import 'package:pdf/pdf.dart';

import '../../../pdf_templates/pdf_format_four/pdg_format_four.dart';
import '../../../pdf_templates/pdf_format_six/pdf_format_six.dart';

class PdfGenerator {
  static Future<File> generatePdf(
      {required int index,
      required InVoiceModel invoice,
        required WidgetRef ref,
      required PdfColor color,
      String? watermark}) async {
    switch (index) {
      case 0:
        return PdfFileFormatOne.generate(
            ref: ref,
            invoice: invoice,color: color, imagePath: watermark);
      case 1:
        return PdfFormatTwo.generate(
            ref: ref,
            invoice: invoice,color: color,imagePath: watermark);
      case 2:
        return PdfFormatThree.generate(
            ref: ref,
            invoice: invoice,color: color,imagePath: watermark);
      case 3:
        return PdfFormatFour.generate(
            ref: ref,
            invoice: invoice,
            color: color,imagePath: watermark);
        case 4:
        return PdfFormatFive.generate(
            invoice: invoice,
            color: color,
            imagePath: watermark,
          ref: ref
        );
        case 5:
        return PdfFormatSix.generate(
            ref: ref,
            invoice: invoice,color: color,imagePath: watermark);
      default:
        throw Exception("Invalid PDF index");
    }
  }
}
