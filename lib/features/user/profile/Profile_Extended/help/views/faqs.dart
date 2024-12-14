import '../../../../../../commons/common_imports/apis_commons.dart';
import '../../../../../../commons/common_imports/common_libs.dart';
import '../../../../../../utils/constants/app_constants.dart';
import '../../../../../../utils/constants/assets_manager.dart';
import '../widgets/expand_tile_widget.dart';

class FAQsScreen extends ConsumerStatefulWidget {
  const FAQsScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<FAQsScreen> createState() => _FAQsScreenState();
}

class _FAQsScreenState extends ConsumerState<FAQsScreen> {

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: context.scaffoldBackgroundColor,
        leading: Consumer(builder: (context, ref, child) {
          return IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Image.asset(AppAssets.backArrowIcon,
                width: 20.w, height: 20.h, color: context.titleColor),
          );
        }),
        title: Text(
          'FAQ',
          style: getLibreBaskervilleBoldStyle(
              color: context.titleColor, fontSize: MyFonts.size16),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // SizedBox(height: 20.h,),
            Padding(
              padding: EdgeInsets.all(25.h),
              child:  Column(
                children: [
                  Text('Frequently asked questions', style: getBoldStyle(color: Colors.black,fontSize: MyFonts.size18),),
                  Padding(
                    padding:  EdgeInsets.symmetric(vertical: AppConstants.paddingVertical),
                    child: Image.asset(AppAssets.faqsImage,height: 200.h,),
                  ),
                  const ExpandTileWidget(title: "Is your app free to use?", desc:  "Clarify whether your app is free or if there are any pricing plans.",),
                  const ExpandTileWidget(title: "How do I create an invoice using your app?", desc:  "This is space for frequently asked question number 2.This is space for frequently asked question number 2.This is space for frequently asked question number 2.This is space for frequently asked question number 2.",),
                  const ExpandTileWidget(title: "Can I customize the look of my invoices?", desc:  "This is space for frequently asked question number 2.This is space for frequently asked question number 2.This is space for frequently asked question number 2.This is space for frequently asked question number 2.",),
                  const ExpandTileWidget(title: "Can I save and edit my invoices later?", desc:  "This is space for frequently asked question number 2.This is space for frequently asked question number 2.This is space for frequently asked question number 2.This is space for frequently asked question number 2.",),
                  const ExpandTileWidget(title: "Is my data safe and secure on your platform?", desc:  "This is space for frequently asked question number 2.This is space for frequently asked question number 2.This is space for frequently asked question number 2.This is space for frequently asked question number 2.",),
                  const ExpandTileWidget(title: "How do I handle taxes and discounts on invoices?", desc:  "This is space for frequently asked question number 2.This is space for frequently asked question number 2.This is space for frequently asked question number 2.This is space for frequently asked question number 2.",),

                  ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}
