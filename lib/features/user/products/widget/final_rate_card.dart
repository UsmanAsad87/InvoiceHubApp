import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:invoice_producer/commons/common_imports/common_libs.dart';
import 'package:invoice_producer/commons/common_widgets/cached_circular_network_image.dart';
import 'package:invoice_producer/utils/constants/app_constants.dart';
import 'package:invoice_producer/utils/constants/assets_manager.dart';

import '../../../../commons/common_widgets/cached_retangular_network_image.dart';
import '../../dashboard/controller/dashboard_notifiar_ctr.dart';

class FinalRateCard extends StatelessWidget {
  const FinalRateCard({
    super.key, required this.amount,
  });
  final double amount;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
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
                'Final rate( With only Tax)',
                style: getMediumStyle(
                    fontSize: MyFonts.size16, color: context.titleColor),
              ),
              Consumer(
                builder: (BuildContext context, WidgetRef ref, Widget? child) {
                  final dashBoardCtr = ref.watch(dashBoardNotifierCtr);
                  return Text(
                    '${dashBoardCtr.currencyTypeEnum?.type}$amount',
                    style: getMediumStyle(
                        fontSize: MyFonts.size16, color: context.titleColor),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
