import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

Widget buildFooterRow({required text, required icon}) {
  return Expanded(
      flex: 1,
      child: Container(
        padding: EdgeInsets.all(2.r),
        // decoration: BoxDecoration(
        //  border: Border.all(width: 2.w, color: PdfConstants.pdfTwoCol)),
        child: Row(children: [
          Center(
              child: Image(
            MemoryImage(icon!),
            height: 12.h,
            width: 12.w,
          )),
          SizedBox(width: 4.w),
          SizedBox(
              width: 80.w,
                  child: Text(text,
                      style: TextStyle(color: PdfColors.white, fontSize: 8.r)),)
        ]),
      ));
}
