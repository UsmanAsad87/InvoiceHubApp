import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:invoice_producer/commons/common_imports/common_libs.dart';

import '../../../../../../utils/constants/assets_manager.dart';

class SupportProfileImage extends StatelessWidget {

  String? name;
  final String imgUrl;
  SupportProfileImage({Key? key, required this.imgUrl, this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 178.h,
          width: double.infinity,
          decoration: BoxDecoration(
              color: context.whiteColor,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20.r),
                  bottomRight: Radius.circular(20.r))),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  height: 176.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: context.greenColor,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20.r),
                        bottomRight: Radius.circular(20.r),
                      )),
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 160.h,
          width: double.infinity,
          decoration: BoxDecoration(
              color: context.whiteColor,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20.r),
                  bottomRight: Radius.circular(20.r))),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(5.0.h),
                child: SizedBox(
                  width: double.infinity,
                  height: 115.h,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      AspectRatio(
                        aspectRatio: 1,
                        child: Container(
                          decoration: BoxDecoration(
                            color: context.greenColor.withOpacity(.1),
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: double.infinity,
                              height: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.r),
                                image: DecorationImage(
                                    image: AssetImage(
                                      imgUrl,
                                    ),
                                  scale: 1.sp,
                                    ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if(name != null)
              Text(name!,
                style: getSemiBoldStyle(
                    color: context.titleColor,
                    fontSize: MyFonts.size16),),
            ],
          ),
        ),
      ],
    );
  }
}
