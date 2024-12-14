import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:invoice_producer/commons/common_imports/common_libs.dart';
import 'package:invoice_producer/features/auth/controller/auth_notifier_controller.dart';
import 'package:invoice_producer/features/user/dashboard/widgets/dashboard_features.dart';
import 'package:invoice_producer/features/user/dashboard/widgets/frequent_client_widget.dart';
import 'package:invoice_producer/features/user/dashboard/widgets/recent_invoices_widget.dart';
import 'package:invoice_producer/features/user/dashboard/widgets/watch_tutorial_widget.dart';
import 'package:invoice_producer/routes/route_manager.dart';
import 'package:invoice_producer/utils/constants/app_constants.dart';
import 'package:invoice_producer/utils/constants/assets_manager.dart';
import '../widgets/dashboard_Stats_widget.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userRef = ref.watch(authNotifierCtr).userModel;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.all(AppConstants.padding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () async {
                            // ref.read(invoiceUploadControllerProvider.notifier)
                            //     .deleteAllUserInvoices();
                          },
                          child: Text(
                            'Hi ${userRef?.fullName ?? ''}',
                            style: getLibreBaskervilleExtraBoldStyle(
                                color: context.titleColor,
                                fontSize: MyFonts.size18),
                          ),
                        ),
                        SizedBox(
                          height: 3.h,
                        ),
                        Text(
                          'Take a look for your last activity',
                          style: getRegularStyle(
                              color: context.bodyTextColor,
                              fontSize: MyFonts.size12),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                                context, AppRoutes.searchInvoiceScreen);
                          },
                          child: Container(
                            color: context.scaffoldBackgroundColor,
                            child: Image.asset(AppAssets.searchIcon,
                                width: 26.w,
                                height: 26.h,
                                color: context.titleColor),
                          ),
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                                context, AppRoutes.notificationScreen);
                          },
                          child: Container(
                            color: context.scaffoldBackgroundColor,
                            child: Image.asset(AppAssets.notificationIcon,
                                width: 24.w,
                                height: 24.h,
                                color: context.titleColor),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.h,
                ),
                const DashboardFeaturesWidget(),
                SizedBox(
                  height: 20.h,
                ),
                const DashboardStatsWidget(),
                SizedBox(
                  height: 20.h,
                ),
                const WatchTutorialWidget(),
                SizedBox(
                  height: 10.h,
                ),
                const FrequentClientWidget(),
                const RecentInvoicesWidget(),
                SizedBox(
                  height: 40.h,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
