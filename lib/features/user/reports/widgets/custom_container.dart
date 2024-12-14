import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:invoice_producer/commons/common_imports/common_libs.dart';

import '../../../../utils/themes/styles_manager.dart';

class CustomContainer extends StatelessWidget {
  final String? value;
  final String text;
  final Color color;

  const CustomContainer(
      {super.key,
      required this.color,
      required this.text,
      this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color.withOpacity(.15),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Container(
            width: 12.w,
            margin: const EdgeInsets.only(right: 12),
            decoration: BoxDecoration(
              color: color,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8.0),
                  bottomLeft: Radius.circular(8.0)),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               Text(
                      value!,
                      style: getSemiBoldStyle(
                        fontSize: MyFonts.size16,
                        color: context.titleColor,
                      ),
                    ),
              Text(
                text,
                style: getRegularStyle(
                  fontSize: MyFonts.size14,
                  color: context.bodyTextColor,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
