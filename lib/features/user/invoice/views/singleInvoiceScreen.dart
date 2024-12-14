import 'dart:io';
import 'package:invoice_producer/commons/common_functions/padding.dart';
import 'package:invoice_producer/commons/common_imports/apis_commons.dart';
import 'package:invoice_producer/commons/common_widgets/custom_button.dart';
import 'package:invoice_producer/commons/common_widgets/custom_outline_button.dart';
import 'package:invoice_producer/commons/common_widgets/custom_text_fields.dart';
import 'package:invoice_producer/commons/common_widgets/image_picker_widget.dart';
import 'package:invoice_producer/core/enums/invoice_status_enum.dart';
import 'package:invoice_producer/features/user/invoice/controller/invoice_upload_controller.dart';
import 'package:invoice_producer/features/user/invoice/widgets/custom_arrow_button.dart';
import 'package:invoice_producer/models/invoice_model/invoice_model.dart';
import 'package:invoice_producer/routes/route_manager.dart';
import '../../../../commons/common_imports/common_libs.dart';
import '../../../../commons/common_widgets/show_toast.dart';
import '../../../../models/product_model/item_model.dart';
import '../../../../utils/constants/app_constants.dart';
import '../../../../utils/constants/assets_manager.dart';
import '../controller/invoice_controller.dart';
import '../widgets/invoice_top_widget.dart';
import '../widgets/item_list_widget.dart';
import '../widgets/total_widget.dart';

class SingleInvoiceScreen extends ConsumerStatefulWidget {
  final InVoiceModel invoice;

  const SingleInvoiceScreen({Key? key, required this.invoice})
      : super(key: key);

  @override
  ConsumerState<SingleInvoiceScreen> createState() =>
      _SingleInvoiceScreenState();
}

class _SingleInvoiceScreenState extends ConsumerState<SingleInvoiceScreen> {
  File? image;
  TextEditingController discountController = TextEditingController();
  TextEditingController depositController = TextEditingController();
  TextEditingController noteController = TextEditingController();
  TextEditingController shippingCostController = TextEditingController();
  // TextEditingController jobAddressController = TextEditingController();

  bool isUpdateLoading = false;

  // String? selectedCompany;
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
     noteController.text = invoice.termsAndCond ?? '';
      shippingCostController.text =
          invoice.shippingCost != null ? invoice.shippingCost.toString() : '';
      // jobAddressController.text = invoice.jobAddress ?? '';

    });
    super.initState();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            'Invoice',
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
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              InvoiceTopWidget(invoice: invoice),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: AppConstants.padding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 30.h,
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
                        ref.read(invoiceDataProvider.notifier).addDiscount(
                            discount: double.parse(
                                depositController.text.isEmpty
                                    ? '0.0'
                                    : depositController.text));
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
                            .addShippingCost(shippingCost: double.parse(value));
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
                              newDeposit: double.parse(value),
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
                    // CustomTextField(
                    //   controller: jobAddressController,
                    //   hintText: '',
                    //   label: 'Job Address',
                    //   fillColor: context.errorColor,
                    // ),
                    padding4,
                    TotalWidget(
                      totalText: totalText,
                    ),
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
                        Navigator.pushNamed(context, AppRoutes.addWorkSamples);
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
                                  isLoading: isUpdateLoading,
                                  padding: 0.h,
                                  onPressed: () async {
                                    setState(() {
                                      isUpdateLoading = true;
                                    });
                                    await updateButton();
                                    setState(() {
                                      isUpdateLoading = false;
                                    });
                                  },
                                  buttonText: 'Update invoices'),
                              CustomOutlineButton(
                                  isLoading: ref
                                      .watch(invoiceUploadControllerProvider),
                                  onPressed: () async {
                                    await updateButton(isPaid: true);
                                  },
                                  buttonText: 'Mark as fully paid'),
                            ],
                          ),
                    padding30
                  ],
                ),
              ),
            ])));
  }

  updateButton({bool isPaid = false}) {
    final invoiceRef = ref.read(invoiceDataProvider.notifier);
    final customer = invoiceRef.customerModel;
    final items = invoiceRef.productList;
    final signatures = invoiceRef.signatureModel;
    final payAccount = invoiceRef.paymentModel;
    final invoiceInfo = invoiceRef.invoiceModel;
    final subTotal = invoiceRef.subTotal;
    final total = invoiceRef.total;
    final dueAmount = invoiceRef.total - invoiceRef.paidAmount;
    // final paidAmount = invoiceRef.total -  invoiceRef.dueAmount;
    final totalTax = invoiceRef.totalTax;
    final shippingCost = invoiceRef.shippingCost;

    if (invoiceInfo == null) {
      showSnackBar(context, 'Add invoice information.');
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

    ref.read(invoiceUploadControllerProvider.notifier).updateInvoice(
          context: context,
          inVoiceModel: invoiceInfo.copyWith(
            items: items,
            signature: signatures,
            paymentAccount: payAccount,
            invoiceStatusEnum:
                isPaid ? InvoiceStatusEnum.paid : invoiceInfo.invoiceStatusEnum,
            depositAmount: double.parse(depositController.text.isEmpty
                ? '0.0'
                : depositController.text),
            subTotal: subTotal,
            total: total,
            tax: totalTax,
            dueBalance: isPaid ? 0.0 : dueAmount,
            shippingCost: shippingCost,
            paid: isPaid ? total : invoiceRef.paidAmount,
            isPaid: isPaid,
            // jobAddress: jobAddressController.text,
            addressType: invoiceRef.selectAddressType,
            addressLine1: invoiceRef.sameAsBilling ? customer?.billingAddress1
                : invoiceRef.addressLine1Controller.text,
            addressLine2: invoiceRef.sameAsBilling ? customer?.billingAddress2
                : invoiceRef.addressLine2Controller.text,
          ),
          logo: image,
        );
  }
}
