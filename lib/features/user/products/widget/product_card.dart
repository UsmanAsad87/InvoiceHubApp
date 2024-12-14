import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:invoice_producer/commons/common_imports/common_libs.dart';
import 'package:invoice_producer/commons/common_widgets/cached_circular_network_image.dart';
import 'package:invoice_producer/utils/constants/app_constants.dart';
import 'package:invoice_producer/utils/constants/assets_manager.dart';

import '../../../../commons/common_widgets/cached_retangular_network_image.dart';
import '../../../../models/product_model/item_model.dart';
import '../../dashboard/controller/dashboard_notifiar_ctr.dart';

class ProductCard extends StatelessWidget {
  final ItemModel product;
  final onSelect;
  const ProductCard({
    super.key,
    required this.product,
    required this.onSelect
  });

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
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                   // CachedRectangularNetworkImageWidget(
                   //    image: product.image, width: 76, height: 76),
                  if (product.image != '')
                    CachedRectangularNetworkImageWidget(
                        image: product.image, width: 76, height: 76),
                  if (product.image == '')
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
                        AppAssets.productIcon,
                        color: context.greenColor,
                      ),
                    ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        product.name,
                        style: getSemiBoldStyle(
                            fontSize: MyFonts.size14,
                            color: context.titleColor),
                      ),
                      Consumer(
                        builder: (BuildContext context, WidgetRef ref, Widget? child) {
                          final dashBoardCtr = ref.watch(dashBoardNotifierCtr);
                          return Text(
                            '${product.currency.type} ${product.finalRate}',
                            // '${dashBoardCtr.currencyTypeEnum?.type} ${product.finalRate}',
                            style: getRegularStyle(
                                fontSize: MyFonts.size14,
                                color: context.titleColor),
                          );
                        },
                      ),
                      Text(
                        product.itemType.mode,
                        style: getMediumStyle(
                            fontSize: MyFonts.size12,
                            color: context.titleColor),
                      ),
                    ],
                  ),
                ],
              ),
              PopupMenuButton<String>(
                onSelected: onSelect,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.r),
                ),
                elevation: 2,
                itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                  PopupMenuItem<String>(
                    value: 'edit',
                    height: 30.h,
                    padding: EdgeInsets.only(left: 15.w, right: 30.w),
                    child: Row(
                      children: [
                        Image.asset(AppAssets.editProductIcon,
                            width: 16.w, height: 16.h),
                        SizedBox(width: 8.w),
                        Text(
                          'Edit',
                          style: getMediumStyle(
                              color: context.titleColor,
                              fontSize: MyFonts.size14),
                        ),
                      ],
                    ),
                  ),
                  PopupMenuItem<String>(
                    value: 'delete',
                    height: 30.h,
                    padding: EdgeInsets.only(left: 15.w, right: 40.w),
                    child: Row(
                      children: [
                        Image.asset(AppAssets.deleteIcon,
                            width: 16.w, height: 16.h),
                        SizedBox(width: 8.w),
                        Text(
                          'Delete',
                          style: getMediumStyle(
                              color: context.titleColor,
                              fontSize: MyFonts.size14),
                        ),
                      ],
                    ),
                  ),
                ],
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
