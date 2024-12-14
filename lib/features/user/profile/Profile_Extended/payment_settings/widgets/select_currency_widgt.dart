import 'package:flutter/cupertino.dart';
import 'package:invoice_producer/commons/common_imports/common_libs.dart';

import '../../../../../../utils/constants/assets_manager.dart';

class SelectCurrencyWidget extends StatelessWidget {
  final List<String> itemValues;
  final String value;
  final Function(String?) onChanged;
  SelectCurrencyWidget({
    Key? key,
    required this.itemValues,
    required this.value,
    required this.onChanged
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 56.h,
        margin: EdgeInsets.only(bottom: 10.h,),
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        decoration: BoxDecoration(
            color: context.whiteColor,
            borderRadius : BorderRadius.circular(4.r),
            border: Border.all(color: context.containerColor, width: 1.w)),
      child:  Row(
        children: [
          Expanded(
            child: Text(
              'Default currency',
              style: getSemiBoldStyle(
                  fontSize: MyFonts.size16, color: context.titleColor),
            ),
          ),
          SizedBox(
            width: 70.w,
            child: DropdownButtonHideUnderline(
              child: DropdownButton(
                  isExpanded: true,
                  menuMaxHeight: 300.h,
                  dropdownColor: context.whiteColor,
                  borderRadius: BorderRadius.circular(20.r),
                  underline: const SizedBox(),
                  icon: ImageIcon(const AssetImage(AppAssets.arrowDownIcon),
                      size: 24.h, color: context.titleColor),
                  value: value,
                  focusColor: Colors.blue,
                  style:  getSemiBoldStyle(
                      fontSize: MyFonts.size16, color: context.titleColor),
                  onChanged: onChanged,
                  items:
                  itemValues.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                      ),
                    );
                  }).toList()),
            ),
          ),
        ],
      ));
  }
}
