import 'package:invoice_producer/commons/common_imports/apis_commons.dart';
import 'package:invoice_producer/features/user/invoice/views/all_invoices.dart';
import 'package:invoice_producer/features/user/invoice/views/draft_invoices.dart';

import '../../../../commons/common_imports/common_libs.dart';
import '../../../../commons/common_widgets/floatingActionButton.dart';
import '../../../../routes/route_manager.dart';
import '../../main_menu/controller/main_menu_controller.dart';

class InvoicesScreen extends ConsumerStatefulWidget {
  const InvoicesScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<InvoicesScreen> createState() => _InvoicesScreenState();
}

class _InvoicesScreenState extends ConsumerState<InvoicesScreen>  with SingleTickerProviderStateMixin {

  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this,);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final mainMenuCtr = ref.watch(mainMenuProvider);
        mainMenuCtr.setIndex(0);
        return false;
      },
      child: Scaffold(
        backgroundColor: context.scaffoldBackgroundColor,
        floatingActionButton: CustomFloatingActionButton(
          onTap: () {
            Navigator.pushNamed(context, AppRoutes.createInvoiceScreen);
          },
        ),
        appBar: AppBar(
          backgroundColor: context.scaffoldBackgroundColor,
          automaticallyImplyLeading: false,
          title: Text(
            'Invoices',
            style: getLibreBaskervilleBoldStyle(
                color: context.titleColor, fontSize: MyFonts.size16),
          ),
          centerTitle: true,
          bottom:  TabBar(
            indicatorColor: context.greenColor.withOpacity(.6),
            indicatorSize: TabBarIndicatorSize.tab,
            controller: _tabController,
            labelColor: context.greenColor,
            unselectedLabelColor: context.titleColor,
            tabs:  const [
              Tab(
                text: 'All invoices',
              ),
              Tab(text: 'Draft invoice'),
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children:  const [
            AllInvoices(),
            DraftInvoices()
          ],
        ),
      ),
    );
  }
}
