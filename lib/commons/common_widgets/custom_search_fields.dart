import 'package:invoice_producer/commons/common_imports/common_libs.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:invoice_producer/utils/constants/assets_manager.dart';

class CustomSearchField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final Function(String)? onChanged;
  final Function(String)? onFieldSubmitted;
  final TextInputType? inputType;
  final String? Function(String?)? validatorFn;
  final double? texFieldHeight;
  final double? borderRadius;
  final double? verticalPadding;
  final double? verticalMargin;
  final Color? fillColor;
  final int? maxLines;

  const CustomSearchField({
    Key? key,
    required this.controller,
    required this.hintText,
    this.onChanged,
    this.onFieldSubmitted,
    this.inputType,
    this.validatorFn,
    this.texFieldHeight,
    this.fillColor,
    this.maxLines,
    this.borderRadius,
    this.verticalPadding,
    this.verticalMargin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: verticalMargin ?? 10.h),
      child: TextFormField(
        validator: validatorFn,
        controller: controller,
        keyboardType: inputType,
        maxLines: maxLines ?? 1,
        style: getRegularStyle(
            fontSize: MyFonts.size14, color: context.titleColor),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
              horizontal: 20.w, vertical: verticalPadding ?? 0.0),
          errorStyle: getRegularStyle(
              fontSize: MyFonts.size10,
              color: Theme.of(context).colorScheme.error),
          prefixIcon: Padding(
            padding: EdgeInsets.all(13.0.h),
            child: Image.asset(
              AppAssets.searchIcon,
              width: 18.w,
              height: 18.h,
            ),
          ),
          hintText: hintText,
          hintStyle: getRegularStyle(
              fontSize: MyFonts.size14, color: context.bodyTextColor),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 8.r),
            borderSide: BorderSide(
                color: context.bodyTextColor.withOpacity(0.4), width: 1.w),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 8.r),
            borderSide: BorderSide(color: context.bodyTextColor, width: 1.0),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 8.r),
            borderSide: BorderSide(color: context.bodyTextColor, width: 1.0),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 8.r),
            borderSide: BorderSide(color: context.errorColor, width: 1.0),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 8.r),
            borderSide: BorderSide(color: context.errorColor, width: 1.0),
          ),
        ),
        onFieldSubmitted: onFieldSubmitted,
        onChanged: onChanged,
      ),
    );
  }
}
