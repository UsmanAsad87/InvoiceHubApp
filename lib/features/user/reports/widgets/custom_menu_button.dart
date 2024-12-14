import '../../../../commons/common_imports/common_libs.dart';
import '../../../../utils/constants/assets_manager.dart';


class CustomMenuButton extends StatelessWidget {
  String text;
  String? selectedReport;
  List<String> itemValues;

  CustomMenuButton({
    Key? key,
    required this.text,
    this.selectedReport,
    required this.itemValues,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          text,
          style: getBoldStyle(
              fontSize: MyFonts.size16, color: context.titleColor),
        ),
        SizedBox(
          width: 25.w,
          child: DropdownButton(
              isExpanded: true,
              menuMaxHeight: 300.h,
              dropdownColor: context.whiteColor,
              borderRadius: BorderRadius.circular(20.r),
              underline: const SizedBox(),
              icon: ImageIcon(const AssetImage(AppAssets.arrowDownIcon),
                  size: 24.h, color: context.titleColor),
              value: selectedReport,
              focusColor: Colors.blue,
              style:  getSemiBoldStyle(
                  fontSize: MyFonts.size16, color: context.titleColor),
              onChanged: (value){},
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
      ],
    );
  }
}
