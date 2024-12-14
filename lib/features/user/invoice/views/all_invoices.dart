import 'package:invoice_producer/commons/common_imports/common_libs.dart';
import 'package:invoice_producer/commons/common_widgets/custom_search_fields.dart';
import 'package:invoice_producer/features/user/dashboard/widgets/invoice_card.dart';
import 'package:invoice_producer/features/user/invoice/controller/invoice_upload_controller.dart';
import 'package:invoice_producer/utils/constants/app_constants.dart';
import '../../../../commons/common_imports/apis_commons.dart';
import '../../../../commons/common_shimmers/list_item_shimmer.dart';
import '../../../../utils/loading.dart';


class AllInvoices extends ConsumerStatefulWidget {
  const AllInvoices({Key? key}) : super(key: key);

  @override
  ConsumerState<AllInvoices> createState() => _AllInvoicesState();

}

class _AllInvoicesState extends ConsumerState<AllInvoices> {
  TextEditingController searchController = TextEditingController();

  List isPaid = [true,true,false,true];
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: EdgeInsets.all(AppConstants.padding),
        child: Column(
          children: [
            CustomSearchField(
              controller: searchController,
              hintText: 'Search invoice',
              onChanged: (v){
                setState(() {
                  ref.invalidate(getAllSearchInvoicesProvider(searchController.text));
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
                //     icon: const Icon(Icons.filter_list_rounded,size: 26,)
                // ),
              ],
            ),
            ref.watch(getAllSearchInvoicesProvider(searchController.text)).when(
              data: (invoiceList) {
                return invoiceList.isEmpty
                    ? const Center(child: Text('No invoice found'))
                    : ListView.builder(
                    itemCount: invoiceList.length,
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final invoice = invoiceList[index];
                      return InvoiceCard(
                        invoice : invoice,
                        isDue: invoice.isPaid ?? false,);
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
