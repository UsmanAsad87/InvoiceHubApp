import '../../../../../../commons/common_imports/common_libs.dart';
import '../../../../../../utils/constants/assets_manager.dart';

class DownloadOptionButton extends StatelessWidget {
  Icon icon;
  String? selectedOption;
  List<Icon> itemIcons;
  List<String> itemValues;
  Function(String val) onSelect;

  DownloadOptionButton({
    Key? key,
    required this.icon,
    this.selectedOption,
    required this.itemIcons,
    required this.itemValues,
    required this.onSelect,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
        surfaceTintColor: context.whiteColor,
        icon: icon,
        onSelected: onSelect,
        itemBuilder: (BuildContext context) {
          return List.generate(itemValues.length, (index) {
            return PopupMenuItem<String>(
              value: itemValues[index],
              child: Row(
                children: [
                  itemIcons[index],
                  SizedBox(width: 8.w),
                  Text(itemValues[index]),
                ],
              ),
            );
          });
        });
  }
}