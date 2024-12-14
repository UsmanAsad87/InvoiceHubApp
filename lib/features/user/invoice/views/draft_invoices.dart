import 'package:invoice_producer/commons/common_imports/common_libs.dart';
import 'package:invoice_producer/features/user/invoice/controller/invoice_upload_controller.dart';
import '../../../../commons/common_imports/apis_commons.dart';
import '../../../../commons/common_shimmers/list_item_shimmer.dart';
import '../../../../commons/common_widgets/custom_search_fields.dart';
import '../../../../models/invoice_model/invoice_model.dart';
import '../../dashboard/widgets/invoice_card.dart';
class DraftInvoices extends ConsumerStatefulWidget {
  const DraftInvoices({Key? key}) : super(key: key);

  @override
  ConsumerState<DraftInvoices> createState() => _DraftInvoicesState();
}

class _DraftInvoicesState extends ConsumerState<DraftInvoices> {

  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            CustomSearchField(
              controller: searchController,
              hintText: 'Search invoice',
              onChanged: (v) {
                setState(() {
                  ref.invalidate(getDraftInvoicesProvider(searchController.text));
                });
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                    'Invoice list',
                    style: getBoldStyle(
                        fontSize: MyFonts.size16,
                        color: context.titleColor)
                ),
                // IconButton(
                //     onPressed: (){},
                //     icon: const Icon(Icons.filter_list_rounded,size: 26,)),
              ],
            ),
            ref.watch(getDraftInvoicesProvider(searchController.text)).when(
              data: (invoiceList) {
                return invoiceList.isEmpty
                    ? const Center(child: Text('No invoice found'))
                    : ListView.builder(
                    itemCount: invoiceList.length,
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      InVoiceModel invoice = invoiceList[index];
                      return InvoiceCard(
                        invoice : invoice,
                        isDue:  invoice.isPaid?? false,
                        );
                    });
              },
              error: (error, st) {
                debugPrintStack(stackTrace: st);
                debugPrint(error.toString());
                return ErrorWidget(error);
              },
              loading: () {
                return  ListView.builder(
                    itemCount: 3,
                    shrinkWrap: true,
                    itemBuilder: (context, snapshot) {
                      return const ListItemShimmer();
                    }
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
