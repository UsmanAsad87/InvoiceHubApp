import 'package:intl/intl.dart';
import 'package:invoice_producer/commons/common_imports/common_libs.dart';
import 'package:invoice_producer/commons/common_widgets/cached_circular_network_image.dart';
import 'package:invoice_producer/utils/constants/app_constants.dart';
import 'package:invoice_producer/utils/constants/assets_manager.dart';

class NotificationCard extends StatelessWidget {
  const NotificationCard({
    super.key,
    this.img,
    required this.title,
    this.subTitle,
    required this.timeAgo,
  });
  final String? img;
  final String title;
  final String? subTitle;
  final String timeAgo;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(8.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (img != null)
                CachedCircularNetworkImageWidget(
                  image: img!,
                  size: 56,
                ),
              if (img == null)
                CircleAvatar(
                  radius: 28.r,
                  backgroundColor: context.greenColor.withOpacity(0.3),
                  child: Image.asset(AppAssets.notificationIcon,width: 24.w,height: 24.h,),
                ),
              SizedBox(
                width: 10.w,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    constraints: BoxConstraints(maxWidth: 0.65.sw),
                    child: Text(
                      title,
                      style: getSemiBoldStyle(
                          fontSize: MyFonts.size14, color: context.titleColor),
                    ),
                  ),
                  if (subTitle != null)
                    Text(
                      subTitle!,
                      style: getRegularStyle(
                          fontSize: MyFonts.size14,
                          color: context.bodyTextColor),
                    ),
                  Text(
                    timeAgo,
                    style: getRegularStyle(
                        fontSize: MyFonts.size12, color: context.bodyTextColor),
                  ),
                ],
              ),
            ],
          ),
        ),
        Divider(
          thickness: 1.w,
          color: context.containerColor,
        ),
      ],
    );
  }
}
