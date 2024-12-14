import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:invoice_producer/features/user/invoice/pdf_templates/pdf_file_format_one/pdf_widgets/pdf_text.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

import '../../../../../../utils/constants/font_manager.dart';
import '../../pdf_constants/pdf_constants.dart';

Widget buildFooterRowContainer({required text, required icon}) {
  return Expanded(
      flex: 1,
      child: Container(
        padding: EdgeInsets.all(2.r),
        decoration: BoxDecoration(
            border: Border.all(width: 2.w, color: PdfConstants.pdfTwoCol)),
        child: Row(children: [
          Container(
            width: 20.w,
            height: 20.h,
            padding: EdgeInsets.all(4.r),
            margin: EdgeInsets.all(4.r),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: PdfConstants.pdfTwoCol,
            ),
            child: Center(
                child: Image(
              MemoryImage(icon),
              height: 12.h,
              width: 12.w,
            )),
          ),
          SizedBox(width: 100.w, child: Text(text))
        ]),
      ));
}
