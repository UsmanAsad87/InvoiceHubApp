import '../../../../commons/common_imports/common_libs.dart';
import '../../../../utils/constants/assets_manager.dart';

class CustomArrowButton extends StatelessWidget {

  double? height;
  double? margin;
  Function() onTap;
  String buttonName;
  bool border;
  CustomArrowButton({
    Key? key,
    required this.onTap,
    required this.buttonName,
    this.height,
    this.margin,
    this.border = true
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.scaffoldBackgroundColor,
      child: InkWell(
        onTap: onTap,
        splashColor: Colors.transparent,
        child: Container(
            height: height ?? 56.h,
            margin: EdgeInsets.only(bottom: margin ?? 10.h,),
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
            decoration: BoxDecoration(
                color: context.whiteColor,
                borderRadius : BorderRadius.circular(4.r),
                border: border ? Border.all(color: context.containerColor, width: 1.w)
                : Border(
                bottom: BorderSide(
                color: context.containerColor, width: 1.w
                ),)),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  buttonName,
                  style: getSemiBoldStyle(
                      fontSize: MyFonts.size16, color: context.titleColor),
                ),
              ),
              Image.asset( AppAssets.arrowRightIcon,width: 15.w,height: 15.h,
                color: context.titleColor.withOpacity(.6),),
            ]
        )
        ),
      ),
    );
  }
}
