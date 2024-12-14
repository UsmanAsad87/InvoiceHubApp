import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:invoice_producer/commons/common_functions/padding.dart';
import 'package:invoice_producer/commons/common_imports/common_libs.dart';

import '../../../../../../utils/constants/assets_manager.dart';

class TaxContainer extends StatelessWidget {
  final title;
  final subTitle;
  final onSelect;

  const TaxContainer(
      {Key? key,
      required this.title,
      required this.subTitle,
      required this.onSelect})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 88.h,
      margin: EdgeInsets.only(bottom: 10.h),
      padding: EdgeInsets.all(8.h),
      decoration: BoxDecoration(
          color: context.whiteColor,
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(color: context.containerColor, width: 1.w)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: getSemiBoldStyle(
                      fontSize: MyFonts.size14, color: context.titleColor),
                ),
                padding8,
                Text(
                  '%$subTitle',
                  style: getRegularStyle(
                      fontSize: MyFonts.size14, color: Colors.black),
                ),
              ],
            ),
          ),
          PopupMenuButton<String>(
            onSelected: onSelect,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4.r),
            ),
            elevation: 2,
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              PopupMenuItem<String>(
                value: 'edit',
                height: 30.h,
                padding: EdgeInsets.only(left: 15.w, right: 30.w),
                child: Row(
                  children: [
                    Image.asset(AppAssets.editProductIcon,
                        width: 16.w, height: 16.h),
                    SizedBox(width: 8.w),
                    Text(
                      'Edit',
                      style: getMediumStyle(
                          color: context.titleColor, fontSize: MyFonts.size14),
                    ),
                  ],
                ),
              ),
              PopupMenuItem<String>(
                value: 'delete',
                height: 30.h,
                padding: EdgeInsets.only(left: 15.w, right: 40.w),
                child: Row(
                  children: [
                    Image.asset(AppAssets.deleteIcon,
                        width: 16.w, height: 16.h),
                    SizedBox(width: 8.w),
                    Text(
                      'Delete',
                      style: getMediumStyle(
                          color: context.titleColor, fontSize: MyFonts.size14),
                    ),
                  ],
                ),
              ),
            ],
            child: Container(
              color: context.scaffoldBackgroundColor,
              padding: EdgeInsets.symmetric(horizontal: 0.w, vertical: 10.h),
              child: Image.asset(AppAssets.moreVertIcon,
                  width: 24.w, height: 24.h, color: context.titleColor),
            ),
          ),
        ],
      ),
    );
  }
}
