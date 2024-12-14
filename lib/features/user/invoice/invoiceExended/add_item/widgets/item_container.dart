import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:invoice_producer/features/user/products/controller/productController.dart';

import '../../../../../../commons/common_imports/common_libs.dart';
import '../../../../../../models/product_model/item_model.dart';
import '../../../../../../routes/route_manager.dart';
import '../../../../products/widget/product_card.dart';

class ItemContainer extends ConsumerWidget {
  final int index;
  final ItemModel product;
  final Function(int) onChange;
  final int selectedProductIndex;
  const ItemContainer(
      {
    Key? key,required this.index,
        required this.product,
        required this.onChange,
        required this.selectedProductIndex

      }) : super(key: key);

  @override
  Widget build(
      BuildContext context,
      WidgetRef ref,
      ) {
    return Container(
      width: double.infinity,
     // height: 98.h,
      margin: EdgeInsets.only(bottom: 10.h),
      padding: EdgeInsets.all(8.h),
      decoration: BoxDecoration(
          color: context.whiteColor,
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(
              color: selectedProductIndex == index
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
                  groupValue: selectedProductIndex,
                  onChanged: (value) {
                    if (value != null) {
                      onChange(value);
                    }
                  }),
            ],
          ),
          Expanded(
            child: ProductCard(
              product: product,
            //  decoration: BoxDecoration(),
              onSelect: (value) {
                if (value == 'edit') {
                  Navigator.pushNamed(
                      context, AppRoutes.createProductScreen,
                      arguments: {'product': product});
                } else {
                  ref.read(productControllerProvider.notifier)
                      .deleteProduct(
                      context, product.itemId);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
