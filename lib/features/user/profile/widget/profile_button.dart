import 'package:invoice_producer/utils/constants/app_constants.dart';

import '../../../../commons/common_imports/common_libs.dart';

class ProfileButton extends StatelessWidget {
  const ProfileButton({
    super.key,
    required this.icon,
    required this.name,
    required this.onTap,
  });
  final String icon;
  final String name;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        color: context.scaffoldBackgroundColor,
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: AppConstants.padding, vertical: 10.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Image.asset(icon,
                      width: 24.w, height: 24.h, color: context.titleColor),
                  SizedBox(
                    width: 10.w,
                  ),
                  Text(
                    name,
                    style: getSemiBoldStyle(
                        color: context.titleColor, fontSize: MyFonts.size16),
                  ),
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              Container(
                width: double.infinity,
                height: 1.h,
                color: context.containerColor,
              )
            ],
          ),
        ),
      ),
    );
  }
}