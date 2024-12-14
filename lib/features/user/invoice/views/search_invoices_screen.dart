import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:invoice_producer/commons/common_imports/common_libs.dart';
import 'package:invoice_producer/commons/common_widgets/custom_text_fields.dart';
import 'package:invoice_producer/features/user/dashboard/widgets/invoice_card.dart';
import 'package:invoice_producer/features/user/invoice/controller/invoice_upload_controller.dart';
import 'package:invoice_producer/utils/constants/app_constants.dart';
import 'package:invoice_producer/utils/loading.dart';
import '../../../../commons/common_shimmers/list_item_shimmer.dart';
import '../../../../utils/constants/assets_manager.dart';

class SearchInvoicesScreen extends StatefulWidget {
  const SearchInvoicesScreen({Key? key}) : super(key: key);

  @override
  State<SearchInvoicesScreen> createState() => _SearchInvoicesScreenState();
}

class _SearchInvoicesScreenState extends State<SearchInvoicesScreen> {
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          'Search',
          style: getLibreBaskervilleBoldStyle(
              color: context.titleColor, fontSize: MyFonts.size16),
        ),
        centerTitle: true,
      ),
      body: Consumer(builder: (context, ref, child) {
        return Padding(
          padding: EdgeInsets.all(AppConstants.padding),
          child: Column(
            children: [
              CustomTextField(
                controller: searchController,
                hintText: 'Search',
                label: 'Search',
                onChanged: (v) {
                  setState(() {
                    ref.invalidate(
                        getAllSearchInvoicesProvider(searchController.text));
                  });
                },
              ),
              Expanded(
                child: ref
                    .watch(getAllSearchInvoicesProvider(searchController.text))
                    .when(
                        data: (invoices) {
                          return searchController.text.isEmpty
                              ? Text(
                                  'Search Invoices',
                                  style: getSemiBoldStyle(
                                      color: context.bodyTextColor),
                                )
                              : invoices.isEmpty
                                  ? Text('No invoice found',
                                      style: getSemiBoldStyle(
                                          color: context.bodyTextColor),
                                    )
                                  : ListView.builder(
                                      itemCount: invoices.length,
                                      itemBuilder: (context, index) {
                                        return InvoiceCard(
                                          invoice: invoices[index],
                                        );
                                      });
                        },
                        error: (error, s) => const SizedBox(),
                        loading: () => ListView.builder(
                            itemCount: 3,
                            shrinkWrap: true,
                            itemBuilder: (context, snapshot) {
                              return const ListItemShimmer();
                            })),
              )
            ],
          ),
        );
      }),
    );
  }
}
