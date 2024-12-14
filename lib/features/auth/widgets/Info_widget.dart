import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:invoice_producer/commons/common_imports/common_libs.dart';
import 'package:invoice_producer/utils/constants/assets_manager.dart';
import '../../../utils/constants/font_manager.dart';
class InfoWidget extends StatelessWidget {
  const InfoWidget(
      {super.key,});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(10.h),
      decoration: BoxDecoration(
          color: MyColors.infoContainerColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: MyColors.infoContainerColor.withOpacity(0.1),
              offset: const Offset(0, 2),
              blurRadius: 4,
            ),
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            AppAssets.infoImage,
            height: 24.h,
            width: 24.w,
          ),
          SizedBox(
            width: 10.w,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Note: If you have account on web app then please keep the password same in both places.the app will justify your account before giving access',
                  style: getRegularStyle(
                    color: context.titleColor,
                    fontSize: MyFonts.size12,
                  ),
                ),
                Text(
                  'Caution: You may los your current package and set to free trail',
                  style: getRegularStyle(
                    color: context.errorColor,
                    fontSize: MyFonts.size12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
