import '../../../../commons/common_imports/common_libs.dart';

class TotalItemRow extends StatelessWidget {
  final String text;
  final String value;

  const TotalItemRow({Key? key, required this.text, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: getBoldStyle(
                fontSize: MyFonts.size14,
                color: context.titleColor),
          ),
          Text(
            value,
            style: getBoldStyle(
                fontSize: MyFonts.size14,
                color: context.titleColor),
          ),
        ],
      ),
    );
  }
}
