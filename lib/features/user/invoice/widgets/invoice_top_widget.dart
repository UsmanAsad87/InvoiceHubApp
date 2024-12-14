import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:invoice_producer/commons/common_functions/date_time_methods.dart';
import 'package:invoice_producer/commons/common_functions/padding.dart';
import 'package:invoice_producer/commons/common_widgets/cached_retangular_network_image.dart';
import 'package:invoice_producer/utils/constants/app_constants.dart';
import 'package:invoice_producer/utils/constants/assets_manager.dart';

import '../../../../commons/common_imports/common_libs.dart';
import '../../../../commons/common_widgets/cached_circular_network_image.dart';
import '../../../../models/invoice_model/invoice_model.dart';
import '../../dashboard/controller/dashboard_notifiar_ctr.dart';

class InvoiceTopWidget extends StatelessWidget {
  final InVoiceModel invoice;

  const InvoiceTopWidget({super.key, required this.invoice});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 185.h,
          width: double.infinity,
          decoration: BoxDecoration(
              color: context.whiteColor,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20.r),
                  bottomRight: Radius.circular(20.r))),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  height: 185.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: context.greenColor,
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(20.r),
                          bottomLeft: Radius.circular(20.r))),
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 168.h,
          width: double.infinity,
          decoration: BoxDecoration(
              color: context.whiteColor,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20.r),
                  bottomRight: Radius.circular(20.r))),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(5.0.h),
                child: invoice?.customer?.image != ''
                    ? CachedRectangularNetworkImageWidget(
                        image: invoice!.customer?.image ?? '', width: 76, height: 76)
                    : Container(
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
                // CachedRectangularNetworkImageWidget(
                //   image: invoice.customer?.image ?? personImg,
                //   width: 76,
                //   height: 76,
                // ),
              ),
              Text(
                invoice.customer?.name ?? '',
                style: getSemiBoldStyle(
                    fontSize: MyFonts.size14, color: context.titleColor),
              ),
              padding2,
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CachedCircularNetworkImageWidget(
                      image: productImage, size: 16),
                  SizedBox(
                    width: 5.w,
                  ),
                  Text(
                    invoice.company?.companyType ?? '',
                    style: getRegularStyle(
                        fontSize: MyFonts.size12, color: context.titleColor),
                  ),
                ],
              ),
              padding4,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 5.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Consumer(
                      builder: (BuildContext context, WidgetRef ref, Widget? child) {
                        final dashBoardCtr = ref.watch(dashBoardNotifierCtr);
                        return Text(
                          '${dashBoardCtr.currencyTypeEnum?.type}${invoice.total}',
                          style: getMediumStyle(
                              fontSize: MyFonts.size14, color: context.titleColor),
                        );
                      },

                    ),
                    Container(
                      height: 12.h,
                      width: 1.w,
                      color: context.bodyTextColor.withOpacity(0.3),
                    ),
                    Text(
                      formatDayMonthYear(invoice.dueDate),
                      style: getRegularStyle(
                          fontSize: MyFonts.size14, color: context.titleColor),
                    ),
                    Container(
                      height: 12.h,
                      width: 1.w,
                      color: context.bodyTextColor.withOpacity(0.3),
                    ),
                    invoice.isPaid ?? false
                        ? Container(
                            padding: EdgeInsets.symmetric(
                              vertical: 0.h,
                              horizontal: 8.w,
                            ),
                            decoration: BoxDecoration(
                              color: !invoice.isPaid!
                                  ? MyColors.orange
                                  : MyColors.green,
                              borderRadius: BorderRadius.circular(6.r),
                            ),
                            child: Text(
                              !invoice.isPaid! ? "Due" : 'Paid',
                              style: getLightStyle(
                                  fontSize: MyFonts.size10,
                                  color: context.whiteColor),
                            ),
                          )
                        : padding8,
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
