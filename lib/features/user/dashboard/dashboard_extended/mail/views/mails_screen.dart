import 'package:invoice_producer/commons/common_imports/common_libs.dart';
import 'package:invoice_producer/features/user/dashboard/dashboard_extended/mail/widgets/mail_card.dart';
import '../../../../../../commons/common_imports/apis_commons.dart';
import '../../../../../../commons/common_widgets/custom_search_fields.dart';
import '../../../../../../commons/common_widgets/floatingActionButton.dart';
import '../../../../../../routes/route_manager.dart';
import '../../../../../../utils/constants/app_constants.dart';
import '../../../../../../utils/constants/assets_manager.dart';

class MailsScreen extends ConsumerStatefulWidget {
  const MailsScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<MailsScreen> createState() => _MailsScreenState();
}

class _MailsScreenState extends ConsumerState<MailsScreen> {
  TextEditingController searchController = TextEditingController();

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: context.scaffoldBackgroundColor,
        floatingActionButton: CustomFloatingActionButton(
          onTap: () {
            Navigator.pushNamed(context, AppRoutes.createMailScreen);
          },
        ),
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
            'Mail',
            style: getLibreBaskervilleBoldStyle(
                color: context.titleColor, fontSize: MyFonts.size16),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
                padding: EdgeInsets.all(AppConstants.padding),
                child: Column(children: [
                  CustomSearchField(
                    controller: searchController,
                    hintText: 'Search messages',
                    verticalMargin: 0.h,
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  ListView.builder(
                      itemCount: 4,
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return MailCard(imageUrl: index%2==0?personImg:null,);
                      }),
                ]))));
  }
}
