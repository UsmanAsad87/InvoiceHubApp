import 'package:intl/intl.dart';
import 'package:invoice_producer/commons/common_imports/common_libs.dart';
import 'package:invoice_producer/commons/common_widgets/cached_circular_network_image.dart';
import 'package:invoice_producer/utils/constants/app_constants.dart';
import 'package:invoice_producer/utils/constants/assets_manager.dart';

import '../../../../../../commons/common_widgets/cached_retangular_network_image.dart';
import '../../../../../../models/customer_model/customer_model.dart';

class CustomerCard extends StatelessWidget {
  const CustomerCard({
    super.key,
    required this.customer,
    required this.onSelected
   // this.imageUrl,
  });
  // final String? imageUrl;
  final CustomerModel customer;
  final onSelected;

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
                  if (customer.image != '')
                    CachedRectangularNetworkImageWidget(
                        image: customer.image, width: 76, height: 76),
                  if (customer.image == '')
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        customer.name,
                        style: getSemiBoldStyle(
                            fontSize: MyFonts.size14,
                            color: context.titleColor),
                      ),
                      Text(
                        customer.companyName,
                        style: getRegularStyle(
                            fontSize: MyFonts.size14,
                            color: context.titleColor),
                      ),
                      SizedBox(
                        width: 200.w,
                        child: Text(
                          customer.billingAddress1,
                          overflow: TextOverflow.ellipsis,
                          style: getMediumStyle(
                              fontSize: MyFonts.size12,
                              color: context.bodyTextColor),
                        ),
                      ),
                      // SizedBox(
                      //   width: 200.w,
                      //   child: Text(
                      //     customer.workingAddress1,
                      //     overflow: TextOverflow.ellipsis,
                      //     style: getMediumStyle(
                      //         fontSize: MyFonts.size12,
                      //         color: context.bodyTextColor),
                      //   ),
                      // ),
                    ],
                  ),
                ],
              ),
              PopupMenuButton<String>(
                onSelected: onSelected,
                //     (String value) {
                //   print(value);
                // },
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
              // Container(
              //   color: context.scaffoldBackgroundColor,
              //   child: InkWell(
              //     onTap: () {},
              //     splashColor: Colors.transparent,
              //     child: Container(
              //       color: context.scaffoldBackgroundColor,
              //       padding: EdgeInsets.symmetric(
              //           horizontal: 0.w, vertical: 10.h),
              //       child: Image.asset(AppAssets.moreVertIcon,
              //           width: 24.w,
              //           height: 24.h,
              //           color: context.titleColor),
              //     ),),
              // ),
            ],
          ),
        ),
      ],
    );
  }
}