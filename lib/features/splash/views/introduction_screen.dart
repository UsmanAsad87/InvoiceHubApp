import 'package:invoice_producer/commons/common_widgets/custom_button.dart';
import 'package:invoice_producer/routes/route_manager.dart';
import 'package:invoice_producer/utils/constants/app_constants.dart';
import 'package:invoice_producer/utils/constants/assets_manager.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../commons/common_imports/common_libs.dart';
import '../../../commons/common_widgets/custom_outline_button.dart';

class IntroductionScreen extends StatefulWidget {
  const IntroductionScreen({super.key});

  @override
  State<IntroductionScreen> createState() => _IntroductionScreenState();
}

class _IntroductionScreenState extends State<IntroductionScreen> {
  final PageController _pageController = PageController();

  final List<String> pageContentSvg = [
    AppAssets.intro1Image,
    AppAssets.intro2Image,
    AppAssets.intro3Image,
  ];
  final List<String> pageContentLightPng = [
    AppAssets.intro1Image,
    AppAssets.intro2Image,
    AppAssets.intro3Image,
  ];

  int currentPageIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        currentPageIndex = _pageController.page!.round();
      });
    });
  }

  void next(int index) {
    // if (currentPageIndex == 2) {
    //   Navigator.pushReplacementNamed(context, AppRoutes.signInScreen);
    //   return;
    // }
    setState(() {
      currentPageIndex = index;
    });
    _pageController.animateToPage(currentPageIndex,
        duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Padding(
        padding: EdgeInsets.all(AppConstants.padding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Spacer(
              flex: 5,
            ),
            SizedBox(
              height: 350.h,
              child: PageView.builder(
                physics: const BouncingScrollPhysics(),
                controller: _pageController,
                itemCount: 3,
                itemBuilder: (context, index) {
                  return buildPage(index);
                },
              ),
            ),
            const Spacer(
              flex: 1,
            ),
            SmoothPageIndicator(
              controller: _pageController,
              count: 3,
              onDotClicked: (val) {
                next(val);
              },
              effect: ExpandingDotsEffect(
                  activeDotColor: context.greenColor,
                  dotColor: context.containerColor,
                  dotHeight: 6.h,
                  dotWidth: 24.w,
                  spacing: 5.w,
                  expansionFactor: 1.001),
            ),
            const Spacer(
              flex: 4,
            ),
            Text('Invoice Producer Secure Invoicing',style: getLibreBaskervilleExtraBoldStyle(color: context.titleColor,fontSize: MyFonts.size26),textAlign: TextAlign.center,),
            const Spacer(
              flex: 2,
            ),
            Text('Invoice producer is the largest invoicing platform and mobile application all around the world, We help our clients to create invoice automatically and securely',style: getRegularStyle(color: context.bodyTextColor,fontSize: MyFonts.size14),textAlign: TextAlign.center,),
            const Spacer(
              flex: 3,
            ),
            CustomButton(
              onPressed: () {
                Navigator.pushNamed(context, AppRoutes.signInScreen);
              },
              buttonText: 'Login',
            ),
            CustomOutlineButton(
              onPressed: () {
                Navigator.pushNamed(context, AppRoutes.signUpScreen);
              },
              buttonText: 'Register',
            ),
            SizedBox(
              height: 10.h,
            ),
            const Spacer(
              flex: 2,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildPage(int index) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Image.asset(
                pageContentLightPng[index],
                height: 323.h,
                width: 350.w,
              ),
      ],
    );
  }
}
