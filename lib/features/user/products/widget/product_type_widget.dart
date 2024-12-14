
import 'package:invoice_producer/commons/common_functions/padding.dart';
import 'package:invoice_producer/core/enums/product_type.dart';

import '../../../../commons/common_imports/common_libs.dart';

class ProductTypeWidget extends StatelessWidget {
  const ProductTypeWidget({
    super.key,
    required this.selectedOption,
    required this.selectionChanged,
  });

  final String selectedOption;
  final Function(ProductType) selectionChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Please Select',
          style: getSemiBoldStyle(
              color: context.titleColor, fontSize: MyFonts.size16),
        ),
        padding12,
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 20.h,
              width: 20.w,
              child: Radio(
                activeColor: context.greenColor,
                fillColor: MaterialStateProperty.all(context.greenColor),
                value: 'Product',
                groupValue: selectedOption,
                onChanged: (value) {
                  if (value != null) {
                    selectionChanged(ProductType.product);
                  }
                },
              ),
            ),
            padding8,
            Text(
              'Product',
              style: getSemiBoldStyle(
                  color: selectedOption=='Product'?context.greenColor:context.titleColor, fontSize: MyFonts.size14),
            ),
          ],
        ),
        padding4,
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 20.h,
              width: 20.w,
              child: Radio(
                activeColor: context.greenColor,
                fillColor: MaterialStateProperty.all(context.greenColor),
                value: 'Service',
                groupValue: selectedOption,
                onChanged: (value) {
                  if (value != null) {
                    selectionChanged(ProductType.service);
                  }
                },
              ),
            ),
            padding8,
            Text(
              'Service',
              style: getSemiBoldStyle(
                  color: selectedOption=='Service'?context.greenColor:context.titleColor, fontSize: MyFonts.size14),
            ),
          ],
        ),
        padding4,
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 20.h,
              width: 20.w,
              child: Radio(
                activeColor: context.greenColor,
                fillColor: MaterialStateProperty.all(context.greenColor),
                value: 'Work',
                groupValue: selectedOption,
                onChanged: (value) {
                  if (value != null) {
                    selectionChanged(ProductType.work);
                  }
                },
              ),
            ),
            padding8,
            Text(
              'Work',
              style: getSemiBoldStyle(
                  color: selectedOption== 'Work'?context.greenColor:context.titleColor, fontSize: MyFonts.size14),
            ),
          ],
        ),
        padding4,
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 20.h,
              width: 20.w,
              child: Radio(
                activeColor: context.greenColor,
                fillColor: MaterialStateProperty.all(context.greenColor),
                value: 'Inspection',
                groupValue: selectedOption,
                onChanged: (value) {
                  if (value != null) {
                    selectionChanged(ProductType.inspection);
                  }
                },
              ),
            ),
            padding8,
            Text(
              'Inspection',
              style: getSemiBoldStyle(
                  color: selectedOption== 'Inspection'?context.greenColor:context.titleColor, fontSize: MyFonts.size14),
            ),
          ],
        ),
        padding12,
      ],
    );
  }
}