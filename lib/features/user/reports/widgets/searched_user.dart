import 'package:invoice_producer/commons/common_imports/common_libs.dart';
import 'package:invoice_producer/features/user/reports/controller/client_report_controller.dart';
import 'package:invoice_producer/features/user/reports/controller/customer_controller.dart';
import '../../../../commons/common_imports/apis_commons.dart';
import '../../../../commons/common_widgets/cached_retangular_network_image.dart';
import '../../../../commons/common_widgets/custom_search_fields.dart';
import '../../../../models/customer_model/customer_model.dart';
import '../../../../models/invoice_model/invoice_model.dart';
import '../../../../utils/constants/app_constants.dart';
import '../../../../utils/constants/assets_manager.dart';
import '../../dashboard/dashboard_extended/customers/controller/customer_controller.dart';
import '../../invoice/controller/invoice_upload_controller.dart';

class SearchedUser extends StatelessWidget {
  // final Widget search;
  final TextEditingController searchController;

  const SearchedUser({Key? key, required this.searchController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Column(
        children: [
          Column(
            children: [
              CustomSearchField(
                controller: searchController,
                hintText: 'Search customer',
                verticalMargin: 0.h,
              ),
              Consumer(
                builder: (context, ref, child) {
                  return ref.watch(getAllCustomersProvider(context)).when(
                    data: (customerList) {
                      final filterList = customerList
                          .where((product) => product.name
                              .toLowerCase()
                              .contains(searchController.text.toLowerCase()))
                          .toList();
                      return filterList.isEmpty
                          ? const Center(
                              child: Text('No customer found'),
                            )
                          : SizedBox(
                              height: 50.h,
                              child: ListView(
                                shrinkWrap: true,
                                children: filterList.map((customer) {
                                  return DropdownMenuItem<CustomerModel>(
                                    value: customer,
                                    child: ListTile(
                                      title: Text(customer.name),
                                      onTap: () async {
                                        final customerNotifierProvider = ref
                                            .read(customerNotifierCtr.notifier);
                                        customerNotifierProvider
                                            .setCustomerModelData(customer);

                                        ref.read(clientReportCountsControllerProvider
                                                    .notifier)
                                            .getClientInvoices(
                                                customerId: customer.customerId,
                                                ref: ref,
                                                context: context);
                                      },
                                    ),
                                  );
                                }).toList(),
                              ),
                            );
                    },
                    error: (error, st) {
                      debugPrintStack(stackTrace: st);
                      debugPrint(error.toString());
                      return ErrorWidget(error);
                    },
                    loading: () {
                      return const Center(child: CircularProgressIndicator());
                    },
                  );
                },
              ),
            ],
          ),
          SizedBox(
            height: 8.h,
          ),
        ],
      ),
    );
  }
}
