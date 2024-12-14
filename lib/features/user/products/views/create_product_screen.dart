import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:invoice_producer/commons/common_functions/validator.dart';
import 'package:invoice_producer/commons/common_widgets/custom_text_fields.dart';
import 'package:invoice_producer/commons/common_widgets/custom_button.dart';
import 'package:invoice_producer/commons/common_widgets/image_picker_widget.dart';
import 'package:invoice_producer/core/enums/product_type.dart';
import 'package:invoice_producer/core/extensions/color_extension.dart';
import 'package:invoice_producer/features/user/products/controller/productController.dart';
import 'package:invoice_producer/features/user/products/widget/product_image_upload.dart';
import 'package:invoice_producer/models/product_model/item_model.dart';
import 'package:invoice_producer/models/tax_model/tax_model.dart';
import 'package:invoice_producer/utils/constants/app_constants.dart';
import 'package:invoice_producer/utils/themes/styles_manager.dart';
import '../../../../commons/common_widgets/common_dropdown.dart';
import '../../../../core/enums/currency_sign_enum.dart';
import '../../../../utils/constants/assets_manager.dart';
import '../../../../utils/constants/font_manager.dart';
import '../../dashboard/controller/dashboard_notifiar_ctr.dart';
import '../../profile/Profile_Extended/edit_profile/widget/edit_profile_image_upload.dart';
import '../../profile/Profile_Extended/payment_settings/widgets/select_currency_widgt.dart';
import '../../profile/Profile_Extended/tax_setting/controller/tax_controller.dart';
import '../widget/final_rate_card.dart';
import '../widget/product_type_widget.dart';
import 'package:uuid/uuid.dart';

class CreateProductScreen extends ConsumerStatefulWidget {
  final ItemModel? product;

  const CreateProductScreen({super.key, this.product});

  @override
  ConsumerState<CreateProductScreen> createState() =>
      _CreateCompanyScreenState();
}

class _CreateCompanyScreenState extends ConsumerState<CreateProductScreen> {
  final productNameController = TextEditingController();
  final zipCodeController = TextEditingController();
  final productDescController = TextEditingController();
  final stockQuantityController = TextEditingController();
  final productUnitController = TextEditingController();
  final productDiscount = TextEditingController();
  final productRateController = TextEditingController();
  final websiteController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  CurrencySignEnum? selectedCurrency;

  double? selectedTax;
  String? selectedTaxName;
  List<TaxModel> taxes = [];
  String? selectedProductAvailability;
  File? image;
  double? finalRate;
  var checkbox = false;
  ItemModel? oldProduct;
  String? imageUrl;
  ProductType selectedOption = ProductType.product;
  List<String> taxNames = [];
  List<String> productAvailabilityList = ['Low', 'Medium ', 'High'];

  @override
  void initState() {
    if (widget.product != null) {
      oldProduct = widget.product;
      productNameController.text = oldProduct!.name;
      productDescController.text = oldProduct!.description;
      stockQuantityController.text = oldProduct!.stockQuantity;
      productUnitController.text = oldProduct!.unit.toString();
      // productDiscount.text = oldProduct!.discountRate.toString();
      productRateController.text = oldProduct!.rate.toString();
      selectedTax = oldProduct?.tax != 0 ? oldProduct!.tax : null;
      selectedProductAvailability = oldProduct!.productAvailability != ''
          ? oldProduct!.productAvailability
          : null;
      imageUrl = oldProduct!.image != '' ? oldProduct!.image : null;
      checkbox = oldProduct!.availability;
      selectedCurrency = oldProduct!.currency;
      calculateTotal();
    } else {}
    getTexes();
    super.initState();
  }

  getTexes() async {
    taxes = await ref.read(taxControllerProvider.notifier).getAllTax().first;
    taxNames = taxes.map((tax) => tax.name).toList();
    setState(() {});
  }

  @override
  void dispose() {
    productNameController.dispose();
    zipCodeController.dispose();
    productDescController.dispose();
    stockQuantityController.dispose();
    productUnitController.dispose();
    productDiscount.dispose();
    productRateController.dispose();
    websiteController.dispose();
    super.dispose();
  }

  void selectImage() async {
    image = await pickImageFromGallery(context);
    setState(() {});
  }

  calculateTotal() {
    final finalRateVal = double.tryParse(productRateController.text) ?? 0;
    final totalTax = (finalRateVal * (selectedTax ?? 0)) / 100;
    finalRate = finalRateVal + totalTax; // - totalDiscount;
    setState(() {});
  }

  next() async {
    final map = Map<String, dynamic>();
    if (formKey.currentState!.validate()) {
      final ItemModel product = ItemModel(
          itemId: oldProduct != null ? oldProduct!.itemId : const Uuid().v4(),
          itemType: selectedOption,
          name: productNameController.text,
          description: productDescController.text,
          unit: double.tryParse(productUnitController.text.trim()) ?? 0,
          rate: double.tryParse(productRateController.text.trim()) ?? 0,
          //  discountRate: double.tryParse(productDiscount.text.trim()) ?? 0,
          tax: selectedTax ?? 0,
          finalRate: finalRate!,
          image: image?.path ?? '',
          stockQuantity: stockQuantityController.text,
          availability: checkbox,
          productAvailability: selectedProductAvailability ?? '',
          searchTag: map,
          currency: selectedCurrency ?? CurrencySignEnum.USD);
      if (oldProduct == null) {
        await ref
            .read(productControllerProvider.notifier)
            .addProduct(context, product);
      } else {
        await ref
            .read(productControllerProvider.notifier)
            .updateProducts(context, product, image?.path);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final dashBoardCtr = ref.watch(dashBoardNotifierCtr);
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          backgroundColor: context.scaffoldBackgroundColor,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Image.asset(AppAssets.backArrowIcon,
                width: 20.w, height: 20.h, color: context.titleColor),
          ),
          title: Text(
            'Create Products',
            style: getLibreBaskervilleExtraBoldStyle(
                color: context.titleColor, fontSize: MyFonts.size16),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              oldProduct == null || oldProduct?.image == ''
                  ? ProductImageUploadWidget(
                      onTap: selectImage,
                      image: image,
                    )
                  : EditProfileImageUploadWidget(
                      onTap: selectImage,
                      image: image,
                      imgUrl: oldProduct?.image ?? "",
                    ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: AppConstants.padding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 30.h,
                    ),
                    ProductTypeWidget(
                      selectedOption: selectedOption.mode,
                      selectionChanged: (value) {
                        setState(() {
                          selectedOption = value;
                        });
                      },
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Form(
                      key: formKey,
                      child: Column(
                        children: [
                          CustomTextField(
                            controller: productNameController,
                            hintText: '',
                            label: '${selectedOption.mode} name',
                            validatorFn: uNameValidator,
                          ),
                          CustomTextField(
                            controller: productDescController,
                            hintText: '',
                            label: '${selectedOption.mode} description',
                            // validatorFn: sectionValidator,
                            verticalPadding: 6.h,
                            maxLines: 6,
                          ),
                          if (selectedOption == ProductType.product)
                            CustomTextField(
                              controller: productUnitController,
                              hintText: '',
                              label: '${selectedOption.mode} unit',
                              inputType: TextInputType.number,
                              // validatorFn: sectionValidator,
                            ),
                          CustomTextField(
                            controller: productRateController,
                            hintText: '',
                            label: '${selectedOption.mode} rate',
                            inputType: TextInputType.number,
                            validatorFn: sectionValidator,
                            onChanged: (value) {
                              setState(() {
                                finalRate = double.parse(value);
                              });
                            },
                          ),
                          CommonDropDown(
                            valueItems: [
                              CurrencySignEnum.USD.name,
                              CurrencySignEnum.EUR.name,
                              CurrencySignEnum.GBP.name,
                              CurrencySignEnum.JPY.name,
                              CurrencySignEnum.BDT.name,
                              CurrencySignEnum.ZAR.name,
                              CurrencySignEnum.INR.name,
                            ],
                            value: getCurrencySign(selectedCurrency?.name ??
                                    dashBoardCtr.currencyTypeEnum!.name)
                                .name,
                            onChanged: (value) {
                              setState(() {
                                selectedCurrency = getCurrencySign(value);
                              });
                            },
                            hintText: 'Select Currency',
                            label: 'Currency',
                          ),
                          // CustomTextField(
                          //   controller: productDiscount,
                          //   hintText: '',
                          //   label: '${selectedOption.mode} discount',
                          //   inputType: TextInputType.number,
                          //   // validatorFn: sectionValidator,
                          // ),
                          CommonDropDown(
                            valueItems: taxNames,
                            onChanged: (String? newValue) {
                              final tax = taxes.firstWhere(
                                (tax) => tax.name == newValue,
                              );
                              selectedTax = tax.percentage;
                              calculateTotal();
                              // final finalRateVal = double.parse(productRateController.text);
                              // final discountVal = double.parse(productDiscount.text);
                              // final totalTax = (finalRateVal * selectedTax!) / 100;
                              // finalRate = finalRateVal + totalTax - discountVal;
                              setState(() {
                                selectedTaxName = newValue!;
                              });
                            },
                            value: selectedTaxName,
                            hintText: '',
                            label: '${selectedOption.mode} tax',
                          ),
                          if (selectedOption == ProductType.product)
                            CustomTextField(
                              controller: stockQuantityController,
                              hintText: '',
                              label: 'Stock Quantity',
                              inputType: TextInputType.number,
                              // validatorFn: sectionValidator,
                            ),
                          if (selectedOption == ProductType.product)
                            CommonDropDown(
                              valueItems: productAvailabilityList,
                              onChanged: (String? newValue) {
                                setState(() {
                                  selectedProductAvailability = newValue!;
                                });
                              },
                              value: selectedProductAvailability,
                              hintText: '',
                              label: '${selectedOption.mode} availability',
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 2.w,
                  ),
                  Checkbox(
                    value: checkbox,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6.r),
                    ),
                    fillColor: MaterialStateColor.resolveWith((states) =>
                        checkbox ? context.greenColor : context.whiteColor),
                    checkColor: context.whiteColor,
                    onChanged: (bool? value) {
                      setState(() {
                        checkbox = value!;
                      });
                    },
                  ),
                  Text('${selectedOption.mode} available',
                      style: getRegularStyle(
                          fontSize: MyFonts.size14, color: context.titleColor)),
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: AppConstants.padding),
                child: Column(
                  children: [
                    FinalRateCard(
                      amount: finalRate ?? 0,
                    ),
                    CustomButton(
                      isLoading: ref.watch(productControllerProvider),
                      onPressed: next,
                      buttonText: oldProduct == null
                          ? 'Save ${selectedOption.mode}'
                          : 'Update ${selectedOption.mode}',
                      buttonHeight: 45.h,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 50.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
