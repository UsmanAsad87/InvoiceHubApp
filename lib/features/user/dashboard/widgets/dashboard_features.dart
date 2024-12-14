import 'package:invoice_producer/commons/common_imports/common_libs.dart';
import 'package:invoice_producer/routes/route_manager.dart';
import 'package:invoice_producer/utils/constants/assets_manager.dart';


class DashboardFeaturesWidget extends StatelessWidget {
  const DashboardFeaturesWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        DashboardFeatureItem(
            onTap: () {
              Navigator.pushNamed(context, AppRoutes.companiesScreen);
            },
            label: 'Company',
            icon: AppAssets.companyIcon),
        DashboardFeatureItem(
            onTap: () {
              Navigator.pushNamed(context, AppRoutes.customersScreen);
            },
            label: 'Customer',
            icon: AppAssets.customerIcon),
        // DashboardFeatureItem(
        //     onTap: () {
        //       Navigator.pushNamed(context, AppRoutes.mailsScreen);
        //
        //     },
        //     label: 'Mail',
        //     icon: AppAssets.mailIcon),
        DashboardFeatureItem(
            onTap: () {
              Navigator.pushNamed(context, AppRoutes.supportScreen);
            },
            label: 'Support',
            icon: AppAssets.supportIcon),
      ],
    );
  }
}

class DashboardFeatureItem extends StatelessWidget {
  const DashboardFeatureItem({
    super.key,
    required this.onTap,
    required this.label,
    required this.icon,
  });

  final Function() onTap;
  final String label;
  final String icon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 80.w,
      height: 75.h,
      child: InkWell(
        onTap: onTap,
        child: Container(
            decoration: BoxDecoration(
                color: context.whiteColor,
                borderRadius: BorderRadius.circular(4.r),
                border: Border.all(color: context.containerColor,width: 1.w)
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  icon,
                  width: 26.w,
                  height: 26.h,
                  color: context.greenColor
                ),
                SizedBox(
                  height: 3.h,
                ),
                Text(
                  label,
                  style: getMediumStyle(
                      fontSize: MyFonts.size12,
                      color: context.titleColor),
                )
              ],
            ),
          )

      ),
    );
  }
}
