import 'package:invoice_producer/commons/common_imports/common_libs.dart';
import 'package:invoice_producer/utils/constants/assets_manager.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../commons/common_widgets/show_toast.dart';

class WatchTutorialWidget extends StatelessWidget {
  const WatchTutorialWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        _launchUrl(
          "https://youtu.be/KC4PaR_bSts?si=3pUoXxcFxQwlQA03"
        );
        //
      },
      child: SizedBox(
        width: double.infinity,
        height: 81.h,
        child: Container(
          decoration: BoxDecoration(
              color: context.whiteColor,
              borderRadius: BorderRadius.circular(4.r),
              border: Border.all(
                  color: context.bodyTextColor.withOpacity(0.2), width: 1.w)),
          padding: EdgeInsets.all(10.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween  ,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Watch tutorial',
                    style: getBoldStyle(
                        fontSize: MyFonts.size16, color: context.titleColor),
                  ),
                  Text(
                    'How to send on invoice in 1 minute',
                    style: getMediumStyle(
                        fontSize: MyFonts.size12, color: context.bodyTextColor),
                  )
                ],
              ),
              Container(
                width: 40.w,
                height: 40.h,
                decoration: BoxDecoration(
                  color: context.greenColor.withOpacity(0.35),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                padding: EdgeInsets.all(8.h),
                child: Image.asset(AppAssets.playIcon,
                    width: 26.w, height: 2.h, color: context.titleColor),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _launchUrl(String url) async {
    try {
      final Uri _url = Uri.parse(url);
      if (!await launchUrl(_url)) {}
    } catch (e) {
      showToast(msg: 'Invalid link');
    }
  }
}
