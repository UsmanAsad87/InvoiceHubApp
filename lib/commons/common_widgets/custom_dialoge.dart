import 'package:invoice_producer/commons/common_imports/common_libs.dart';
import 'package:invoice_producer/utils/constants/app_constants.dart';

import '../../features/user/invoice/widgets/custom_arrow_button.dart';

class CustomDialogeBox extends StatelessWidget {
  final String title;
  final VoidCallback onCrossTap;
  final List<CustomArrowButton> buttonList;
  const CustomDialogeBox({
    super.key,
    required this.title,
    required this.buttonList,
    required this.onCrossTap,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.r),
      ),
      backgroundColor: Colors.transparent,
      child: Container(
        padding: EdgeInsets.all(AppConstants.padding),
        decoration: BoxDecoration(
          color: MyColors.white,
          borderRadius: BorderRadius.circular(3.r),
          boxShadow: [
            BoxShadow(
              color: context.greenColor.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(2, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                    onPressed: onCrossTap,
                    icon: Icon(
                        Icons.close_rounded,
                      color: Colors.black.withOpacity(.6),
                      size: 35.r,
                    )),
              ],
            ),
            Text(title,style: getBoldStyle(color: context.titleColor,fontSize: MyFonts.size18),),
            SizedBox(
              height: 10.h,
            ),
            ListView(
              shrinkWrap: true,
              children: buttonList,
            )
          ],
        ),
      ),
    );
  }
}
