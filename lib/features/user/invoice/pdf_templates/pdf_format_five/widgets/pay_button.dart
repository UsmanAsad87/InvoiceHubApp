import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pdf/widgets.dart';

import '../../pdf_constants/pdf_constants.dart';
import '../../pdf_format_two/widgets/pay_button.dart';

Widget PayButton() =>  Container(
    width: 250.w,
    padding: EdgeInsets.symmetric(horizontal: 30.w),
    child: buildPayButton(
        margin: 0.0,
        color: PdfConstants.pdfFiveCol));