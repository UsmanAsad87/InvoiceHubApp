import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:invoice_producer/features/user/invoice/pdf_templates/pdf_format_five/widgets/build_thank_you.dart';
import 'package:invoice_producer/models/invoice_model/invoice_model.dart';
import 'package:pdf/widgets.dart';
import '../../pdf_format_Five/widgets/build_total.dart';

Widget buildThankYouTotal({required InVoiceModel invoice}) => Padding(
    padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 12.h),
    child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          buildTankYou(
              termsAndCond: invoice.termsAndCond),
          SizedBox(width: 6.w),
          buildTotal(invoice),
        ]));