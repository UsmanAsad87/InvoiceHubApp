import 'package:invoice_producer/commons/common_imports/common_libs.dart';
import 'package:invoice_producer/utils/constants/app_constants.dart';

class Version extends StatelessWidget {
  const Version({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 48.h,
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
            'Version',
            style: getMediumStyle(
                fontSize: MyFonts.size16, color: context.titleColor),
          ),
          Text(
            '5.0.2023',
            style: getMediumStyle(
                fontSize: MyFonts.size16, color: context.titleColor),
          ),
        ],
      ),
    );
  }
}
