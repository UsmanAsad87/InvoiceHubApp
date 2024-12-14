import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:invoice_producer/features/user/invoice/pdf_templates/pdf_constants/pdf_constants.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import '../../../../../../utils/constants/font_manager.dart';
import '../../pdf_file_format_one/pdf_widgets/pdf_text.dart';

Widget buildDueButton({color,horizontalPad, text}) => Container(
    alignment: Alignment.centerLeft,
    padding: EdgeInsets.symmetric(horizontal: horizontalPad ?? 50.w, vertical: 10.h),
    color: color,
    child: pdfText(text: text , color: PdfColors.white, fontSize: MyFonts.size16));
