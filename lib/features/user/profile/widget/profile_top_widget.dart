import '../../../../commons/common_imports/common_libs.dart';
import '../../../../commons/common_widgets/cached_retangular_network_image.dart';
import '../../../../utils/constants/app_constants.dart';

class ProfileTopWidget extends StatelessWidget {
  final String? imageUrl;
  final String name;
  final String address;
  final Widget companyCount;
  final Widget customerCount;
  final Widget invoiceCount;
  const ProfileTopWidget({
    required this.name,
    required this.address,
    this.imageUrl,
    required this.companyCount,
    required this.customerCount,
    required this.invoiceCount,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300.h,
      width: double.infinity,
      decoration: BoxDecoration(
          color: context.greenColor,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20.r),
              bottomRight: Radius.circular(20.r))),
      child: Column(
        children: [
          Container(
              height: 220.h,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: context.whiteColor,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20.r),
                      bottomRight: Radius.circular(20.r))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10.h,
                  ),
                   CachedRectangularNetworkImageWidget(
                      image: imageUrl != '' ? imageUrl! : personImg, width: 120, height: 120),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(
                    name,
                    style: getSemiBoldStyle(
                        color: context.titleColor,
                        fontSize: MyFonts.size16),
                  ),
                  Text(
                    address, //'''2972 Westheimer Rd. Santa Ana, Illinois 85486 ',
                    style: getRegularStyle(
                        color: context.bodyTextColor,
                        fontSize: MyFonts.size14),
                  ),
                ],
              )),
          SizedBox(
            height: 10.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 30.w,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    companyCount,
                    // Text(
                    //   companyCount,
                    //   style: getBoldStyle(
                    //       color: context.whiteColor,
                    //       fontSize: MyFonts.size16),
                    // ),
                    Text(
                      'Company',
                      style: getRegularStyle(
                          color: context.whiteColor,
                          fontSize: MyFonts.size14),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    customerCount,
                    // Text(
                    //   '220',
                    //   style: getBoldStyle(
                    //       color: context.whiteColor,
                    //       fontSize: MyFonts.size16),
                    // ),
                    Text(
                      'Customers',
                      style: getRegularStyle(
                          color: context.whiteColor,
                          fontSize: MyFonts.size14),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    invoiceCount,
                    // Text(
                    //   '60',
                    //   style: getBoldStyle(
                    //       color: context.whiteColor,
                    //       fontSize: MyFonts.size16),
                    // ),
                    Text(
                      'Invoices',
                      style: getRegularStyle(
                          color: context.whiteColor,
                          fontSize: MyFonts.size14),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}