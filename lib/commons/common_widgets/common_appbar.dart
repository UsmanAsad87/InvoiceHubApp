import 'package:invoice_producer/commons/common_imports/common_libs.dart';
import '../../utils/constants/assets_manager.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onPressed;
  final String title;
  final Color? appbarColor;

  const CustomAppBar({
    Key? key,
    required this.onPressed,
    required this.title,
    this.appbarColor,
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: context.scaffoldBackgroundColor,
      leading: IconButton(
        onPressed: onPressed,
        //     () {
        //   final mainMenuCtr = ref.watch(mainMenuProvider);
        //   mainMenuCtr.setIndex(0);
        // },
        icon: Image.asset(AppAssets.backArrowIcon,
            width: 20.w, height: 20.h, color: context.titleColor),
      ),
      title: Text(
        title,
        style: getLibreBaskervilleBoldStyle(
            color: context.titleColor, fontSize: MyFonts.size16),
      ),
      centerTitle: true,
    );
  }
}
