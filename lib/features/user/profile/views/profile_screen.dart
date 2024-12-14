import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:invoice_producer/commons/common_imports/apis_commons.dart';
import 'package:invoice_producer/core/extensions/color_extension.dart';
import 'package:invoice_producer/features/auth/controller/auth_controller.dart';
import 'package:invoice_producer/features/auth/controller/auth_notifier_controller.dart';
import 'package:invoice_producer/features/user/dashboard/dashboard_extended/company/controller/comany_controller.dart';
import 'package:invoice_producer/features/user/dashboard/dashboard_extended/customers/controller/customer_controller.dart';
import 'package:invoice_producer/features/user/invoice/controller/invoice_upload_controller.dart';
import 'package:invoice_producer/features/user/profile/widget/profile_button.dart';
import 'package:invoice_producer/routes/route_manager.dart';
import 'package:invoice_producer/utils/loading.dart';
import 'package:invoice_producer/utils/themes/styles_manager.dart';
import '../../../../utils/constants/assets_manager.dart';
import '../../../../utils/constants/font_manager.dart';
import '../../main_menu/controller/main_menu_controller.dart';
import '../widget/delete_account_dialog_box.dart';
import '../widget/profile_top_widget.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _AddPaymentAccountScreenState();
}

class _AddPaymentAccountScreenState extends ConsumerState<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final userModel = ref.watch(authNotifierCtr).userModel;
    return WillPopScope(
      onWillPop: () async {
        final mainMenuCtr = ref.watch(mainMenuProvider);
        mainMenuCtr.setIndex(0);
        return false;
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          backgroundColor: context.scaffoldBackgroundColor,
          leading: Consumer(builder: (context, ref, child) {
            final mainMenuCtr = ref.watch(mainMenuProvider);
            return IconButton(
              onPressed: () {
                mainMenuCtr.setIndex(0);
              },
              icon: Image.asset(AppAssets.backArrowIcon,
                  width: 20.w, height: 20.h, color: context.titleColor),
            );
          }),
          title: Text(
            'My profile',
            style: getLibreBaskervilleBoldStyle(
                color: context.titleColor, fontSize: MyFonts.size16),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              ProfileTopWidget(
                imageUrl: userModel?.profileImage,
                name: userModel?.fullName ?? '',
                address: userModel?.address ?? 'address',
                companyCount: (ref
                    .watch(getCompaniesCountProvider(context))
                    .when(
                        data: (count) => Text(
                              count.toString(),
                              style: getBoldStyle(
                                  color: context.whiteColor,
                                  fontSize: MyFonts.size16),
                            ),
                        error: (error, st) => Text(
                              '#',
                              style: getBoldStyle(
                                  color: context.whiteColor,
                                  fontSize: MyFonts.size16),
                            ),
                        loading: () => LoadingWidget(
                            size: 12.r, color: context.whiteColor))),
                customerCount: (ref
                    .watch(getCustomerCountProvider(context))
                    .when(
                    data: (count) => Text(
                      count.toString(),
                      style: getBoldStyle(
                          color: context.whiteColor,
                          fontSize: MyFonts.size16),
                    ),
                    error: (error, st) => Text(
                      '#',
                      style: getBoldStyle(
                          color: context.whiteColor,
                          fontSize: MyFonts.size16),
                    ),
                    loading: () => LoadingWidget(
                        size: 12.r, color: context.whiteColor))),
                invoiceCount: (ref
                    .watch(getInvoicesCountProvider(context))
                    .when(
                    data: (count) => Text(
                      count.toString(),
                      style: getBoldStyle(
                          color: context.whiteColor,
                          fontSize: MyFonts.size16),
                    ),
                    error: (error, st) => Text(
                      '#',
                      style: getBoldStyle(
                          color: context.whiteColor,
                          fontSize: MyFonts.size16),
                    ),
                    loading: () => LoadingWidget(
                        size: 12.r, color: context.whiteColor))),
              ),
              SizedBox(
                height: 10.h,
              ),
              ProfileButton(
                icon: AppAssets.settingIcon,
                name: 'App settings',
                onTap: () {
                  Navigator.pushNamed(context, AppRoutes.appSettingScreen);
                },
              ),
              ProfileButton(
                icon: AppAssets.editIcon,
                name: 'Edit profile',
                onTap: () {
                  Navigator.pushNamed(context, AppRoutes.editProfileScreen);
                },
              ),
              // ProfileButton(
              //   icon: AppAssets.subscriptionIcon,
              //   name: 'My subscription',
              //   onTap: () {
              //     Navigator.pushNamed(context, AppRoutes.mySubscription);
              //   },
              // ),
              ProfileButton(
                icon: AppAssets.paymentIcon,
                name: 'Payment settings',
                onTap: () {
                  Navigator.pushNamed(context, AppRoutes.paymentSettingScreen);
                },
              ),
              ProfileButton(
                icon: AppAssets.helpIcon,
                name: 'Helps',
                onTap: () {
                  Navigator.pushNamed(context, AppRoutes.helpScreen);
                },
              ),
              ProfileButton(
                icon: AppAssets.taxIcon,
                name: 'Tax settings',
                onTap: () {
                  Navigator.pushNamed(context, AppRoutes.taxSettings);
                },
              ),
              ProfileButton(
                icon: AppAssets.termIcon,
                name: 'Terms and conditions',
                onTap: () {
                  Navigator.pushNamed(
                      context, AppRoutes.termAndConditionScreen);
                },
              ),
              ProfileButton(
                icon: AppAssets.logoutIcon,
                name: 'logout',
                onTap: () async {
                  await ref
                      .read(authControllerProvider.notifier)
                      .logout(context: context);
                },
              ),
              ProfileButton(
                icon: AppAssets.deleteIcon,
                name: 'Delete Account',
                onTap: () async {
                  deleteAccountDialog(context);
                },
              ),
              SizedBox(
                height: 100.h,
              ),
            ],
          ),
        ),
      ),
    );
  }

  deleteAccountDialog(BuildContext context) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return const DeleteAccountDialogBox();
        });
  }
}
