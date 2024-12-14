import 'package:invoice_producer/commons/common_imports/apis_commons.dart';
import 'package:invoice_producer/commons/common_imports/common_libs.dart';
import 'package:invoice_producer/commons/common_widgets/common_heading_and_sorting_widget.dart';
import 'package:invoice_producer/commons/common_widgets/custom_search_fields.dart';
import 'package:invoice_producer/routes/route_manager.dart';
import 'package:invoice_producer/utils/constants/app_constants.dart';
import '../../../../../../commons/common_shimmers/list_item_shimmer.dart';
import '../../../../../../commons/common_widgets/floatingActionButton.dart';
import '../../../../../../models/customer_model/customer_model.dart';
import '../../../../../../utils/constants/assets_manager.dart';
import '../../../../../../utils/loading.dart';
import '../../../../main_menu/controller/main_menu_controller.dart';
import '../controller/customer_controller.dart';
import '../widget/customer_card.dart';

class CustomersScreen extends ConsumerStatefulWidget {
  const CustomersScreen({super.key});

  @override
  ConsumerState<CustomersScreen> createState() => _CustomersScreenState();
}

class _CustomersScreenState extends ConsumerState<CustomersScreen> {
  final searchController = TextEditingController();
  String _selectedSortOption = 'Name';
  final List<String> sortingOptions = ['Name', 'City', 'Age', 'Price'];

  @override
  void initState() {
    searchController.addListener(() {
      setState(() {});
    });
    super.initState();
  }
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
          Navigator.pushNamed(context, AppRoutes.createCustomerScreen);
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
          'Customers',
          style: getLibreBaskervilleBoldStyle(
              color: context.titleColor, fontSize: MyFonts.size16),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.all(AppConstants.padding),
          child: Column(
            children: [
              CustomSearchField(
                controller: searchController,
                hintText: 'Search customers',
                verticalMargin: 0.h,
              ),
              CommonHeadingAndSortingWidget(
                sortingOptions: sortingOptions,
                onSelected: (String result) {
                  setState(() {
                    _selectedSortOption = result;
                  });
                },
                title: 'Customers list',
              ),
              Consumer(builder: (context, ref, child) {
                return ref.watch(getAllCustomersProvider(context)).when(
                  data: (customersList) {
                    final filterList =  customersList.where((product) =>
                        product.name
                            .toLowerCase()
                            .contains(searchController.text.toLowerCase())).toList();
                    return filterList.isEmpty
                        ? const Center(
                            child: Text('No customer found'),
                          )
                        : ListView.builder(
                            itemCount: filterList.length,
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              final customer = filterList[index];
                              return Container(
                                color: context.scaffoldBackgroundColor,
                                child: InkWell(
                                    splashColor: Colors.transparent,
                                    onTap: () {
                                      Navigator.pushNamed(context,
                                          AppRoutes.customerDetailScreen,
                                          arguments: {'customer': customer});
                                    },
                                    child: CustomerCard(
                                      customer: customer,
                                      onSelected: (value) async {
                                        if (value == 'edit') {
                                          Navigator.pushNamed(context,
                                              AppRoutes.createCustomerScreen,
                                              arguments: {
                                                'customer': customer
                                              });
                                        } else {
                                          final customerCtr = ref.read(
                                              customerControllerProvider
                                                  .notifier);
                                          await customerCtr.deleteCustomer(
                                              context: context,customerId: customer.customerId);
                                        }
                                      },
                                    )),
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
                        }
                    );
                  },
                );
              }),
              SizedBox(
                height: 100.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
