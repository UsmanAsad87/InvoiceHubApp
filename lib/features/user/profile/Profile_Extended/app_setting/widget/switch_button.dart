import 'package:flutter/cupertino.dart';
import 'package:invoice_producer/commons/common_imports/common_libs.dart';
import 'package:invoice_producer/utils/constants/app_constants.dart';

class SwitchButton extends StatelessWidget {
  const SwitchButton({
    super.key,
    required this.onTap,
    required this.title,
    required this.value,
  });
  final Function() onTap;
  final String title;
  final bool value;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 56.h,
      margin: EdgeInsets.only(bottom: 10.h, top: 10.h),
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      decoration: BoxDecoration(
          color: context.whiteColor,
          borderRadius: BorderRadius.circular(4.r),
          border: Border.all(color: context.containerColor, width: 1.w)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: getSemiBoldStyle(fontSize: MyFonts.size16, color: context.titleColor),
          ),
          Transform.scale(
            scale: 0.6,
            child: SizedBox(
              width: 30.w,
              child: CupertinoSwitch(
                activeColor: MyColors.green,
                trackColor: context.bodyTextColor,
                thumbColor: context.whiteColor,
                value: value,
                onChanged: (val) {
                  onTap();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
