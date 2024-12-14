import 'package:invoice_producer/models/payment_account_model/payment_account_model.dart';

import '../../../../../../commons/common_imports/apis_commons.dart';
import '../../../../../../commons/common_imports/common_libs.dart';
import '../../../../../../routes/route_manager.dart';
import '../../../../profile/Profile_Extended/payment_settings/controller/payment_controller.dart';
import '../../../../profile/Profile_Extended/payment_settings/widgets/payment_account_card.dart';

class PaymentMethodContainer extends ConsumerWidget {
  final index;

  // final icon;
  PaymentAccountModel paymentAccount;
  Function(int) onChange;
  late final selectedPaymentIndex;

  PaymentMethodContainer(
      {Key? key,
      required this.index,
      required this.paymentAccount,
      // required this.icon,
      required this.onChange,
      required this.selectedPaymentIndex})
      : super(key: key);

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    return Container(
      width: double.infinity,
      height: 98.h,
      margin: EdgeInsets.only(bottom: 10.h),
      padding: EdgeInsets.all(8.h),
      decoration: BoxDecoration(
          color: context.whiteColor,
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(
              color: selectedPaymentIndex == index
                  ? context.greenColor
                  : context.containerColor,
              width: 1.w)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Radio(
                  value: index,
                  activeColor: context.greenColor,
                  groupValue: selectedPaymentIndex,
                  onChanged: (value) {
                    if (value != null) {
                      onChange(value);
                    }
                  }),
            ],
          ),
          Expanded(
            child: PaymentAccountCard(
              paymentAcc: paymentAccount,
              decoration: BoxDecoration(),
              onSelect: (value) {
                if (value == 'edit') {
                  Navigator.pushNamed(
                      context, AppRoutes.addPaymentAccountScreen, arguments: {
                    'paymentAccount': paymentAccount,
                    'skip': false
                  });
                } else {
                  ref
                      .read(paymentAccountControllerProvider.notifier)
                      .deletePaymentAccount(
                          context: context,
                          paymentId: paymentAccount.paymentId);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
