import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:invoice_producer/commons/common_imports/common_libs.dart';

import 'loading_images_shimmer.dart';

class ListItemShimmer extends StatelessWidget {
  const ListItemShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
        width: double.infinity,
        height: 88.h,
        margin: EdgeInsets.only(bottom: 10.h),
        padding: EdgeInsets.all(8.h),
        decoration: BoxDecoration(
            color: context.whiteColor,
            borderRadius:
            BorderRadius.circular(8.r),
            border: Border.all(
                color: context.containerColor,
                width: 1.w)),
        child: Row(
            mainAxisAlignment:
            MainAxisAlignment.spaceBetween,
            children: [
              Row(
                  mainAxisAlignment:
                  MainAxisAlignment.start,
                  children: [
                    ShimmerWidget(width: 75.w,height: 75.h,)
                  ])
            ]));
  }
}
