import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:invoice_producer/commons/common_functions/padding.dart';
import 'package:invoice_producer/commons/common_widgets/custom_button.dart';
import 'package:invoice_producer/features/auth/controller/auth_notifier_controller.dart';
import 'package:invoice_producer/features/user/profile/Profile_Extended/My_Subscription/widgets/custom_container.dart';
import '../../../../../../commons/common_imports/common_libs.dart';
import '../../../../../../utils/constants/assets_manager.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:in_app_purchase_android/in_app_purchase_android.dart';

const List<String> _productsId = [
  '1Month',
  '3Months',
  '1Year',
];

class MySubscription extends ConsumerStatefulWidget {
  const MySubscription({Key? key}) : super(key: key);

  @override
  ConsumerState<MySubscription> createState() => _MySubscriptionState();
}

class _MySubscriptionState extends ConsumerState<MySubscription> {
  int selectedIndex = 2;

  InAppPurchase _inAppPurchase = InAppPurchase.instance;
  bool _isAvailable = false;
  List<ProductDetails> _products = [];

  initStoreInfo() async {
    final bool isAvailable = await _inAppPurchase.isAvailable();
    setState(() {
      _isAvailable = isAvailable;
    });
    ProductDetailsResponse productDetailResponse =
        await _inAppPurchase.queryProductDetails(_productsId.toSet());

    setState(() {
      _products = productDetailResponse.productDetails;
    });
  }

  @override
  void initState() {
    initStoreInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(authNotifierCtr).userModel;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: context.scaffoldBackgroundColor,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Image.asset(AppAssets.backArrowIcon,
              width: 20.w, height: 20.h, color: context.titleColor),
        ),
        title: Text(
          'My subscription',
          style: getLibreBaskervilleExtraBoldStyle(
              color: context.titleColor, fontSize: MyFonts.size16),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: 114.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: context.whiteColor,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20.r),
                          bottomRight: Radius.circular(20.r))),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 176.h,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: context.greenColor,
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(20.r),
                                bottomRight: Radius.circular(20.r),
                              )),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 100.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: context.whiteColor,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20.r),
                          bottomRight: Radius.circular(20.r))),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Current plan',
                              style: getLibreBaskervilleBoldStyle(
                                  color: Colors.black,
                                  fontSize: MyFonts.size16),
                            ),
                            padding4,
                            Text(
                              user!.subscriptionName!,
                              style: getSemiBoldStyle(
                                  color: context.titleColor,
                                  fontSize: MyFonts.size14),
                            ),
                            padding4,
                            Text(
                              'Expires on ${DateFormat.yMMMMd().format(user.subscriptionExpire!)}',
                              style: getRegularStyle(
                                  color: context.titleColor,
                                  fontSize: MyFonts.size12),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              '${user.subscriptionExpire!.difference(DateTime.now()).inDays}',
                              style: getBoldStyle(
                                  color: context.titleColor,
                                  fontSize: MyFonts.size24),
                            ),
                            padding4,
                            Text(
                              'Days left',
                              style: getRegularStyle(
                                  color: context.titleColor,
                                  fontSize: MyFonts.size12),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
            padding12,
            Text(
              'Get Started Today',
              style: getBoldStyle(
                  color: context.titleColor, fontSize: MyFonts.size16),
            ),
            Text(
              'Choose the right plan for you',
              style: getRegularStyle(
                  color: context.titleColor.withOpacity(.5),
                  fontSize: MyFonts.size14),
              textAlign: TextAlign.center,
            ),
            ListView.builder(
                itemCount: 3, // _products.length,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return SubscriptionWidget(
                    title: '30 days free trial',
                    description:
                        'Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit',
                    index: index,
                    selectedIndex: selectedIndex,
                    onTap: () {
                      setState(() {
                        selectedIndex = index;
                      });
                    },
                  );
                }),
            // SubscriptionWidget(
            //   title: '30 days free trial',
            //   description:
            //       'Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit',
            //   index: 0,
            //   selectedIndex: selectedIndex,
            //   onTap: () {
            //     setState(() {
            //       selectedIndex = 0;
            //     });
            //   },
            // ),
            // SubscriptionWidget(
            //   title: '\$10/ 1Month',
            //   description:
            //       'Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit',
            //   index: 1,
            //   selectedIndex: selectedIndex,
            //   onTap: () {
            //     setState(() {
            //       selectedIndex = 1;
            //     });
            //   },
            // ),
            // SubscriptionWidget(
            //   title: '\$25/ 3Month',
            //   description:
            //       'Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit',
            //   index: 2,
            //   selectedIndex: selectedIndex,
            //   onTap: () {
            //     setState(() {
            //       selectedIndex = 2;
            //     });
            //   },
            // ),
            // SubscriptionWidget(
            //   title: '\$80/Year',
            //   description:
            //       'Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit',
            //   index: 3,
            //   selectedIndex: selectedIndex,
            //   onTap: () {
            //     setState(() {
            //       selectedIndex = 3;
            //     });
            //   },
            // ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 18.r, vertical: 8.r),
              child: CustomButton(
                onPressed: () {
                  /// subscription button code

                  late PurchaseParam purchaseParam;
                  if (Platform.isAndroid) {
                    purchaseParam = GooglePlayPurchaseParam(
                        productDetails: _products[selectedIndex],
                        changeSubscriptionParam: null);
                  } else {
                    purchaseParam = PurchaseParam(productDetails: _products[selectedIndex]);
                  }

                  InAppPurchase.instance.buyNonConsumable(
                      purchaseParam: purchaseParam);
                },
                buttonText: 'Get started',
              ),
            )
          ],
        ),
      ),
    );
  }
}

class SubscriptionWidget extends StatelessWidget {
  const SubscriptionWidget({
    super.key,
    required this.title,
    required this.description,
    required this.onTap,
    required this.index,
    required this.selectedIndex,
  });

  final String title;
  final String description;
  final Function() onTap;
  final int index;
  final int selectedIndex;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: onTap,
          child: CustomContainer(
              textColor: index == selectedIndex ? context.whiteColor : null,
              color: index == selectedIndex ? context.greenColor : null,
              title: title,
              description: description),
        ),
        if (index == selectedIndex)
          Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: EdgeInsets.all(24.r),
                child: Icon(
                  Icons.check_circle,
                  color: context.whiteColor,
                  size: 30,
                ),
              ))
      ],
    );
  }
}
