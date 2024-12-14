import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:invoice_producer/core/enums/currency_sign_enum.dart';

import '../../../../commons/common_functions/currency_converter.dart';
import '../../../../commons/common_imports/common_libs.dart';
import '../../../../models/product_model/item_model.dart';
import '../../../../utils/constants/assets_manager.dart';
import '../../dashboard/controller/dashboard_notifiar_ctr.dart';
import '../common_functions/calculate_single_product_total.dart';
import '../controller/invoice_controller.dart';

class SoldItemContainer extends ConsumerWidget {
  final ItemModel product;
  final List<String> listofProdocts;
  final int index;
  // final CurrencySignEnum selectedCurrency;
  final Function() onDeleteTap;
  final Function() onEditTap;

  const SoldItemContainer({
    Key? key,
    required this.product,
    required this.listofProdocts,
    required this.index,
    // required this.selectedCurrency,
    required this.onDeleteTap,
    required this.onEditTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final dashBoardCtr = ref.watch(dashBoardNotifierCtr);
    final invoiceCtr = ref.watch(invoiceDataProvider);
    final dashBoardCtr = ref.watch(dashBoardNotifierCtr);
    final currency = invoiceCtr.selectedCurrency?.type ??
        dashBoardCtr.currencyTypeEnum?.type ?? '\$';
    return ListView(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Item ${index + 1}',
                  style: getBoldStyle(
                      fontSize: MyFonts.size16, color: MyColors.black),
                ),
                Row(
                  children: [
                    InkWell(
                      onTap: onEditTap,
                      child: Image.asset(
                        AppAssets.editIcon,
                        scale: 4,
                        color: context.greenColor,
                      ),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    InkWell(
                      onTap: onDeleteTap,
                      child: Image.asset(
                        AppAssets.deleteIcon,
                        scale: 4,
                        color: MyColors.red,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 1.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Item type',
                  style: getBoldStyle(
                      fontSize: MyFonts.size14, color: context.titleColor),
                ),
                Text(
                  product.itemType.mode,
                  style: getBoldStyle(
                      fontSize: MyFonts.size14, color: context.titleColor),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 1.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${product.itemType.mode} Name',
                  style: getBoldStyle(
                      fontSize: MyFonts.size14, color: context.titleColor),
                ),
                Text(
                  product.name,
                  style: getBoldStyle(
                      fontSize: MyFonts.size14, color: context.titleColor),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 1.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  listofProdocts[2],
                  style: getBoldStyle(
                      fontSize: MyFonts.size14, color: context.titleColor),
                ),
                Text(
                  '${product.soldQuantity}',
                  style: getBoldStyle(
                      fontSize: MyFonts.size14, color: context.titleColor),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 1.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  listofProdocts[4],
                  style: getBoldStyle(
                      fontSize: MyFonts.size14, color: context.titleColor),
                ),
                Text(
                  '${product.tax}%',
                  style: getBoldStyle(
                      fontSize: MyFonts.size14, color: context.titleColor),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 1.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  listofProdocts[6],
                  style: getBoldStyle(
                    fontSize: MyFonts.size14,
                    color: context.titleColor,
                  ),
                ),
                Text(
                  // product.currency == selectedCurrency
                  //     ?
                  '$currency ${calculateSingleProductTotal(finalRate: product.finalRate, soldQuantity: product.soldQuantity!)}',
                  // : ref
                  //     .watch(
                  //         convertCurrencyProvider(CurrencyConversionParams(
                  //       fromCurrency: product.currency.name,
                  //       amount: product.finalRate,
                  //       toCurrency: selectedCurrency.name,
                  //     ).toString()))
                  //     .when(
                  //         data: (amount) =>
                  //             '${selectedCurrency.type} ${calculateSingleProductTotal(finalRate: amount, soldQuantity: product.soldQuantity!)}',
                  //         error: (e, s) => '',
                  //         loading: () => '###'),
                  // '${selectedCurrency} ${calculateSingleProductTotal(finalRate: product.finalRate, soldQuantity: product.soldQuantity!)}',
                  style: getBoldStyle(
                      fontSize: MyFonts.size14, color: context.titleColor),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Divider(
              height: 2,
              thickness: 1,
              color: MyColors.bluishTextColor.withOpacity(.3),
            ),
          ),
        ]);
  }
}
