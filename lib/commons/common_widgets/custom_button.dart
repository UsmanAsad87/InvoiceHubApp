import 'package:invoice_producer/commons/common_imports/common_libs.dart';
import 'package:invoice_producer/utils/loading.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.onPressed,
    required this.buttonText,
    this.isLoading = false,
    this.backColor,
    this.textColor,
    this.buttonWidth,
    this.buttonHeight,
    this.fontSize,
    this.padding,
    this.borderRadius,
  });

  final Function()? onPressed;
  final String buttonText;
  final bool isLoading;
  final Color? backColor;
  final Color? textColor;
  final double? buttonWidth;
  final double? buttonHeight;
  final double? fontSize;
  final double? padding;
  final double? borderRadius;

  @override
  Widget build(BuildContext context) {
    return Container(
      key: const Key('customButton'),
      height: buttonHeight ?? 56.h,
      margin: EdgeInsets.symmetric(vertical: padding ?? 10.h),
      child: RawMaterialButton(
        elevation: 2,
        fillColor:
            backColor ?? context.greenColor,
        onPressed: onPressed,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 4.r),
        ),
        child: SizedBox(
          // padding: EdgeInsets.symmetric(vertical: 10.h),
          width: buttonWidth ?? double.infinity,
          height: buttonHeight ?? 45.h,
          child: Center(
              child: isLoading
                  ? LoadingWidget(
                      color: context.whiteColor)
                  : Text(
                      buttonText,
                      style: getSemiBoldStyle(
                          color: textColor ??
                              context.whiteColor,
                          fontSize: fontSize ?? MyFonts.size16),
                    )),
        ),
      ),
    );
  }
}
