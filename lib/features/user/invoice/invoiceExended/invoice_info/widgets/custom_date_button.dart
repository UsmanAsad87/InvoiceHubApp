import 'package:invoice_producer/commons/common_functions/date_time_methods.dart';

import '../../../../../../../commons/common_imports/common_libs.dart';
import '../../../../../../../utils/constants/assets_manager.dart';

class CustomDateButton extends StatelessWidget {

  DateTime? value;
  final String label;
  final Function() onTap;
   CustomDateButton({
    Key? key,
    required this.label,
    required this.onTap,
    this.value
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.h),
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 0.0.w, bottom: 5.h),
              child: Text(
                label,
                style: getRegularStyle(
                    fontSize: MyFonts.size12, color: context.titleColor),
              ),
            ),
            Container(
                height: 45.h,
                padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 5.h),
                decoration: BoxDecoration(
                  color: context.whiteColor,
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(
                      color: context.bodyTextColor.withOpacity(0.4), width: 1.w),
                ),
                child: Row(
                  children: [
                    Expanded(
                        child: Text(value != null ? formatDateAndTime(value!) : '', style :getRegularStyle(
                        color: context.titleColor, fontSize: MyFonts.size12),)
                    ),
                    Icon(Icons.calendar_month_outlined,
                                size: 24.h, color: context.titleColor),
                  ],
                ),
            ),
          ],
        ),
      ),
    );
  }
}
