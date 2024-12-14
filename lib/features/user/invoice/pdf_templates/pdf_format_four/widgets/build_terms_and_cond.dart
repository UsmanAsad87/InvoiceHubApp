import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:invoice_producer/features/user/invoice/pdf_templates/pdf_file_format_one/pdf_widgets/pdf_text.dart';
import 'package:invoice_producer/utils/constants/term_and_condition.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import '../../../../../../utils/constants/app_constants.dart';
import '../../../../../../utils/constants/font_manager.dart';
Widget buildTermsAndCond({required PdfColor color,required String termsAndCond}) => Container(
    alignment: Alignment.centerLeft,
    child: Padding(
        padding: EdgeInsets.all(AppConstants.padding),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 12.h),
              pdfText(text: 'TERMS & CONDITIONS',
                  color: color,
                  fontWeight: FontWeight.bold,
                  fontSize: MyFonts.size20),
              SizedBox(height: 8.h),
              Container(
                  width: 200.w,
                  child:pdfText(
                      text: termsAndCond,
                      // 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod '
                      //     'tincidunt ut laoreet dolore magna aliquam'
                      //     'erat volutpat. Ut wisi',
                      color: PdfColors.black,
                      fontWeight: FontWeight.normal,
                      fontSize: MyFonts.size8)),

            ])));