import 'package:invoice_producer/core/enums/currency_sign_enum.dart';
import 'package:invoice_producer/features/user/invoice/widgets/total_item_row.dart';
import '../../../../commons/common_imports/apis_commons.dart';
import '../../../../commons/common_imports/common_libs.dart';
import '../../dashboard/controller/dashboard_notifiar_ctr.dart';
import '../controller/invoice_controller.dart';

class TotalWidget extends ConsumerWidget {
  final List<String> totalText;

  // final CurrencySignEnum selectedCurrency;

  const TotalWidget({
    Key? key,
    required this.totalText,
    // required this.selectedCurrency,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final invoiceCtr = ref.watch(invoiceDataProvider);
    final dashBoardCtr = ref.watch(dashBoardNotifierCtr);
    final currency = invoiceCtr.selectedCurrency?.type ??
        dashBoardCtr.currencyTypeEnum?.type ?? '\$';
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(
              width: 1.0, color: context.bodyTextColor.withOpacity(.3))),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total bill',
                    style: getBoldStyle(
                        fontSize: MyFonts.size16, color: context.titleColor),
                  ),
                ],
              ),
            ),
            Consumer(
              builder: (BuildContext context, WidgetRef ref, Widget? child) {
                final invoice = ref.watch(invoiceDataProvider);
                return ListView(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  children: [
                    TotalItemRow(
                      text: totalText[0],
                      value: '$currency${invoice
                          .subTotal}',
                      // '${dashBoardCtr.currencyTypeEnum?.type}${invoice.subTotal}',
                    ),
                    TotalItemRow(
                      text: totalText[1],
                      value: '$currency${invoice.shippingCost}',
                      // '${dashBoardCtr.currencyTypeEnum?.type}${invoice.shippingCost}',
                    ),
                    TotalItemRow(
                      text: totalText[2],
                      value: '${invoice.discount}%',
                    ),
                    TotalItemRow(
                        text: totalText[5],
                        value:
                        '$currency${invoice.total}'
                      // '${(invoice.invoiceModel?.subTotal ?? 0) + (invoice.invoiceModel?.shippingCost ?? 0)}',
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Divider(
                        height: 2,
                        thickness: 1,
                        color: MyColors.bluishTextColor.withOpacity(.3),
                      ),
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Paid',
                            style: getBoldStyle(
                                fontSize: MyFonts.size16,
                                color: context.titleColor),
                          ),
                          Text(
                            '$currency${invoice.paidAmount}',
                            style: getBoldStyle(
                                fontSize: MyFonts.size16,
                                color: context.titleColor),
                          ),
                        ]),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Balance due',
                            style: getBoldStyle(
                                fontSize: MyFonts.size16,
                                color: context.titleColor),
                          ),

                          /// TODO : Check Calculations
                          Consumer(
                            builder: (BuildContext context, WidgetRef ref,
                                Widget? child) {
                              return Text(
                                '$currency'
                                    '${invoice.total - invoice.paidAmount}',
                                style: getBoldStyle(
                                    fontSize: MyFonts.size16,
                                    color: context.titleColor),
                              );
                            },
                          ),
                        ]),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
