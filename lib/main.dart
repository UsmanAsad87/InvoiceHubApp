import 'dart:async';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:invoice_producer/core/enums/currency_sign_enum.dart';
import 'package:invoice_producer/features/auth/view/signin_screen.dart';
import 'package:invoice_producer/features/splash/views/splash_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:invoice_producer/commons/common_imports/common_libs.dart';
import 'package:invoice_producer/features/user/dashboard/controller/dashboard_notifiar_ctr.dart';
import 'package:invoice_producer/features/user/profile/Profile_Extended/My_Subscription/service/iap_service.dart';
import 'package:invoice_producer/routes/route_manager.dart';
import 'package:invoice_producer/utils/constants/app_constants.dart';
import 'package:invoice_producer/utils/themes/theme.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'commons/common_shimmers/loading_screen_shimmer.dart';
import 'core/services/shared_prefs_service.dart';
import 'features/auth/controller/auth_controller.dart';
import 'features/user/main_menu/views/main_menu_screen.dart';
import 'firebase_options.dart';

final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError();
});


void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey = AppConstants.stripePublisheableKey;
  await Stripe.instance.applySettings();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final sharedPreferences = await SharedPreferences.getInstance();
  ISharefPrefsController sharedPrefController = ISharefPrefsController(
      sharedPreferences: await SharedPreferences.getInstance());

  String? val = await  sharedPrefController.getCurrecny();

  FirebaseFirestore.instance.settings = const Settings(cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED);
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  runApp(ProviderScope(
      overrides: [
        sharedPrefsCtr.overrideWithValue(
          ISharefPrefsController(sharedPreferences: sharedPreferences),
        ),
      ],
      child: MyApp(
        currencySignEnum: getCurrencySign(val),
        // val!= null ?
        // val == CurrencySignEnum.USD.name ? CurrencySignEnum.USD :
        // val == CurrencySignEnum.EUR.name ? CurrencySignEnum.EUR :
        // val == CurrencySignEnum.GBP.name ? CurrencySignEnum.GBP :
        // CurrencySignEnum.JPY
        //     : CurrencySignEnum.USD,
      )));
}

class MyApp extends ConsumerStatefulWidget {
  final CurrencySignEnum currencySignEnum;
  const MyApp( {super.key, required this.currencySignEnum,});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  late StreamSubscription<List<PurchaseDetails>> _iapSubscription;

  @override
  void initState() {
    final Stream purchaseUpdate = InAppPurchase.instance.purchaseStream;
    _iapSubscription = purchaseUpdate.listen((purchaseDetails) {
      IAPService().listenToPurchaseUpdate(
          purchaseDetailList: purchaseDetails, ref: ref, context: context);
    }, onDone: () {
      _iapSubscription.cancel();
    }, onError: (error) {
      _iapSubscription.cancel();
    }) as StreamSubscription<List<PurchaseDetails>>;
    print('Currency Sign: ${widget.currencySignEnum.type}');

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(dashBoardNotifierCtr).setCurrency(widget.currencySignEnum);
    });

    super.initState();
    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    //screenUtil package to make design responsive
    return ScreenUtilInit(
      designSize:
          const Size(AppConstants.screenWidget, AppConstants.screenHeight),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          builder: (BuildContext context, Widget? child) {
            final MediaQueryData data = MediaQuery.of(context);
            //Text is generally big on IOS ro that why we set text scale factor for IOS to 0.9
            return MediaQuery(
              data: data.copyWith(
                  textScaleFactor:
                      Theme.of(context).platform == TargetPlatform.iOS ? 1 : 1),
              child: child!,
            );
          },
          debugShowCheckedModeBanner: false,
          title: 'Invoice Hub',
          theme: lightThemeData(context),
          themeMode: ThemeMode.light,
          darkTheme: darkThemeData(context),
          // initialRoute: AppRoutes.splashScreen,
          onGenerateRoute: AppRoutes.onGenerateRoute,
          home: ref.watch(userStateStreamProvider).when(
              data: (user) {
                if (user != null) {
                  return ref
                      .watch(currentAuthUserinfoStreamProvider(user.uid))
                      .when(data: (userModel) {
                    return const MainMenuScreen();
                  }, error: (error, st) {
                    debugPrintStack(stackTrace: st);
                    debugPrint(error.toString());
                    return const SignInScreen();
                  }, loading: () {
                    return Scaffold(
                      backgroundColor: context.scaffoldBackgroundColor,
                    );
                  });
                } else {
                  return const SplashScreen();
                }
              },
              error: (error, st) => const LoadingScreenShimmer(),
              loading: () => const LoadingScreenShimmer()),
        );
      },
    );
  }
}
