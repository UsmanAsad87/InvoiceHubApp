import 'dart:io';
import 'package:invoice_producer/commons/common_functions/padding.dart';
import 'package:invoice_producer/commons/common_functions/search_tags_handler.dart';
import 'package:invoice_producer/commons/common_imports/apis_commons.dart';
import 'package:invoice_producer/commons/common_widgets/common_dropdown.dart';
import 'package:invoice_producer/commons/common_widgets/custom_button.dart';
import 'package:invoice_producer/commons/common_widgets/custom_outline_button.dart';
import 'package:invoice_producer/commons/common_widgets/custom_text_fields.dart';
import 'package:invoice_producer/commons/common_widgets/image_picker_widget.dart';
import 'package:invoice_producer/commons/common_widgets/show_toast.dart';
import 'package:invoice_producer/features/user/dashboard/dashboard_extended/company/controller/comany_controller.dart';
import 'package:invoice_producer/features/user/invoice/controller/invoice_controller.dart';
import 'package:invoice_producer/features/user/invoice/controller/invoice_upload_controller.dart';
import 'package:invoice_producer/features/user/invoice/widgets/custom_arrow_button.dart';
import 'package:invoice_producer/features/user/invoice/widgets/item_list_widget.dart';
import 'package:invoice_producer/features/user/invoice/widgets/total_widget.dart';
import 'package:invoice_producer/models/company_models/company_model.dart';
import 'package:invoice_producer/routes/route_manager.dart';
import '../../../../commons/common_imports/common_libs.dart';
import '../../../../core/enums/currency_sign_enum.dart';
import '../../../../core/enums/invoice_status_enum.dart';
import '../../../../utils/constants/app_constants.dart';
import '../../../../utils/constants/assets_manager.dart';
import '../../../auth/widgets/company_image_upload.dart';
import '../../dashboard/controller/dashboard_notifiar_ctr.dart';
import '../../profile/Profile_Extended/edit_profile/widget/edit_profile_image_upload.dart';

class CreateInVoiceScreen extends ConsumerStatefulWidget {
  const CreateInVoiceScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<CreateInVoiceScreen> createState() =>
      _CreateInVoiceScreenState();
}

class _CreateInVoiceScreenState extends ConsumerState<CreateInVoiceScreen> {
  File? image;
  TextEditingController discountController = TextEditingController();
  TextEditingController depositController = TextEditingController();
  TextEditingController shippingCostController = TextEditingController();
  TextEditingController noteController = TextEditingController();
  // TextEditingController jobAddressController = TextEditingController();
  String? selectedCompanyName;
  CompanyModel? selectedCompany;
  List<CompanyModel>? yourCompanies;
  List<String>? companyNames;

  @override
  initState() {
    super.initState();
    initializeCompanies();
  }

  initializeCompanies() async {
    final invoiceInfo = ref.read(invoiceDataProvider.notifier);
    yourCompanies = await ref
        .read(companyControllerProvider.notifier)
        .getAllCompanies()
        .first;
    companyNames = yourCompanies?.map((company) => company.name).toList();
    final currency = ref.watch(dashBoardNotifierCtr).currencyTypeEnum;
    invoiceInfo.setCurrency(currency: currency ?? CurrencySignEnum.USD);
    setState(() {});
  }

  List<String> listofProdocts = [
    'product design',
    'shipping cost',
    'Quantity',
    'Discount',
    'tax',
    'Mix',
    'Total'
  ];

  List<String> totalText = [
    'subTotal',
    'Shipping cost',
    'Over all discount',
    'Tax',
    'mix',
    'Total'
  ];

  @override
  void dispose() {
    discountController.dispose();
    depositController.dispose();
    noteController.dispose();
    shippingCostController.dispose();
    InvoiceController invoiceController = InvoiceController();
    invoiceController.dispose();
    super.dispose();
  }

  void selectImage() async {
    image = await pickImageFromGallery(context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final dashBoardCtr = ref.watch(dashBoardNotifierCtr);
    final invoiceDataRef = ref.watch(invoiceDataProvider);
    return PopScope(
      onPopInvoked: (
        bool canPop,
      ) {
        invoiceDataRef.clear();
      },
      child: Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          appBar: AppBar(
            backgroundColor: context.scaffoldBackgroundColor,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
                invoiceDataRef.clear();
              },
              icon: Image.asset(AppAssets.backArrowIcon,
                  width: 20.w, height: 20.h, color: context.titleColor),
            ),
            title: Text(
              'Create Invoice',
              style: getLibreBaskervilleExtraBoldStyle(
                  color: context.titleColor, fontSize: MyFonts.size16),
            ),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    selectedCompany != null && selectedCompany!.logo != ''
                        ? EditProfileImageUploadWidget(
                            onTap: selectImage,
                            image: image,
                            imgUrl: selectedCompany!.logo,
                          )
                        : CompanyImageUploadWidget(
                            onTap: selectImage,
                            image: image,
                          ),
                    // CompanyImageUploadWidget(
                    //   onTap: selectImage,
                    //   image: image,
                    //   isFullColor: true,
                    // ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: AppConstants.padding),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 30.h,
                          ),
                          Text(
                            'Company information',
                            style: getSemiBoldStyle(
                                color: context.titleColor,
                                fontSize: MyFonts.size16),
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          CommonDropDown(
                              value: selectedCompanyName,
                              hintText: '',
                              label: 'Select company',
                              valueItems: companyNames ?? [],
                              onChanged: (value) {
                                setState(() {
                                  selectedCompanyName = value;
                                  selectedCompany = yourCompanies?.firstWhere(
                                    (company) =>
                                        company.name == selectedCompanyName,
                                  );
                                });
                                showSnackBar(context,
                                    '$selectedCompanyName is selected');
                              }
                              ),
                          CommonDropDown(
                            valueItems: [
                              CurrencySignEnum.USD.name,
                              CurrencySignEnum.EUR.name,
                              CurrencySignEnum.GBP.name,
                              CurrencySignEnum.JPY.name,
                              CurrencySignEnum.ZAR.name,
                              CurrencySignEnum.BDT.name,
                              CurrencySignEnum.INR.name,
                            ],
                            value: getCurrencySign(
                              invoiceDataRef.selectedCurrency?.name ??
                                  dashBoardCtr.currencyTypeEnum!.name,
                            ).name,
                            onChanged: (value) {
                              if (invoiceDataRef.productList?.isEmpty ??
                                  false) {
                                invoiceDataRef.setCurrency(
                                    currency: getCurrencySign(value));
                                invoiceDataRef.calculateTotal();
                              } else {
                                showToast(
                                    msg:
                                        'can\'t change currency after item selection');
                              }
                            },
                            hintText: 'Select Currency',
                            label: 'Currency',
                          ),
                          Consumer(
                            builder: (BuildContext context, WidgetRef ref,
                                Widget? child) {
                              return CustomArrowButton(
                                buttonName: invoiceDataRef.customerModel != null
                                    ? invoiceDataRef.customerModel!.name
                                    : 'Bill to',
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, AppRoutes.billToScreen);
                                },
                              );
                            },
                          ),
                          Consumer(
                            builder: (BuildContext context, WidgetRef ref,
                                Widget? child) {
                              return CustomArrowButton(
                                buttonName: 'Select address type',
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, AppRoutes.selectAddressScreen);
                                },
                              );
                            },
                          ),
                          CustomArrowButton(
                            buttonName: 'Invoice information',
                            onTap: () {
                              Navigator.pushNamed(
                                  context,
                                  AppRoutes.invoiceInfoScreen
                              );
                            },
                          ),
                          // CustomTextField(
                          //   controller: jobAddressController,
                          //   hintText: '',
                          //   label: 'Job Address',
                          //   fillColor: context.errorColor,
                          // ),
                          padding4,
                          ItemListWidget(
                            listofProdocts: listofProdocts,
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          CustomTextField(
                            controller: discountController,
                            hintText: '',
                            label: 'Discount',
                            inputType: TextInputType.number,
                            onChanged: (value) {
                              ref
                                  .read(invoiceDataProvider.notifier)
                                  .addDiscount(
                                      discount: double.parse(
                                          value.isEmpty ? '0.0' : value));
                            },
                          ),
                          CustomTextField(
                            controller: shippingCostController,
                            hintText: '',
                            label: 'Shipping Cost',
                            inputType: TextInputType.number,
                            verticalPadding: 8,
                            onChanged: (value) {
                              ref
                                  .read(invoiceDataProvider.notifier)
                                  .addShippingCost(
                                      shippingCost: double.parse(value));
                            },
                          ),
                          CustomTextField(
                            controller: depositController,
                            hintText: '',
                            label: 'Add deposit',
                            inputType: TextInputType.number,
                            verticalPadding: 8,
                            onChanged: (value) {
                              ref.read(invoiceDataProvider.notifier).addDeposit(
                                  newDeposit: double.parse(
                                      value.isEmpty ? '0.0' : value));
                            },
                          ),
                          CustomTextField(
                            controller: noteController,
                            hintText: '',
                            label: 'Note',
                            maxLines: 4,
                            verticalPadding: 8,
                          ),
                          CustomArrowButton(
                            buttonName: 'Signature',
                            onTap: () {
                              Navigator.pushNamed(
                                  context, AppRoutes.signaturesScreen);
                            },
                          ),
                          CustomArrowButton(
                            buttonName: 'Payment method',
                            onTap: () {
                              Navigator.pushNamed(
                                  context, AppRoutes.paymentMethodScreen);
                            },
                          ),
                          CustomArrowButton(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, AppRoutes.addWorkSamples);
                            },
                            buttonName: 'Add work sample',
                          ),
                          TotalWidget(
                            totalText: totalText,
                          ),
                          // CustomTextField(
                          //     controller: discountController,
                          //     hintText: '',
                          //     label: 'Payment discount'),
                          // CustomTextField(
                          //     controller: depositController,
                          //     hintText: '',
                          //     label: 'Add deposit'),
                          CustomButton(
                            isLoading:
                                ref.watch(invoiceUploadControllerProvider),
                            onPressed: saveButton,
                            buttonText: 'Save and continue',
                          ),
                          CustomOutlineButton(
                            isLoading:
                                ref.watch(invoiceUploadControllerProvider),
                            onPressed: draftButton,
                            buttonText: 'Save as draft',
                          )
                        ],
                      ),
                    ),
                  ]))),
    );
  }

  saveButton() {
    final invoiceRef = ref.read(invoiceDataProvider.notifier);
    final customer = invoiceRef.customerModel;
    final items = invoiceRef.productList;
    final signatures = invoiceRef.signatureModel;
    final payAccount = invoiceRef.paymentModel;
    final invoiceInfo = invoiceRef.invoiceModel;
    final subTotal = invoiceRef.subTotal;
    final total = invoiceRef.total;
    final dueAmount = invoiceRef.total - invoiceRef.dueAmount;
    final paidAmount = invoiceRef.paidAmount;
    final totalTax = invoiceRef.totalTax;
    final shippingCost = invoiceRef.shippingCost;

    if (invoiceInfo == null) {
      showSnackBar(context, 'Add invoice information.');
      return;
    }
    if (customer == null) {
      showSnackBar(context, 'Select customer.');
      return;
    }
    if (items == null) {
      showSnackBar(context, 'No item added.');
      return;
    }
    // if (payAccount == null) {
    //   showSnackBar(context, 'select payment account.');
    //   return;
    // }
    if (selectedCompany == null) {
      showSnackBar(context, 'select company.');
      return;
    }

    ref.read(invoiceUploadControllerProvider.notifier).addInvoice(
          context: context,
          invoice: invoiceInfo.copyWith(
            customer: customer,
            company: selectedCompany!,
            items: items,
            signature: signatures ?? null,
            paymentAccount: payAccount,
            discount: double.parse(discountController.text.isEmpty
                ? '0.0'
                : discountController.text),
            depositAmount: double.parse(depositController.text.isEmpty
                ? '0.0'
                : depositController.text),
            // double.parse(depositController.text.isEmpty ? '0.0': discountController.text),
            subTotal: subTotal,
            total: total,
            tax: totalTax,
            dueBalance: dueAmount,
            shippingCost: shippingCost,
            paid: paidAmount,
            isDraft: false,
            isPaid: false,
            currency: invoiceRef.selectedCurrency,
            notes: noteController.text,
            // jobAddress: jobAddressController.text,
            searchTags: invoiceSearchTagsHandler(
              fName: customer.name,
              companyName: selectedCompany?.name ?? '',
            ),
            addressType: invoiceRef.selectAddressType,
            addressLine1: invoiceRef.sameAsBilling
                ? customer.billingAddress1
                : invoiceRef.addressLine1Controller.text,
            addressLine2: invoiceRef.sameAsBilling
                ? customer.billingAddress2
                : invoiceRef.addressLine2Controller.text,
          ),
          workSamples: ref.watch(invoiceDataProvider.notifier).workSamples,
          logo: image,
        );
  }

  draftButton() {
    final invoiceRef = ref.read(invoiceDataProvider.notifier);
    final customer = invoiceRef.customerModel;
    final items = invoiceRef.productList;
    final signatures = invoiceRef.signatureModel;
    final payAccount = invoiceRef.paymentModel;
    final invoiceInfo = invoiceRef.invoiceModel;
    final subTotal = invoiceRef.subTotal;
    final total = invoiceRef.total;
    final dueAmount = invoiceRef.total - invoiceRef.dueAmount;
    final paidAmount = invoiceRef.paidAmount;
    final totalTax = invoiceRef.totalTax;
    final shippingCost = invoiceRef.shippingCost;

    if (invoiceInfo == null) {
      showSnackBar(context, 'Invoice information is must.');
      return;
    }

    ref.read(invoiceUploadControllerProvider.notifier).addInvoice(
        context: context,
        invoice: invoiceInfo.copyWith(
          customer: customer,
          company: selectedCompany,
          items: items,
          signature: signatures,
          paymentAccount: payAccount,
          subTotal: subTotal,
          total: total,
          tax: totalTax,
          dueBalance: dueAmount,
          shippingCost: shippingCost,
          paid: paidAmount,
          isDraft: true,
          notes: noteController.text,
          invoiceStatusEnum: InvoiceStatusEnum.draft,
          discount: double.parse(discountController.text.isEmpty
              ? '0.0'
              : discountController.text),
          depositAmount: double.tryParse(depositController.text),
          // double.parse(depositController.text.isEmpty ? '0.0': discountController.text),
          isPaid: false,
          searchTags: invoiceSearchTagsHandler(
              fName: customer?.name ?? '',
              companyName: selectedCompany?.name ?? ''),
          // jobAddress: jobAddressController.text,
          addressType: invoiceRef.selectAddressType,
          addressLine1: invoiceRef.sameAsBilling ? customer?.billingAddress1
              : invoiceRef.addressLine1Controller.text,
          addressLine2: invoiceRef.sameAsBilling ? customer?.billingAddress2
              : invoiceRef.addressLine2Controller.text,
        ),
        workSamples: ref.watch(invoiceDataProvider.notifier).workSamples,
        logo: image);
  }
}
