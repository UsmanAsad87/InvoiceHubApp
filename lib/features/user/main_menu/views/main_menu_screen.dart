import 'package:invoice_producer/core/extensions/color_extension.dart';
import 'package:invoice_producer/features/user/main_menu/controller/main_menu_controller.dart';
import 'package:invoice_producer/features/user/main_menu/widgets/bottom_bar_item.dart';
import 'package:invoice_producer/features/user/userController.dart';
import 'package:invoice_producer/utils/constants/assets_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:io' show Platform;

class MainMenuScreen extends ConsumerStatefulWidget {
  const MainMenuScreen({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<MainMenuScreen> createState() => _MainMenuScreenState();
}

class _MainMenuScreenState extends ConsumerState<MainMenuScreen> {
  @override
  initState() {
   initialization();
    super.initState();
  }

  /// Here in this method, we are initializing necessary methods
  initialization() async {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      UserController().refreshUserData(ref);

      // final authCtr = ref.read(authControllerProvider.notifier);
      // UserModel userModel = await authCtr.getCurrentUserInfo();
      // final authNotifierProvider = ref.read(authNotifierCtr.notifier);
      // authNotifierProvider.setUserModelData(userModel);
    });
  }

  @override
  Widget build(BuildContext context) {
    final mainMenuCtr = ref.watch(mainMenuProvider);
    return Scaffold(
      backgroundColor: context.scaffoldBackgroundColor,
      body: IndexedStack(
        children: [mainMenuCtr.screens[mainMenuCtr.index]],
      ),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          canvasColor:  context.containerColor.withOpacity(0.5),
        ),
        child: Container(
          height: Platform.isAndroid ?70.h:100.h,
          decoration: BoxDecoration(
              boxShadow: [
            BoxShadow(
              color: context.greenColor.withOpacity(0.5),
              blurRadius: 5.0,
              spreadRadius: 1.0,
              offset: const Offset(0, 2),
            ),
          ]),
          child: BottomAppBar(
            color: context.whiteColor,
            surfaceTintColor: context.whiteColor,
            //shadowColor: context.whiteColor,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 0.h, horizontal: 4.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  BottomBarItem(
                    mainMenuCtr: mainMenuCtr,
                    onTap: () {
                      mainMenuCtr.setIndex(0);
                    },
                    label: 'Dashboard',
                    icon: AppAssets.dashboardIcon,
                    index: 0,
                  ),
                  BottomBarItem(
                    mainMenuCtr: mainMenuCtr,
                    onTap: () {
                      mainMenuCtr.setIndex(1);
                    },
                    label: 'Product',
                    icon: AppAssets.productIcon,
                    index: 1,
                  ),
                  BottomBarItem(
                    mainMenuCtr: mainMenuCtr,
                    onTap: () {
                      mainMenuCtr.setIndex(2);
                    },
                    label: '',
                    icon: AppAssets.addIcon,
                    index: 2,
                    isAdd: true,
                  ),
                  BottomBarItem(
                    mainMenuCtr: mainMenuCtr,
                    onTap: () {
                      mainMenuCtr.setIndex(3);
                    },
                    label: 'Reports',
                    icon: AppAssets.reportIcon,
                    index: 3,
                  ),
                  BottomBarItem(
                    mainMenuCtr: mainMenuCtr,
                    onTap: () {
                      mainMenuCtr.setIndex(4);
                    },
                    label: 'Profile',
                    icon: AppAssets.profileIcon,
                    index: 4,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
