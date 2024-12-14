import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:invoice_producer/commons/common_imports/common_libs.dart';
import 'package:invoice_producer/core/enums/currency_sign_enum.dart';
import 'package:invoice_producer/features/user/invoice/widgets/sold_item_contaner.dart';
import 'package:invoice_producer/routes/route_manager.dart';
import '../../../../utils/constants/assets_manager.dart';
import '../controller/invoice_controller.dart';

class ItemListWidget extends StatefulWidget {
  final List<String> listofProdocts;

  const ItemListWidget({
    super.key,
    required this.listofProdocts,
  });

  @override
  State<ItemListWidget> createState() => _ItemListWidgetState();
}

class _ItemListWidgetState extends State<ItemListWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(
              width: 1.0, color: context.bodyTextColor.withOpacity(.3))),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Consumer(
              builder: (BuildContext context, WidgetRef ref, Widget? child) {
                final productList = ref.watch(invoiceDataProvider).productList;
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: productList?.length ?? 0,
                  itemBuilder: (context, index) {
                    return SoldItemContainer(
                      product: productList![index],
                      listofProdocts: widget.listofProdocts,
                      index: index,
                      // selectedCurrency: widget.currency,
                      onDeleteTap: () {
                        productList.removeAt(index);
                        setState(() {});
                      },
                      onEditTap: () {
                        Navigator.pushNamed(context, AppRoutes.addItemScreen,
                            arguments: {
                              'product': productList[index],
                              'isUpdate': true
                            });
                      },
                    );
                  },
                );
              },
            ),
            TextButton.icon(
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.itemsScreen);
                },
                icon: Icon(
                  Icons.add,
                  color: context.greenColor,
                  size: 35,
                ),
                label: Text(
                  'Add item',
                  style: getBoldStyle(
                      fontSize: MyFonts.size18, color: context.greenColor),
                ))
          ],
        ),
      ),
    );
  }
}
