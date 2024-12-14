import '../../../../commons/common_imports/apis_commons.dart';
import '../../../../commons/common_imports/common_libs.dart';
import '../../../../commons/common_shimmers/list_item_shimmer.dart';
import '../../../../commons/common_widgets/common_appbar.dart';
import '../../../../models/invoice_model/invoice_model.dart';
import '../../../../utils/constants/app_constants.dart';
import '../../invoice/controller/invoice_upload_controller.dart';
import '../../main_menu/controller/main_menu_controller.dart';
import '../widgets/invoice_card.dart';

class RecentInvoicesSeeMoreScreen extends ConsumerWidget {
  const RecentInvoicesSeeMoreScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: CustomAppBar(
        title: 'Recent Invoices',
        onPressed: () {
          final mainMenuCtr = ref.watch(mainMenuProvider);
          mainMenuCtr.setIndex(0);
          Navigator.pop(context);
        },
      ),
      body: Padding(
        padding: EdgeInsets.all(AppConstants.padding),
        child: Consumer(builder: (context, ref, child) {
          return ref.watch(getAllInvoicesProvider).when(
            data: (invoiceList) {
              return invoiceList.isEmpty
                  ? Center(
                      child: Text(
                        'No invoice found',
                        style: getMediumStyle(
                          color: context.titleColor,
                          fontSize: MyFonts.size15,
                        ),
                      ),
                    ) : ListView.builder(
                      itemCount: invoiceList.length,
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        InVoiceModel invoice = invoiceList[index];
                        return InvoiceCard(
                          isDue: invoice.isPaid ?? false,
                          invoice: invoice,
                        );
                      });
            },
            error: (error, st) {
              debugPrintStack(stackTrace: st);
              debugPrint(error.toString());
              return ErrorWidget(error);
            },
            loading: () {
              return ListView.builder(
                  itemCount: 3,
                  shrinkWrap: true,
                  itemBuilder: (context, snapshot) {
                    return const ListItemShimmer();
                  });
            },
          );
        }),
      ),
    );
  }
}
