import '../../../../commons/common_imports/apis_commons.dart';
import '../../../../commons/common_imports/common_libs.dart';
import '../../../../commons/common_shimmers/loading_images_shimmer.dart';
import '../../../../commons/common_widgets/cached_retangular_network_image.dart';
import '../../../../commons/common_widgets/common_appbar.dart';
import '../../../../models/customer_model/customer_model.dart';
import '../../../../utils/constants/app_constants.dart';
import '../../../../utils/constants/assets_manager.dart';
import '../../main_menu/controller/main_menu_controller.dart';
import '../dashboard_extended/customers/controller/customer_controller.dart';

class FrequentClientsSeeMoreScreen extends ConsumerWidget {
  const FrequentClientsSeeMoreScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: CustomAppBar(
        title: 'Frequent Clients',
        onPressed:  () {
          final mainMenuCtr = ref.watch(mainMenuProvider);
          mainMenuCtr.setIndex(0);
          Navigator.pop(context);
        },
      ),
      body: Padding(
        padding: EdgeInsets.all(AppConstants.padding),
        child: Consumer(builder: (context, ref, child) {
          return ref.watch(getAllCustomersProvider(context)).when(
            data: (customersList) {
              return customersList.isEmpty
                  ? Center(
                      child: Text(
                        'No customer found',
                        style: getMediumStyle(
                            color: context.titleColor, fontSize: MyFonts.size15),
                      ),
                    )
                  : ListView.builder(
                      itemCount: customersList.length,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        CustomerModel customer = customersList[index];
                        return Container(
                          padding: EdgeInsets.symmetric(horizontal: 10.0.w, vertical: 10.h),
                          decoration: BoxDecoration(
                            color: MyColors.facebookContainerColor,
                            borderRadius: BorderRadius.circular(12.r)
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(right: 10.0.w),
                            child: Row(
                              children: [
                                if (customer.image != '')
                                  CachedRectangularNetworkImageWidget(
                                      image: customer.image, width: 60, height: 60),
                                if (customer.image == '')
                                  Container(
                                    width: 60.w,
                                    height: 60.h,
                                    padding: EdgeInsets.all(8.sp),
                                    decoration: BoxDecoration(
                                        color: context.greenColor.withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(8.r),
                                        border: Border.all(
                                            color: context.containerColor,
                                            width: 1.w)),
                                    child: Image.asset(
                                      AppAssets.profileIcon,
                                      color: context.greenColor,
                                    ),
                                  ),
                                SizedBox(width: 20.w,),
                                Text(customer.name,
                                    style: getRegularStyle(
                                        color: context.titleColor,
                                        fontSize: MyFonts.size16)),
                              ],
                            ),
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
      ),
    );
  }
}
