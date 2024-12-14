import '../../../../../../commons/common_functions/padding.dart';
import '../../../../../../commons/common_imports/common_libs.dart';
import '../../../../../../utils/constants/app_constants.dart';

class CustomContainer extends StatelessWidget {
  final title;
  final description;
  Color? color;
  Color? textColor;

   CustomContainer(
      {Key? key,
        required this.title,
        required this.description,
        this.color,
        this.textColor
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppConstants.padding),
      margin: EdgeInsets.all(AppConstants.padding),
      width: double.infinity,
      decoration: BoxDecoration(
          color: color ?? context.whiteColor,
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(width: .5, color: context.containerColor)),
      child: Column(
        children: [
          Text(
            title,
            style: getBoldStyle(
                color: textColor ?? context.titleColor, fontSize: MyFonts.size24),
          ),
          padding18,
          Text(
            description,
            style: getRegularStyle(
                color: textColor ?? context.titleColor.withOpacity(.5),
                fontSize: MyFonts.size14),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
