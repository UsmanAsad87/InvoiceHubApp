import 'package:invoice_producer/models/support_model/support_model.dart';

import '../../../../../../commons/common_imports/common_libs.dart';
import '../../../../../../utils/constants/assets_manager.dart';
import '../../../../../../utils/utils.dart';

class SupportMessageCard extends StatelessWidget {
  final Function()? onTap;
  final SupportModel support;

  const SupportMessageCard({Key? key, required this.onTap, required this.support}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.scaffoldBackgroundColor,
      child: InkWell(
        onTap: onTap,
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              height: 92.h,
              margin: EdgeInsets.only(bottom: 10.h, left: 15.w, right: 15.w),
              padding: EdgeInsets.all(8.h),
              decoration: BoxDecoration(
                  color: context.whiteColor,
                  borderRadius: BorderRadius.circular(8.r),
                  border:
                      Border.all(color: context.containerColor, width: 1.w)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 76.w,
                    height: 76.h,
                    padding: EdgeInsets.all(8.h),
                    decoration: BoxDecoration(
                        color: context.greenColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8.r),
                        border: Border.all(
                            color: context.containerColor, width: 1.w)),
                    child: Image.asset(
                      AppAssets.supportIcon,
                      color: context.greenColor,
                    ),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          support.subject, //'Managing subscription',
                          overflow: TextOverflow.ellipsis,
                          style: getSemiBoldStyle(
                              fontSize: MyFonts.size14,
                              color: context.titleColor),
                        ),
                        Expanded(
                          child: Text(
                            support.message, //'thank you',
                            overflow: TextOverflow.ellipsis,
                            style: getRegularStyle(
                                fontSize: MyFonts.size14,
                                color: context.titleColor),
                          ),
                        ),
                        Text(
                          getDateMonthYear(support.createdOn),
                          style: getMediumStyle(
                              fontSize: MyFonts.size12,
                              color: context.bodyTextColor),
                        ),
                      ],
                    ),
                  ),
                  // InkWell(
                  //   onTap: () {},
                  //   child: Container(
                  //     color: context.scaffoldBackgroundColor,
                  //     padding:
                  //     EdgeInsets.symmetric(horizontal: 0.w, vertical: 10.h),
                  //     child: Image.asset(AppAssets.moreVertIcon,
                  //         width: 24.w, height: 24.h, color: context.titleColor),
                  //   ),
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
