import 'package:invoice_producer/commons/common_imports/common_libs.dart';
import 'package:invoice_producer/features/user/main_menu/controller/main_menu_controller.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:invoice_producer/utils/constants/assets_manager.dart';

class CustomFloatingActionButton extends StatelessWidget {
  const CustomFloatingActionButton({
    super.key,
    required this.onTap,
  });

  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 50.w,
      height: 50.h,
      child: InkWell(
          onTap: onTap,
          child: Container(
            color: context.whiteColor,
            child: Container(
              decoration: BoxDecoration(
                  color: context.titleColor,
                  borderRadius: BorderRadius.circular(4.r)),
              child: Center(
                child: Image.asset(AppAssets.addIcon,
                    width: 24.w, height: 24.h, color: context.whiteColor),
              ),
            ),
          )),
    );
  }
}
