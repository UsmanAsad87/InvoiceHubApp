import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:invoice_producer/commons/common_imports/apis_commons.dart';
import 'package:invoice_producer/commons/common_imports/common_libs.dart';
import 'package:invoice_producer/commons/common_widgets/custom_search_fields.dart';
import 'package:invoice_producer/commons/common_widgets/show_toast.dart';
import 'package:invoice_producer/core/extensions/color_extension.dart';
import 'package:invoice_producer/features/user/invoice/invoiceExended/add_item/widgets/item_container.dart';
import 'package:invoice_producer/features/user/products/widget/product_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:invoice_producer/routes/route_manager.dart';
import 'package:invoice_producer/utils/constants/app_constants.dart';
import 'package:invoice_producer/utils/loading.dart';
import 'package:invoice_producer/utils/themes/styles_manager.dart';

import '../../../../../../../commons/common_widgets/common_heading_and_sorting_widget.dart';
import '../../../../../../../commons/common_widgets/floatingActionButton.dart';
import '../../../../../../../utils/constants/assets_manager.dart';
import '../../../../../../models/product_model/item_model.dart';
import '../../../../products/controller/productController.dart';

class ItemsScreen extends ConsumerStatefulWidget {
  const ItemsScreen({super.key});

  @override
  ConsumerState<ItemsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends ConsumerState<ItemsScreen> {
  final searchController = TextEditingController();
  String _selectedSortOption = 'Product';
  int selectedProductIndex = -1;
  ItemModel? selectedProduct;
  final List<String> sortingOptions = [
    'Product',
    'Service',
    'Work',
    'Inspection'
  ];

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
          Navigator.pushNamed(context, AppRoutes.createProductScreen);
          // if (selectedProduct != null) {
          //   Navigator.pushNamed(context, AppRoutes.addItemScreen,arguments: {'product' : selectedProduct});
          // }else{
          //   showSnackBar(context, 'Select product');
          // }
        },
      ),
      appBar: AppBar(
        backgroundColor: context.scaffoldBackgroundColor,
        leading: Consumer(builder: (context, ref, child) {
          return IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Image.asset(AppAssets.backArrowIcon,
                width: 20.w, height: 20.h, color: context.titleColor),
          );
        }),
        title: Text(
          'Add item',
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
                hintText: 'Search/Write Product Name',
                verticalMargin: 0.h,
              ),
              CommonHeadingAndSortingWidget(
                sortingOptions: sortingOptions,
                onSelected: (String result) {
                  setState(() {
                    _selectedSortOption = result;
                    // print('Selected sort option: $_selectedSortOption');
                  });
                },
                title: 'Product list',
              ),
              Consumer(builder: (context, ref, child) {
                return ref.watch(getAllProductsProvider(context)).when(
                  data: (productList) {
                    return productList.isEmpty
                        ? const Center(
                            child: Text('No product found'),
                          )
                        : ListView.builder(
                            itemCount: productList.length,
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              ItemModel product = productList[index];
                              return ItemContainer(
                                  index: index,
                                  product: product,
                                  onChange: (value) {
                                    setState(() {
                                      selectedProductIndex = value;
                                      selectedProduct = product;
                                    });
                                    if (selectedProduct != null) {
                                      Navigator.of(context).pop();
                                      Navigator.pushNamed(
                                          context, AppRoutes.addItemScreen,
                                          arguments: {
                                            'product': selectedProduct
                                          });
                                    } else {
                                      showSnackBar(context, 'Select product');
                                    }
                                  },
                                  selectedProductIndex: selectedProductIndex);
                            });
                  },
                  error: (error, st) {
                    debugPrintStack(stackTrace: st);
                    debugPrint(error.toString());
                    return ErrorWidget(error);
                  },
                  loading: () {
                    return const LoadingWidget();
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
