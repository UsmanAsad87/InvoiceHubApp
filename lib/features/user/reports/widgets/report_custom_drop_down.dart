import 'package:invoice_producer/commons/common_imports/common_libs.dart';

import '../../../../utils/constants/assets_manager.dart';

class ReportCustomDropDown extends StatelessWidget {
  String? selectedValue;
  List<String> itemValues;
  void Function(String?) onChanged;

  ReportCustomDropDown({
    Key? key,
    this.selectedValue,
    required this.itemValues,
    required this.onChanged
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  DropdownButtonHideUnderline(
      child: DropdownButton(
          isExpanded: false,
          menuMaxHeight: 300.h,
          dropdownColor: context.whiteColor,
          borderRadius: BorderRadius.circular(20.r),
          underline: const SizedBox(),
          icon: ImageIcon(const AssetImage(AppAssets.arrowDownIcon),
              size: 24.h, color: context.titleColor),
          value: selectedValue,
          focusColor: Colors.blue,
          style:  getSemiBoldStyle(
              fontSize: MyFonts.size16, color: context.titleColor),
          onChanged: onChanged,
          items: itemValues.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value,
              ),
            );
          }).toList()),
    );
  }
}
