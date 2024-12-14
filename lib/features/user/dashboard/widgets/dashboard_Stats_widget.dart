import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:invoice_producer/commons/common_functions/currency_converter.dart';
import 'package:invoice_producer/commons/common_imports/common_libs.dart';
import 'package:invoice_producer/commons/common_shimmers/loading_images_shimmer.dart';
import 'package:invoice_producer/features/user/dashboard/controller/dashboard_notifiar_ctr.dart';
import 'package:invoice_producer/utils/constants/app_constants.dart';
import 'package:invoice_producer/utils/constants/assets_manager.dart';
import 'package:invoice_producer/utils/loading.dart';

import '../../../../commons/common_imports/apis_commons.dart';
import '../../../../models/invoice_model/invoice_model.dart';
import '../../invoice/controller/invoice_upload_controller.dart';
import '../controller/states_controller.dart';

class DashboardStatsWidget extends ConsumerStatefulWidget {
  const DashboardStatsWidget({
    super.key,
  });

  @override
  ConsumerState<DashboardStatsWidget> createState() =>
      _DashboardStatsWidgetState();
}

class _DashboardStatsWidgetState extends ConsumerState<DashboardStatsWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final dashBoardCtr = ref.watch(dashBoardNotifierCtr);
    return SizedBox(
      width: double.infinity,
      height: 190.h,
      child: Container(
        decoration: BoxDecoration(
            color: context.whiteColor,
            borderRadius: BorderRadius.circular(4.r),
            border: Border.all(
                color: context.bodyTextColor.withOpacity(0.2), width: 1.w)),
        child: Column(
          children: [
            Container(
              height: 91.h,
              decoration: BoxDecoration(
                color: context.greenColor,
                borderRadius: BorderRadius.circular(4.r),
              ),
              padding: EdgeInsets.all(10.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Earnings balance',
                        style: getRegularStyle(
                            fontSize: MyFonts.size14,
                            color: context.whiteColor),
                      ),
                      Text(
                        ref
                            .watch(getTotalPaidInTargetProvider(
                                dashBoardCtr.currencyTypeEnum?.name ?? 'USD'))
                            .when(
                                data: (totalProfit) => totalProfit,
                                error: (e, s) => '',
                                loading: () => ''),
                        style: getRegularStyle(
                            fontSize: MyFonts.size20,
                            color: context.whiteColor),
                      )
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 4.h),
                    child: Image.asset(AppAssets.balanceImage,
                        color: context.whiteColor),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10.h),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Total outstanding',
                        style: getRegularStyle(
                            fontSize: MyFonts.size14,
                            color: context.titleColor),
                      ),
                      Text(
                          '${dashBoardCtr.currencyTypeEnum?.type} ${ref.watch(getTotalPaidAmountThisMonthProvider(false)).when(data: (totalAmount) => totalAmount.toStringAsFixed(2), error: (e, s) => '', loading: () => '')}',
                          style: getBoldStyle(
                            fontSize: MyFonts.size16,
                            color: context.titleColor,
                          )),
                      Text(
                        '${ref.watch(getTotalPaidThisMonthProvider(false)).when(data: (totalInvoices) => '$totalInvoices', error: (e, s) => '', loading: () => '')} Waiting invoice',
                        style: getRegularStyle(
                            fontSize: MyFonts.size12,
                            color: context.bodyTextColor),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 30.w,
                  ),
                  Container(
                    width: 1.w,
                    height: 60.h,
                    margin:
                        EdgeInsets.symmetric(vertical: 5.h, horizontal: 15.w),
                    color: context.containerColor,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Paid this month',
                        style: getRegularStyle(
                            fontSize: MyFonts.size14,
                            color: context.titleColor),
                      ),
                      Text(
                          ref.watch(getTotalPaidAmountThisMonthProvider(true)).when(
                              data: (totalAmount) =>
                                  '${dashBoardCtr.currencyTypeEnum?.type} $totalAmount',
                              error: (e, s) => '',
                              loading: () => ''),
                          style: getBoldStyle(
                            fontSize: MyFonts.size16,
                            color: context.titleColor,
                          )
                      ),
                      Text(
                        ref.watch(getTotalPaidThisMonthProvider(true)).when(
                            data: (totalInvoices) =>
                                '$totalInvoices Paid invoice',
                            error: (e, s) => '',
                            loading: () => '  Paid invoice'),
                        style: getRegularStyle(
                            fontSize: MyFonts.size12,
                            color: context.bodyTextColor),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
