import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:invoice_producer/commons/common_imports/apis_commons.dart';
import 'package:invoice_producer/commons/common_imports/common_libs.dart';
import 'package:invoice_producer/core/enums/currency_sign_enum.dart';
import 'package:invoice_producer/features/auth/view/add_payment_account_screen.dart';
import 'package:invoice_producer/features/user/profile/Profile_Extended/app_setting/widget/switch_button.dart';
import 'package:invoice_producer/features/user/profile/Profile_Extended/payment_settings/controller/payment_controller.dart';
import 'package:invoice_producer/features/user/profile/Profile_Extended/payment_settings/widgets/select_currency_widgt.dart';
import 'package:invoice_producer/routes/route_manager.dart';
import 'package:invoice_producer/utils/constants/app_constants.dart';
import '../../../../../../commons/common_functions/padding.dart';
import '../../../../../../commons/common_shimmers/list_item_shimmer.dart';
import '../../../../../../commons/common_widgets/floatingActionButton.dart';
import '../../../../../../core/services/shared_prefs_service.dart';
import '../../../../../../utils/constants/assets_manager.dart';
import '../../../../../../utils/loading.dart';
import '../../../../dashboard/controller/dashboard_notifiar_ctr.dart';
import '../widgets/payment_account_card.dart';

class PaymentSettingScreen extends ConsumerStatefulWidget {
  const PaymentSettingScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<PaymentSettingScreen> createState() =>
      _PaymentSettingScreenState();
}

class _PaymentSettingScreenState extends ConsumerState<PaymentSettingScreen> {
  bool isEmail = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.scaffoldBackgroundColor,
      floatingActionButton: CustomFloatingActionButton(
        onTap: () {
          Navigator.pushNamed(context, AppRoutes.addPaymentAccountScreen,
              arguments: {'skip': false});
        },
      ),
      appBar: AppBar(
        backgroundColor: context.scaffoldBackgroundColor,
        leading: Consumer(builder: (context, ref, child) {
          return IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Image.asset(AppAssets.backArrowIcon,
                width: 20.w, height: 20.h, color: context.titleColor),
          );
        }),
        title: Text(
          'Payment Settings',
          style: getLibreBaskervilleBoldStyle(
              color: context.titleColor, fontSize: MyFonts.size16),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.all(AppConstants.padding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SwitchButton(
                  onTap: () {
                    setState(() {
                      isEmail = !isEmail;
                    });
                  },
                  title: 'Email',
                  value: isEmail
              ),
              Consumer(
                builder: (BuildContext context, WidgetRef ref, Widget? child) {
                  final dashBoardCtr = ref.watch(dashBoardNotifierCtr);
                  final sharedPrefCtr = ref.watch(sharedPrefsCtr);
                  return SelectCurrencyWidget(
                    itemValues: [
                      CurrencySignEnum.USD.name,
                      CurrencySignEnum.EUR.name,
                      CurrencySignEnum.GBP.name,
                      CurrencySignEnum.JPY.name,
                      CurrencySignEnum.ZAR.name,
                      CurrencySignEnum.BDT.name,
                      CurrencySignEnum.INR.name,
                    ],
                    value: getCurrencySign(dashBoardCtr.currencyTypeEnum!.name).name,
                    onChanged: (value) {
                      dashBoardCtr.setCurrency(
                        getCurrencySign(value),
                      );
                      sharedPrefCtr.setCurrency(value!);
                    },
                  );
                },
              ),
              Text(
                "Added payment account",
                  style: getSemiBoldStyle(
                      color: context.titleColor,
                      fontSize: MyFonts.size18,
                  ),
              ),
              padding12,
              ref.watch(getAllPaymentAccountsProvider(context)).when(
                data: (paymentAccountList) {
                  return paymentAccountList.isEmpty
                      ? const Center(child: Text('No payment account found'))
                      : ListView.builder(
                          itemCount: paymentAccountList.length,
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            final paymentAccount = paymentAccountList[index];
                            return PaymentAccountCard(
                              paymentAcc: paymentAccount,
                              onSelect: (value) {
                                if (value == 'edit') {
                                  Navigator.pushNamed(context,
                                      AppRoutes.addPaymentAccountScreen,
                                      arguments: {
                                        'paymentAccount': paymentAccount,
                                        'skip': false
                                      });
                                } else {
                                  ref
                                      .read(paymentAccountControllerProvider
                                          .notifier)
                                      .deletePaymentAccount(
                                          context: context,
                                          paymentId: paymentAccount.paymentId);
                                }
                              },
                            );
                          });
                },
                error: (error, st) {
                  debugPrintStack(stackTrace: st);
                  debugPrint(error.toString());
                  return ErrorWidget(error);
                },
                loading: () {
                  return ListView.builder(
                      itemCount: 3,
                      shrinkWrap: true,
                      itemBuilder: (context, snapshot) {
                        return const ListItemShimmer();
                      });
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
}
