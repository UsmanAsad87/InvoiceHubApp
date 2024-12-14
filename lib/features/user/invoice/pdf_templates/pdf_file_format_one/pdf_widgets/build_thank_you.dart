import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:invoice_producer/features/user/invoice/pdf_templates/pdf_file_format_one/pdf_widgets/pdf_text.dart';
import 'package:invoice_producer/utils/constants/term_and_condition.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import '../../../../../../utils/constants/app_constants.dart';
import '../../../../../../utils/constants/font_manager.dart';

Widget buildTankYou({
  required PdfColor color,
  required String termsAndCond,
  double? horizontalPadding
}) =>
    Container(
        alignment: Alignment.centerLeft,
        child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding ?? AppConstants.padding,
                vertical: AppConstants.padding),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              SizedBox(height: 16.h),
              pdfText(
                  text: 'Thank You For Your Business',
                  color: PdfColors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: MyFonts.size20),
              SizedBox(height: 20.h),
              if (termsAndCond != '') ...[
                pdfText(
                    text: 'TERMS & CONDITIONS',
                    color: color,
                    fontWeight: FontWeight.bold,
                    fontSize: MyFonts.size20),
                SizedBox(height: 8.h),
                Container(
                    width: 320.w,
                    child: pdfText(
                        text: termsAndCond,
                        color: PdfColors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: MyFonts.size14)),
              ]
            ])));
