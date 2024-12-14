import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:invoice_producer/commons/common_widgets/custom_button.dart';
import 'package:invoice_producer/commons/common_widgets/custom_text_fields.dart';
import 'package:invoice_producer/features/user/invoice/widgets/custom_arrow_button.dart';
import 'package:invoice_producer/routes/route_manager.dart';
import 'package:invoice_producer/utils/constants/app_constants.dart';
import '../../../../../../commons/common_imports/common_libs.dart';
import '../../../../../../commons/common_widgets/floatingActionButton.dart';
import '../../../../../../utils/constants/assets_manager.dart';
import '../widgets/expand_tile_widget.dart';

class HelpScreen extends ConsumerStatefulWidget {
  const HelpScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<HelpScreen> createState() => _CreateTaxScreenState();
}

class _CreateTaxScreenState extends ConsumerState<HelpScreen> {
  TextEditingController taxNameController = TextEditingController();
  TextEditingController taxAmountController = TextEditingController();

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
          'Helps',
          style: getLibreBaskervilleBoldStyle(
              color: context.titleColor, fontSize: MyFonts.size16),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: EdgeInsets.all(AppConstants.padding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Follow our Youtube videos',
              style:
                  getBoldStyle(color: Colors.black, fontSize: MyFonts.size18),
            ),
            Padding(
              padding:
                  EdgeInsets.symmetric(vertical: AppConstants.paddingVertical),
              child: Image.asset(
                AppAssets.helpImg,
                height: 200.h,
              ),
            ),
            CustomArrowButton(
                onTap: () {
                  Navigator.pushNamed(context, AppRoutes.faqsScreen);
                },
                buttonName: 'FAQ'),
            const ExpandTileWidget(
              title: "Help for login",
              desc:
                  "Clarify whether your app is free or if there are any pricing plans.",
            ),
            const ExpandTileWidget(
              title: "Help for register",
              desc:
                  "This is space for frequently asked question number 2.This is space for frequently asked question number 2.This is space for frequently asked question number 2.This is space for frequently asked question number 2.",
            ),
          ],
        ),
      )),
    );
  }
}
