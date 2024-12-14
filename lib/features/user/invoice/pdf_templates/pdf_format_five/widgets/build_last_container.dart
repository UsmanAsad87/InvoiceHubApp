import 'dart:typed_data';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pdf/widgets.dart';

import '../../../../../../models/invoice_model/invoice_model.dart';
import '../../../../../../utils/constants/font_manager.dart';
import '../../pdf_constants/pdf_constants.dart';


Widget buildLastContainer({
  required InVoiceModel invoice,
  Uint8List? imageData,
}) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.end,
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      item(title: 'Phone',subtitle: invoice.company!.phoneNo),
      item(title: 'Email',subtitle: invoice.company!.email),
      item(title: 'Address',subtitle: invoice.company!.street),
      Column(
          children: [
            imageData!= null?
            Image(MemoryImage(imageData), height: 70.h, width: 100.w): SizedBox(height: 70.h),
            Text('Authorised Sign',
                style: TextStyle(
                    color: PdfConstants.pdfFiveTextCol,
                    fontSize: MyFonts.size16,
                    fontWeight: FontWeight.bold))
          ])
    ],
  );
}

Widget item({required title, required subtitle}) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(title,
          style: TextStyle(
              color: PdfConstants.pdfFiveTextCol,
              fontSize: MyFonts.size13,
              fontWeight: FontWeight.bold)),
      Padding(
          padding: EdgeInsets.symmetric(vertical: 2.h),
          child: Text(subtitle,
              style: TextStyle(
                  color: PdfConstants.pdfFiveTextCol,
                  fontSize: MyFonts.size13,
                  fontWeight: FontWeight.normal))),
      Container(
        width: 30.w,
        height: 1.3.h,
        decoration: BoxDecoration(
            color: PdfConstants.pdfFiveTextCol,
            borderRadius: BorderRadius.circular(1.r)
        ),),
      SizedBox(height: 4.h),
    ]
);