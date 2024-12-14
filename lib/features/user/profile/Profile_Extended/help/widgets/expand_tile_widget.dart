
import 'package:invoice_producer/utils/constants/assets_manager.dart';

import '../../../../../../commons/common_imports/common_libs.dart';

class ExpandTileWidget extends StatefulWidget {
  const ExpandTileWidget({
    super.key,
    required this.title,
    required this.desc,
    this.initiallyExpanded,
  });
  final String title;
  final String desc;
  final bool? initiallyExpanded;

  @override
  State<ExpandTileWidget> createState() => _ExpandTileWidgetState();
}

class _ExpandTileWidgetState extends State<ExpandTileWidget> {
  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 0.0.h,vertical: 8.h),
      child: Container(
        // height:  56.h,
       // margin: EdgeInsets.only(bottom: 10.h,),
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
        decoration: BoxDecoration(
            color: context.whiteColor,
            borderRadius : BorderRadius.circular(4.r),
            border: Border.all(color: context.containerColor, width: 1.w)
                ),
        child: ListTileTheme(
          contentPadding: EdgeInsets.zero,

          dense: true,
          horizontalTitleGap: 0,
          minLeadingWidth: 0,
          minVerticalPadding: 0,
          child: ExpansionTile(
            onExpansionChanged: (val){
              setState(() {
                isExpanded=val;
              });
            },
            collapsedBackgroundColor: Colors.white,
            initiallyExpanded: widget.initiallyExpanded ?? isExpanded,
            maintainState: true,
            backgroundColor:context.scaffoldBackgroundColor,
            tilePadding: EdgeInsets.symmetric(horizontal: 8.h),
            iconColor: isExpanded?Colors.white:context.titleColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r),
            ),
            collapsedShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r),
            ),
            collapsedIconColor: context.titleColor,
            childrenPadding: const EdgeInsets.all(0),
            title: Text(
              widget.title,
              style: getSemiBoldStyle(
                  fontSize: MyFonts.size16, color: context.titleColor),
            ),
            trailing:
            Image.asset( isExpanded ?AppAssets.arrowDown2Icon:AppAssets.arrowUpIcon,width: 15.w,height: 15.h,
              color: context.titleColor.withOpacity(.6),),
            // Icon(
            //   isExpanded ? Icons.keyboard_arrow_up_sharp : Icons.keyboard_arrow_down_sharp,
            //   size: 33.h,
            //   color: context.titleColor.withOpacity(.6),
            // ),
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0.w),
                child: ListTile(
                  title: Text(
                    widget.desc,
                    style: getRegularStyle(
                        color: context.titleColor.withOpacity(.8), fontSize: MyFonts.size14),
                  ),
                ),
              ),
              SizedBox(height: 10.h,),
            ],
          ),
        ),
      ),
    );
  }
}
