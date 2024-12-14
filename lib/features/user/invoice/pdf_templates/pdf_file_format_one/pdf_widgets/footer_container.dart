
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:invoice_producer/features/user/invoice/pdf_templates/pdf_file_format_one/pdf_widgets/pdf_text.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

import '../../../../../../utils/constants/font_manager.dart';


  Widget buildFooterContainer({required text, required locationIcon}) {
    return Column(children: [
      Container(
          width: 20.w,
          height: 20.h,
          padding: EdgeInsets.all(4.r),
          margin: EdgeInsets.all(4.r),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: PdfColors.white,
          ),
        child: Center(child: Image(MemoryImage(locationIcon!),
            height: 15.h, width: 15.w, )),
      ),
      pdfText(
          text: text,
          color: PdfColors.white,
          fontSize: MyFonts.size11),
    ]);
  }

