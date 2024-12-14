import 'package:invoice_producer/commons/common_imports/common_libs.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final Function(String)? onChanged;
  final Function(String)? onFieldSubmitted;
  final TextInputType? inputType;
  final bool obscure;
  final IconData? icon;
  final String? Function(String?)? validatorFn;
  final Widget? leadingIcon;
  final Widget? tailingIcon;
  final String? tailingIconPath;
  final double? texFieldHeight;
  final double? borderRadius;
  final double? verticalPadding;
  final double? verticalMargin;
  final String label;
  final Color? fillColor;
  final int? maxLines;
  final bool showLabel;
  final bool? enabled;

  const CustomTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    this.onChanged,
    this.onFieldSubmitted,
    this.inputType,
    this.leadingIcon,
    this.obscure = false,
    this.validatorFn,
    this.icon,
    this.tailingIcon,
    this.texFieldHeight,
    required this.label,
    this.showLabel = true,
    this.tailingIconPath,
    this.fillColor,
    this.maxLines,
    this.borderRadius,
    this.verticalPadding,
    this.verticalMargin,
    this.enabled
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: verticalMargin ?? 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          showLabel == false?
              SizedBox():
          Padding(
            padding: EdgeInsets.only(left: 0.0.w, bottom: 5.h),
            child: Text(
              label,
              style: getRegularStyle(
                  fontSize: MyFonts.size12,
                  color: context.titleColor),
            ),
          ),
          TextFormField(
            validator: validatorFn,
            obscureText: obscure,
            controller: controller,
            keyboardType: inputType,
            maxLines: maxLines ?? 1,
            enabled: enabled ?? true,
            style: getRegularStyle(
                fontSize: MyFonts.size12,
                color: context.titleColor),
            decoration: InputDecoration(
              fillColor: fillColor,
              contentPadding: EdgeInsets.symmetric(
                  horizontal: 20.w, vertical: verticalPadding ?? 0.0),
              errorStyle: getRegularStyle(
                  fontSize: MyFonts.size10,
                  color: Theme.of(context).colorScheme.error),
              suffixIcon: tailingIconPath != null
                  ? Padding(
                      padding: EdgeInsets.all(13.0.h),
                      child: SvgPicture.asset(
                        tailingIconPath!,
                      ),
                    )
                  : tailingIcon,
              hintText: hintText,
              hintStyle: getRegularStyle(
                  fontSize: MyFonts.size12,
                  color: context.bodyTextColor),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius ?? 8.r),
                borderSide:
                     BorderSide(color: context.bodyTextColor.withOpacity(0.4), width: 1.w),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius ?? 8.r),
                borderSide:
                     BorderSide(color: context.bodyTextColor, width: 1.0),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius ?? 8.r),
                borderSide:
                BorderSide(color: context.bodyTextColor, width: 1.0),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius ?? 8.r),
                borderSide:
                BorderSide(color: context.errorColor, width: 1.0),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius ?? 8.r),
                borderSide:
                BorderSide(color: context.errorColor, width: 1.0),
              ),
            ),
            onFieldSubmitted: onFieldSubmitted,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}
