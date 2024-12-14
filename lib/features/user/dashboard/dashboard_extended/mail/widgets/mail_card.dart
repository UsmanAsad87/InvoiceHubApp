import 'package:invoice_producer/commons/common_imports/common_libs.dart';

import '../../../../../../commons/common_widgets/cached_retangular_network_image.dart';
import '../../../../../../utils/constants/assets_manager.dart';
import '../../../../../../utils/utils.dart';

class MailCard extends StatelessWidget {
  String? imageUrl;

  MailCard({Key? key, required this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 88.h,
          margin: EdgeInsets.only(bottom: 10.h),
          padding: EdgeInsets.all(8.h),
          decoration: BoxDecoration(
              color: context.whiteColor,
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(color: context.containerColor, width: 1.w)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (imageUrl != null)
                CachedRectangularNetworkImageWidget(
                    image: imageUrl!, width: 76, height: 76),
              if (imageUrl == null)
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
                    AppAssets.profileIcon,
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
                      'Eleannor Pena',
                      overflow: TextOverflow.ellipsis,
                      style: getSemiBoldStyle(
                          fontSize: MyFonts.size14, color: context.titleColor),
                    ),
                    Text(
                      'Delivering Excellence at your door step',
                      overflow: TextOverflow.ellipsis,
                      style: getRegularStyle(
                          fontSize: MyFonts.size14, color: context.titleColor),
                    ),
                    Text(
                      getDateMonthYear(DateTime.now()),
                      style: getMediumStyle(
                          fontSize: MyFonts.size12, color: context.bodyTextColor),
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () {},
                child: Container(
                  color: context.scaffoldBackgroundColor,
                  padding:
                      EdgeInsets.symmetric(horizontal: 0.w, vertical: 10.h),
                  child: Image.asset(AppAssets.moreVertIcon,
                      width: 24.w, height: 24.h, color: context.titleColor),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
