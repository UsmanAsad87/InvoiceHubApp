import 'package:invoice_producer/commons/common_imports/common_libs.dart';
import 'package:invoice_producer/features/user/main_menu/controller/main_menu_controller.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BottomBarItem extends StatelessWidget {
  const BottomBarItem({
    super.key,
    required this.mainMenuCtr,
    required this.onTap,
    required this.label,
    required this.icon,
    required this.index,
    this.isAdd = false,
  });

  final MainMenuController mainMenuCtr;
  final Function() onTap;
  final String label;
  final String icon;
  final int index;
  final bool isAdd;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: isAdd ? 10.w : 0.w,
      ),

      color: context.whiteColor,
      child: SizedBox(
        width: isAdd ? 40.w : 70.w,
        height: 50.h ,
        child: InkWell(
          onTap: onTap,
          child: isAdd
              ? Container(
                  color: context.whiteColor,
                  child: Container(
                    margin: EdgeInsets.only(
                      bottom: 5.w,
                    ),
                    decoration: BoxDecoration(
                        color: context.greenColor,
                        borderRadius: BorderRadius.circular(4.r)),
                    child: Center(
                      child: Image.asset(icon,
                          width: 24.w, height: 24.h, color: context.whiteColor),
                    ),
                  ),
                )
              : Container(
                  color: context.whiteColor,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        icon,
                        width: 24.w,
                        height: 24.h,
                        color: mainMenuCtr.index == index
                            ? context.greenColor
                            : context.bodyTextColor,
                      ),
                      SizedBox(
                        height: 0.h,
                      ),
                      Text(
                        label,
                        style: getMediumStyle(
                            fontSize: MyFonts.size10,
                            color: mainMenuCtr.index == index
                                ? context.greenColor
                                : context.bodyTextColor),
                      )
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
