import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:invoice_producer/commons/common_imports/apis_commons.dart';
import 'package:invoice_producer/commons/common_widgets/custom_button.dart';
import 'package:invoice_producer/core/enums/currency_sign_enum.dart';
import 'package:invoice_producer/models/payment_account_model/payment_account_model.dart';
import '../../../../../../commons/common_functions/padding.dart';
import '../../../../../../commons/common_imports/common_libs.dart';
import '../../../../../../commons/common_shimmers/list_item_shimmer.dart';
import '../../../../../../commons/common_widgets/floatingActionButton.dart';
import '../../../../../../commons/common_widgets/show_toast.dart';
import '../../../../../../core/services/shared_prefs_service.dart';
import '../../../../../../utils/constants/app_constants.dart';
import '../../../../../../utils/constants/assets_manager.dart';
import '../../../../../../utils/loading.dart';
import '../../../../../auth/view/add_payment_account_screen.dart';
import '../../../../dashboard/controller/dashboard_notifiar_ctr.dart';
import '../../../../profile/Profile_Extended/app_setting/widget/switch_button.dart';
import '../../../../profile/Profile_Extended/payment_settings/controller/payment_controller.dart';
import '../../../../profile/Profile_Extended/payment_settings/widgets/select_currency_widgt.dart';
import '../../../controller/invoice_controller.dart';
import '../widgets/payment_method_container.dart';

class PaymentMethodScreen extends ConsumerStatefulWidget {
  const PaymentMethodScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<PaymentMethodScreen> createState() =>
      _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends ConsumerState<PaymentMethodScreen> {
  bool isEmail = true;
  int selectedPaymentIndex = -1;
  PaymentAccountModel? selectedPayment;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      selectedPayment = ref.read(invoiceDataProvider.notifier).paymentModel;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.scaffoldBackgroundColor,
      floatingActionButton: CustomFloatingActionButton(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return AddPaymentAccountScreen(
              skip: false,
            );
          }));
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
          'Payment method',
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
              // SwitchButton(
              //     onTap: () {
              //       setState(() {
              //         isEmail = !isEmail;
              //       });
              //     },
              //     title: 'Email',
              //     value: isEmail),
              // Consumer(
              //   builder: (BuildContext context, WidgetRef ref, Widget? child) {
              //     final dashBoardCtr = ref.watch(dashBoardNotifierCtr);
              //     final sharedPrefCtr = ref.watch(sharedPrefsCtr);
              //     return SelectCurrencyWidget(
              //         itemValues: [
              //           CurrencySignEnum.USD.name,
              //           CurrencySignEnum.EUR.name,
              //           CurrencySignEnum.GBP.name,
              //           CurrencySignEnum.JPY.name,
              //         ],
              //         value:
              //         dashBoardCtr.currencyTypeEnum!.name == CurrencySignEnum.USD.name ? "USD":
              //         dashBoardCtr.currencyTypeEnum!.name == CurrencySignEnum.EUR.name ? "EUR":
              //         dashBoardCtr.currencyTypeEnum!.name == CurrencySignEnum.GBP.name ? "GBP":
              //         "JPY",
              //         onChanged: (value){
              //           dashBoardCtr.setCurrency(
              //               value == CurrencySignEnum.USD.name ? CurrencySignEnum.USD :
              //               value == CurrencySignEnum.EUR.name ? CurrencySignEnum.EUR :
              //               value == CurrencySignEnum.GBP.name ? CurrencySignEnum.GBP :
              //               CurrencySignEnum.JPY
              //           );
              //           sharedPrefCtr.setCurrency(value!);
              //         });
              //   },
              // ),
              Text("Added payment account",
                  style: getSemiBoldStyle(
                      color: context.titleColor, fontSize: MyFonts.size16)),
              padding12,
              ref.watch(getAllPaymentAccountsProvider(context)).when(
                data: (paymentAccountList) {
                  if (selectedPayment != null) {
                    final index = paymentAccountList.indexWhere(
                          (payment) => payment.paymentId == selectedPayment!.paymentId,
                    );
                    selectedPaymentIndex = index;
                  }
                  return paymentAccountList.isEmpty
                      ? const Center(child: Text('No payment account found'))
                      : ListView.builder(
                          itemCount: paymentAccountList.length,
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            final paymentAccount = paymentAccountList[index];
                            return PaymentMethodContainer(
                                index: index,
                                paymentAccount: paymentAccount,
                                onChange: (value) {
                                  setState(() {
                                    selectedPaymentIndex = value;
                                    selectedPayment = paymentAccount;
                                  });
                                },
                                selectedPaymentIndex: selectedPaymentIndex);
                          });
                },
                error: (error, st) {
                  debugPrintStack(stackTrace: st);
                  debugPrint(error.toString());
                  return ErrorWidget(error);
                },
                loading: () {
                  return  ListView.builder(
                      itemCount: 3,
                      shrinkWrap: true,
                      itemBuilder: (context, snapshot) {
                        return const ListItemShimmer();
                      }
                  );
                },
              ),
              SizedBox(
                height: 100.h,
              ),
              CustomButton(
                  onPressed: () {
                    if (selectedPayment != null) {
                      ref.read(invoiceDataProvider.notifier)
                          .setPaymentAccountData(paymentAcc: selectedPayment!);
                      showSnackBar(context, 'Payment account selected.');
                      Navigator.of(context).pop();
                    } else {
                      showSnackBar(context, 'Select Payment account');
                    }
                  },
                  buttonText: 'Save')
            ],
          ),
        ),
      ),
    );
  }
}
