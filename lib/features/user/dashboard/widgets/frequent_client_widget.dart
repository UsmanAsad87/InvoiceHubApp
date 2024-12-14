import 'package:invoice_producer/commons/common_widgets/cached_retangular_network_image.dart';
import 'package:invoice_producer/routes/route_manager.dart';
import 'package:invoice_producer/utils/constants/app_constants.dart';

import '../../../../commons/common_imports/apis_commons.dart';
import '../../../../commons/common_imports/common_libs.dart';
import '../../../../commons/common_shimmers/common_shimmer.dart';
import '../../../../commons/common_shimmers/loading_images_shimmer.dart';
import '../../../../models/customer_model/customer_model.dart';
import '../../../../utils/constants/assets_manager.dart';
import '../../../../utils/loading.dart';
import '../dashboard_extended/customers/controller/customer_controller.dart';

class FrequentClientWidget extends StatelessWidget {
  const FrequentClientWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Frequently client ',
                style: getSemiBoldStyle(
                    color: context.titleColor, fontSize: MyFonts.size16)),
            TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.frequentClientsSeeMoreScreen);
                },
                child: Text(
                  'See more',
                  style: getRegularStyle(
                      color: context.greenColor, fontSize: MyFonts.size16),
                )),
          ],
        ),
        SizedBox(
          height: 90.h,
          child: Consumer(builder: (context, ref, child) {
            return ref.watch(getAllCustomersProvider(context)).when(
              data: (customersList) {
                return customersList.isEmpty
                    ? Center(
                        child: Text(
                          'No customer found',
                          style: getMediumStyle(color: context.titleColor, fontSize: MyFonts.size15),
                        ),
                      )
                    : ListView.builder(
                        itemCount: customersList.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          CustomerModel customer = customersList[index];
                          return Padding(
                            padding: EdgeInsets.only(right: 10.0.w),
                            child: Column(
                              children: [
                                // CachedRectangularNetworkImageWidget(
                                //     image: customer.image,
                                //     width: 60,
                                //     height: 60),
                                if ( customer.image != '')
                                  CachedRectangularNetworkImageWidget(
                                      image:  customer.image, width: 60, height: 60),
                                if ( customer.image == '')
                                  Container(
                                    width: 60.w,
                                    height: 60.h,
                                    padding: EdgeInsets.all(8.sp),
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
                                Text(customer.name,
                                    style: getRegularStyle(
                                        color: context.titleColor,
                                        fontSize: MyFonts.size12)),
                              ],
                            ),
                          );
                        });
              },
              error: (error, st) {
                debugPrintStack(stackTrace: st);
                debugPrint(error.toString());
                return ListView.builder(
                  itemCount: 4,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Container(
                        margin: EdgeInsets.symmetric(horizontal: 4.r),
                        child: ShimmerWidget(
                          width: 70.w,
                          height: 60.h,
                        ));
                  },
                );
              },
              loading: () {
                return ListView.builder(
                  itemCount: 4,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Container(
                        margin: EdgeInsets.symmetric(horizontal: 4.r),
                        child: ShimmerWidget(
                          width: 70.w,
                          height: 60.h,
                        ));
                  },
                );
              },
            );
          }),
          // ListView.builder(
          //     itemCount: 10,
          //     scrollDirection: Axis.horizontal,
          //     itemBuilder: (context, index) {
          //       return Padding(
          //         padding:EdgeInsets.only(right: 10.0.w),
          //         child: Column(
          //           children: [
          //             const CachedRectangularNetworkImageWidget(
          //                 image: personImg, width: 60, height: 60),
          //             Text('Cooper',
          //                 style: getRegularStyle(
          //                     color: context.titleColor,
          //                     fontSize: MyFonts.size12)),
          //           ],
          //         ),
          //       );
          //     }),
        )
      ],
    );
  }
}
