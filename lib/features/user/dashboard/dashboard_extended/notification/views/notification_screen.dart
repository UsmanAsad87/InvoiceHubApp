import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:invoice_producer/commons/common_functions/padding.dart';
import 'package:invoice_producer/core/extensions/color_extension.dart';
import 'package:invoice_producer/features/user/dashboard/dashboard_extended/notification/widget/notification_card.dart';
import 'package:invoice_producer/utils/constants/app_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:invoice_producer/utils/themes/styles_manager.dart';
import '../../../../../../utils/constants/assets_manager.dart';
import '../../../../../../utils/constants/font_manager.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: context.scaffoldBackgroundColor,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Image.asset(AppAssets.backArrowIcon,
              width: 20.w, height: 20.h, color: context.titleColor),
        ),
        title: Text(
          'Notification',
          style: getLibreBaskervilleExtraBoldStyle(
              color: context.titleColor, fontSize: MyFonts.size16),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: AppConstants.padding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  padding8,
                  Text('Today',
                      style: getSemiBoldStyle(
                          color: context.titleColor, fontSize: MyFonts.size16)),
                  padding12,
                  const NotificationCard(
                    img: personImg,
                    title:
                        'Congratulations! Your invoice payment has been received successfully.',
                    timeAgo: '2 hours ago',
                  ),
                  const NotificationCard(
                    img: personImg,
                    title: 'Stephen Lang',
                    subTitle: "Sent you a message",
                    timeAgo: '10 hours ago',
                  ),
                  padding8,
                  Text('Last week',
                      style: getSemiBoldStyle(
                          color: context.titleColor, fontSize: MyFonts.size16)),
                  padding12,
                  const NotificationCard(
                    title: 'Confirm your e-mail address',
                    timeAgo: '8 days ago',
                  ),
                  const NotificationCard(
                    title:
                        'Great news! Your new invoice has been sent successfully!',
                    timeAgo: '9 days ago',
                  ),
                  const NotificationCard(
                    title: 'You have a new update',
                    timeAgo: '9 days ago',
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 50.h,
            ),
          ],
        ),
      ),
    );
  }
}
