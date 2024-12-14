import 'dart:io';
import 'package:invoice_producer/commons/common_functions/padding.dart';
import 'package:invoice_producer/commons/common_imports/apis_commons.dart';
import 'package:invoice_producer/commons/common_widgets/custom_button.dart';
import 'package:invoice_producer/commons/common_widgets/custom_outline_button.dart';
import 'package:invoice_producer/commons/common_widgets/custom_text_fields.dart';
import 'package:invoice_producer/commons/common_widgets/image_picker_widget.dart';
import 'package:invoice_producer/features/user/invoice/controller/invoice_upload_controller.dart';
import 'package:invoice_producer/features/user/invoice/widgets/custom_arrow_button.dart';
import 'package:invoice_producer/models/customer_model/customer_model.dart';
import 'package:invoice_producer/models/invoice_model/invoice_model.dart';
import 'package:invoice_producer/routes/route_manager.dart';
import '../../../../commons/common_imports/common_libs.dart';
import '../../../../commons/common_widgets/common_dropdown.dart';
import '../../../../commons/common_widgets/show_toast.dart';
import '../../../../core/enums/invoice_status_enum.dart';
import '../../../../models/company_models/company_model.dart';
import '../../../../utils/constants/app_constants.dart';
import '../../../../utils/constants/assets_manager.dart';
import '../../../auth/widgets/company_image_upload.dart';
import '../../dashboard/dashboard_extended/company/controller/comany_controller.dart';
import '../../profile/Profile_Extended/edit_profile/widget/edit_profile_image_upload.dart';
import '../controller/invoice_controller.dart';
import '../widgets/item_list_widget.dart';
import '../widgets/total_widget.dart';

class SingDraftleInvoiceScreen extends ConsumerStatefulWidget {
  final InVoiceModel invoice;

  const SingDraftleInvoiceScreen({Key? key, required this.invoice})
      : super(key: key);

  @override
  ConsumerState<SingDraftleInvoiceScreen> createState() =>
      _SingDraftleInvoiceScreenState();
}

class _SingDraftleInvoiceScreenState
    extends ConsumerState<SingDraftleInvoiceScreen> {
  File? image;
  TextEditingController discountController = TextEditingController();
  TextEditingController depositController = TextEditingController();
  TextEditingController noteController = TextEditingController();
  TextEditingController shippingCostController = TextEditingController();
  // TextEditingController jobAddressController = TextEditingController();
  CompanyModel? selectedCompany;
  CustomerModel? selectedCustomer;
  String? selectedCompanyName;
  List<CompanyModel>? yourCompanies;
  List<String>? companyNames;
  bool isUpdateLoading = false;

  late final InVoiceModel invoice;
  late final InvoiceController invoiceDataRef;

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
    'Discount',
    'Tax',
    'mix',
    'Total'
  ];

  @override
  void initState() {
    invoice = widget.invoice;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      invoiceDataRef = ref.watch(invoiceDataProvider);
      invoiceDataRef.setValues(inVoiceModel: invoice);
      discountController.text =
          invoice.discount != null ? invoice.discount.toString() : '';
      depositController.text = invoice.depositAmount.toString();
      noteController.text = invoice.termsAndCond;
      shippingCostController.text =
          invoice.shippingCost != null ? invoice.shippingCost.toString() : '';
      selectedCompany = invoice.company;
      selectedCustomer = invoice.customer;
      selectedCompanyName = selectedCompany?.name;
      // jobAddressController.text = invoice.jobAddress ?? '';
      initializeCompanies();
    });
    super.initState();
  }

  initializeCompanies() async {
    yourCompanies = await ref
        .read(companyControllerProvider.notifier)
        .getAllCompanies()
        .first;
    companyNames = yourCompanies?.map((company) => company.name).toList();
    setState(() {});
  }

  @override
  void dispose() {
    depositController.dispose();
    shippingCostController.dispose();
    discountController.dispose();
    // jobAddressController.dispose();
    super.dispose();
  }

  void selectImage() async {
    image = await pickImageFromGallery(context);
    setState(() {});
  }

  updateButton({bool? isPaid}) {
    final items = ref.read(invoiceDataProvider.notifier).productList;
    final signatures = ref.read(invoiceDataProvider.notifier).signatureModel;
    final payAccount = ref.read(invoiceDataProvider.notifier).paymentModel;

    InVoiceModel? invoiceInfo =
        ref.read(invoiceDataProvider.notifier).invoiceModel;

    if (invoiceInfo == null) {
      showSnackBar(context, 'Add invoice information.');
      return;
    }
    if (items == null) {
      showSnackBar(context, 'No item added.');
      return;
    }
    // if (signatures == null) {
    //   showSnackBar(
    //       context, 'No signature selected.');
    //   return;
    // }
    if (payAccount == null) {
      showSnackBar(context, 'select payment account.');
      return;
    }
    if (depositController.text.trim() == '') {
      showSnackBar(context, 'add deposit amount.');
      return;
    }
    ref.read(invoiceUploadControllerProvider.notifier).updateInvoice(
        context: context,
        inVoiceModel: invoiceInfo.copyWith(
          items: items,
          signature: signatures,
          paymentAccount: payAccount,
        ),
        logo: image);
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (
        bool canPop,
      ) {
        ref.read(invoiceDataProvider).clear();
      },
      child: Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          appBar: AppBar(
            backgroundColor: context.scaffoldBackgroundColor,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
                ref.read(invoiceDataProvider).clear();
              },
              icon: Image.asset(AppAssets.backArrowIcon,
                  width: 20.w, height: 20.h, color: context.titleColor),
            ),
            title: Text(
              'Draft Invoice',
              style: getLibreBaskervilleExtraBoldStyle(
                  color: context.titleColor, fontSize: MyFonts.size16),
            ),
            actions: [
              InkWell(
                onTap: () async {
                  final customerCtr =
                      ref.read(invoiceUploadControllerProvider.notifier);
                  await customerCtr.deleteInvoice(
                      context: context, invoiceId: invoice.invoiceNo!);
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: AppConstants.paddingHorizontal),
                  child: Image.asset(
                    AppAssets.deleteIcon,
                    scale: 3,
                  ),
                ),
              ),
            ],
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
                            onTap: () {},
                            image: image,
                          ),
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
                              }),
                          Consumer(
                            builder: (BuildContext context, WidgetRef ref,
                                Widget? child) {
                              final invoiceDataRef =
                                  ref.watch(invoiceDataProvider);
                              return CustomArrowButton(
                                buttonName:
                                    invoiceDataRef.invoiceModel?.customer !=
                                            null
                                        ? invoiceDataRef
                                            .invoiceModel!.customer!.name
                                        : 'Bill to',
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, AppRoutes.billToScreen);
                                },
                              );
                            },
                          ),
                          CustomArrowButton(
                            buttonName: 'Invoice information',
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                AppRoutes.invoiceInfoScreen,
                              );
                            },
                          ),
                          ItemListWidget(
                            listofProdocts: listofProdocts,
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          CustomTextField(
                            controller: discountController,
                            hintText: '',
                            label: 'overall discount',
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
                            label: 'shipping cost',
                            inputType: TextInputType.number,
                            verticalPadding: 8,
                            onChanged: (value) {
                              ref
                                  .read(invoiceDataProvider.notifier)
                                  .addShippingCost(
                                      shippingCost: double.parse(
                                          value.isEmpty ? '0.0' : value));
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
                                        value.isEmpty ? '0.0' : value),
                                  );
                            },
                          ),
                          CustomTextField(
                            controller: noteController,
                            hintText: '',
                            label: 'Note',
                            maxLines: 4,
                            verticalPadding: 8,
                          ),
                          TotalWidget(
                            totalText: totalText,
                          ),
                          // TotalWidget(totalText: totalText, totalValues: totalValues),
                          SizedBox(
                            height: 10.h,
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
                          padding12,
                          widget.invoice.isPaid != null &&
                                  widget.invoice.isPaid == true
                              ? const SizedBox()
                              : Column(
                                  children: [
                                    CustomButton(
                                      isLoading: ref.watch(
                                          invoiceUploadControllerProvider),
                                      onPressed: saveButton,
                                      buttonText: 'Save and continue',
                                    ),
                                    CustomOutlineButton(
                                      isLoading: ref.watch(
                                          invoiceUploadControllerProvider),
                                      onPressed: draftButton,
                                      buttonText: 'Save as draft',
                                    )
                                  ],
                                ),
                          padding30
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
    // if (signatures == null) {
    //   showSnackBar(context, 'No signature selected.');
    //   return;
    // }
    if (payAccount == null) {
      showSnackBar(context, 'select payment account.');
      return;
    }
    if (depositController.text.trim() == '') {
      showSnackBar(context, 'add deposit amount.');
      return;
    }

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
          signature: signatures,
          paymentAccount: payAccount,
          depositAmount: double.parse(
              depositController.text.isEmpty ? '0.0' : depositController.text),
          // discount: double.parse(discountController.text.isEmpty ? '0.0': discountController.text),
          subTotal: subTotal,
          total: total,
          tax: totalTax,
          dueBalance: dueAmount,
          shippingCost: shippingCost,
          paid: paidAmount,
          notes: noteController.text,
          isDraft: false,
          isPaid: false,
          // jobAddress: jobAddressController.text,
          addressType: invoiceRef.selectAddressType,
          addressLine1: invoiceRef.sameAsBilling ? customer.billingAddress1
              : invoiceRef.addressLine1Controller.text,
          addressLine2: invoiceRef.sameAsBilling ? customer.billingAddress2
              : invoiceRef.addressLine2Controller.text,
        ),
        workSamples: ref.watch(invoiceDataProvider.notifier).workSamples,
        logo: image);
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
          // depositAmount: double.parse(depositController.text.isEmpty ? '0.0': depositController.text),
          // discount: double.parse(discountController.text.isEmpty ? '0.0': discountController.text),
          subTotal: subTotal,
          total: total,
          tax: totalTax,
          dueBalance: dueAmount,
          shippingCost: shippingCost,
          paid: paidAmount,
          isDraft: true,
          invoiceStatusEnum: InvoiceStatusEnum.draft,
          notes: noteController.text,
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
