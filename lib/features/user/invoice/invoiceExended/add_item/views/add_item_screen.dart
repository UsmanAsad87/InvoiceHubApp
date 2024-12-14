import 'package:invoice_producer/commons/common_functions/currency_converter.dart';
import 'package:invoice_producer/commons/common_functions/validator.dart';
import 'package:invoice_producer/commons/common_widgets/custom_button.dart';
import 'package:invoice_producer/commons/common_widgets/custom_text_fields.dart';
import 'package:invoice_producer/commons/common_widgets/show_toast.dart';
import 'package:invoice_producer/core/enums/currency_sign_enum.dart';
import 'package:invoice_producer/features/user/dashboard/controller/dashboard_notifiar_ctr.dart';
import '../../../../../../../commons/common_imports/apis_commons.dart';
import '../../../../../../../commons/common_imports/common_libs.dart';
import '../../../../../../../utils/constants/app_constants.dart';
import '../../../../../../../utils/constants/assets_manager.dart';
import '../../../../../../models/product_model/item_model.dart';
import '../../../controller/invoice_controller.dart';
import '../widgets/add_item_profile_image.dart';

class AddItemScreen extends ConsumerStatefulWidget {
  final ItemModel product;
  final bool? isUpdate;

  const AddItemScreen({
    Key? key,
    required this.product,
    this.isUpdate,
  }) : super(key: key);

  @override
  ConsumerState<AddItemScreen> createState() => _AddItemScreenState();
}

class _AddItemScreenState extends ConsumerState<AddItemScreen> {
  TextEditingController quantityController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  ItemModel? product;
  bool isLoading = false;

  @override
  void initState() {
    product = widget.product;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: context.scaffoldBackgroundColor,
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
            'Add item',
            style: getLibreBaskervilleBoldStyle(
                color: context.titleColor, fontSize: MyFonts.size16),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(children: [
              const AddItemProfileImage(
                imgUrl: productPlaceHolderUrl,
              ),
              Padding(
                padding: EdgeInsets.all(AppConstants.padding),
                child: Column(
                  children: [
                    SizedBox(
                      height: 20.h,
                    ),
                    Form(
                      key: formKey,
                      child: Column(
                        children: [
                          CustomTextField(
                            controller: quantityController,
                            hintText: '',
                            inputType: TextInputType.number,
                            label: 'Quantity',
                            validatorFn: quantityValidator,
                          ),
                        ],
                      ),
                    ),
                    CustomButton(
                      onPressed: widget.isUpdate == null ? onPressed : update,
                      isLoading: isLoading,
                      buttonText: widget.isUpdate == null ? 'Save' : 'update',
                    ),
                  ],
                ),
              )
            ])));
  }

  onPressed() async {
    if (formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      double quantity = double.parse(quantityController.text);
      final invoice = ref.read(invoiceDataProvider);
      final defaultCurrency = ref.read(dashBoardNotifierCtr).currencyTypeEnum;
      final itemRate = await CurrencyConverter().convertCurrency(
        fromCurrency: product?.currency.name ?? 'USD',
        toCurrency: invoice.selectedCurrency?.name ??
            defaultCurrency?.name ?? 'USD',
        amount: product?.finalRate ?? 0,
      );
      print(itemRate);
      await ref.read(invoiceDataProvider.notifier).setProductData(
              model: product!.copyWith(
            soldQuantity: quantity,
            finalRate: itemRate,
            // rate: product!.rate,
          ));
      isLoading = false;
      showSnackBar(context, 'product selected.');
      Navigator.of(context).pop();
    }
  }

  update() async {
    if (formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      double quantity = double.parse(quantityController.text);

      await ref.read(invoiceDataProvider.notifier).updateProductData(
          model:
              product!.copyWith(soldQuantity: quantity, rate: product!.rate));
      isLoading = false;
      showSnackBar(context, 'product updated.');
      Navigator.of(context).pop();
    }
  }
}
