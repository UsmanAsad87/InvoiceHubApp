import 'package:invoice_producer/commons/common_imports/apis_commons.dart';
import 'package:invoice_producer/commons/common_imports/common_libs.dart';
import 'package:invoice_producer/commons/common_shimmers/list_item_shimmer.dart';
import 'package:invoice_producer/commons/common_widgets/custom_search_fields.dart';
import 'package:invoice_producer/features/user/products/controller/productController.dart';
import 'package:invoice_producer/features/user/products/widget/product_card.dart';
import 'package:invoice_producer/models/product_model/item_model.dart';
import 'package:invoice_producer/routes/route_manager.dart';
import 'package:invoice_producer/utils/constants/app_constants.dart';
import '../../../../commons/common_widgets/floatingActionButton.dart';
import '../../../../utils/constants/assets_manager.dart';
import '../../main_menu/controller/main_menu_controller.dart';
import '../../../../commons/common_widgets/common_heading_and_sorting_widget.dart';

class ProductsScreen extends ConsumerStatefulWidget {
  const ProductsScreen({super.key});

  @override
  ConsumerState<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends ConsumerState<ProductsScreen> {
  final searchController = TextEditingController();
  String _selectedSortOption = 'Product';
  final List<String> sortingOptions = [
    'Product',
    'Service',
    'Work',
    'Inspection'
  ];

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
            Navigator.pushNamed(context, AppRoutes.createProductScreen);
          },
        ),
        appBar: AppBar(
          backgroundColor: context.scaffoldBackgroundColor,
          leading: Consumer(builder: (context, ref, child) {
            return IconButton(
              onPressed: () {
                final mainMenuCtr = ref.watch(mainMenuProvider);
                mainMenuCtr.setIndex(0);
              },
              icon: Image.asset(AppAssets.backArrowIcon,
                  width: 20.w, height: 20.h, color: context.titleColor),
            );
          }),
          title: Text(
            'Products',
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
                  hintText: 'Search Product',
                  verticalMargin: 0.h,
                ),
                CommonHeadingAndSortingWidget(
                  sortingOptions: sortingOptions,
                  onSelected: (String result) {
                    setState(() {
                      _selectedSortOption = result;
                    });
                  },
                  title: 'Product list',
                ),
                Consumer(builder: (context, ref, child) {
                  return ref.watch(getAllProductsProvider(context)).when(
                    data: (productList) {
                      final filterList = productList
                          .where((product) => product.name
                              .toLowerCase()
                              .contains(searchController.text.toLowerCase()))
                          .toList();
                      return filterList.isEmpty
                          ? const Center(
                              child: Text('No product found'),
                            )
                          :  ListView.builder(
                              itemCount: filterList.length,
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                ItemModel product = filterList[index];
                                return  ProductCard(
                                        product: product,
                                        onSelect: (value) {
                                          if (value == 'edit') {
                                            Navigator.pushNamed(context,
                                                AppRoutes.createProductScreen,
                                                arguments: {
                                                  'product': product
                                                });
                                          } else {
                                            ref
                                                .read(productControllerProvider
                                                    .notifier)
                                                .deleteProduct(
                                                    context, product.itemId);
                                          }
                                        },
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
      ),
    );
  }
}
