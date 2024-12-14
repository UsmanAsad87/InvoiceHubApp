import '../common_imports/common_libs.dart';
import '../../utils/constants/assets_manager.dart';

class CommonHeadingAndSortingWidget extends StatelessWidget {
  const CommonHeadingAndSortingWidget({
    super.key,
    required this.sortingOptions,
    required this.onSelected,
    required this.title,
  });

  final List<String> sortingOptions;
  final Function(String) onSelected;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title,
            style: getSemiBoldStyle(
                color: context.titleColor, fontSize: MyFonts.size16)),
        PopupMenuButton<String>(
          onSelected: onSelected,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.r),
          ),
          elevation: 2,
          itemBuilder: (BuildContext context) =>
              sortingOptions.map((String option) {
            return PopupMenuItem<String>(
              height: 30.h,
              padding: EdgeInsets.only(left: 15.w, right: 30.w),
              value: option,
              child: Text(
                option,
                style: getMediumStyle(
                    color: context.titleColor, fontSize: MyFonts.size14),
              ),
            );
          }).toList(),
          child: Container(
            color: context.scaffoldBackgroundColor,
            padding: EdgeInsets.symmetric(horizontal: 0.w, vertical: 14.h),
            child: Image.asset(AppAssets.sortIcon,
                width: 24.w, height: 24.h, color: context.titleColor),
          ),
        ),
      ],
    );
  }
}
