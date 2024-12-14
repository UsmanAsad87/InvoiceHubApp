import 'dart:async';
import 'package:invoice_producer/routes/route_manager.dart';
import 'package:invoice_producer/utils/constants/assets_manager.dart';
import '../../../commons/common_imports/common_libs.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    Timer(
        const Duration(seconds: 3),
            () => Navigator.pushNamedAndRemoveUntil(
                context,
                AppRoutes.introductionScreen,
                    (route) => false)
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: context.scaffoldBackgroundColor,
        body: Center(
          child: Padding(
            padding: EdgeInsets.all(40.h),
            child: Image.asset(
              AppAssets.splashImage,
              // height: 215.h,
              width: 250.w,
            ),
          ),
        )
    );
  }

  // Widget build(BuildContext context) {
  //   return Scaffold(
  //       backgroundColor: context.scaffoldBackgroundColor,
  //       body: Center(
  //         child: SizedBox(
  //           height: 600.h,
  //           width: MediaQuery.of(context).size.height,
  //           child: Image.asset(
  //             AppAssets.splash01Image,
  //             fit: BoxFit.cover,
  //           ),
  //         ),
  //       ));
  // }
}
