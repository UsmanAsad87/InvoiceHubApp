import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:invoice_producer/commons/common_imports/common_libs.dart';
import 'package:invoice_producer/utils/loading.dart';
import '../../../utils/constants/font_manager.dart';
class AnotherAuthButton extends StatelessWidget {
  final String image;
  final String text;
  final Color bgColor;
  final bool isLoading;
  final Function() onTap;
  const AnotherAuthButton(
      {super.key,
      required this.image,
      required this.text,
      required this.onTap, required this.bgColor,
      this.isLoading = false});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        height: 48.h,
        width: double.infinity,
        decoration: BoxDecoration(
            color: bgColor.withOpacity(0.5),
            borderRadius: BorderRadius.circular(12.r),
            boxShadow: [
              BoxShadow(
                color: bgColor.withOpacity(0.1),
                offset: const Offset(0, 2),
                blurRadius: 4,
              ),
            ]),
        child: isLoading ? const LoadingWidget():Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              image,
              height: 24.h,
              width: 24.w,
            ),
            SizedBox(
              width: 10.w,
            ),
            Text(
              text,
              style: getRegularStyle(
                color: context.titleColor,
                fontSize: MyFonts.size14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
