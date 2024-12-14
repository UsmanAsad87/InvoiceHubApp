import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:invoice_producer/features/user/invoice/pdf_templates/pdf_constants/pdf_constants.dart';
import 'package:invoice_producer/features/user/invoice/pdf_templates/pdf_file_format_one/pdf_widgets/pdf_text.dart';
import 'package:invoice_producer/utils/constants/term_and_condition.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import '../../../../../../utils/constants/app_constants.dart';
import '../../../../../../utils/constants/font_manager.dart';
Widget buildTankYou({required String termsAndCond}) => Expanded(child: Container(
    alignment: Alignment.centerLeft,
    decoration: const BoxDecoration(
      color: PdfConstants.pdfFiveTranCol,
    ),
    child: Padding(
        padding: EdgeInsets.all(12.r),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if(termsAndCond !=  '')
              ...[pdfText(text: 'TERMS & CONDITIONS / Rules',
                  color: PdfConstants.pdfFiveTextCol,
                  fontWeight: FontWeight.bold,
                  fontSize: MyFonts.size18),
              SizedBox(height: 8.h),
              Container(
                  width: 270.w,
                  child:pdfText(
                      text:
                      termsAndCond,
                      // 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod '
                      //     'tincidunt ut laoreet dolore magna aliquam'
                      //     'erat volutpat. Ut wisi',
                      color: PdfConstants.pdfFiveTextCol,
                      fontWeight: FontWeight.normal,
                      fontSize: MyFonts.size13)),
              SizedBox(height: 8.h),],
              pdfText(text: 'Thank You For Your Business',
                  color: PdfConstants.pdfFiveTextCol,
                  fontWeight: FontWeight.normal,
                  fontSize: MyFonts.size16),

            ]))));