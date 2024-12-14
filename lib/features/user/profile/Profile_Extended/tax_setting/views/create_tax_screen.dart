import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:invoice_producer/commons/common_functions/padding.dart';
import 'package:invoice_producer/commons/common_functions/validator.dart';
import 'package:invoice_producer/commons/common_widgets/custom_button.dart';
import 'package:invoice_producer/commons/common_widgets/custom_text_fields.dart';
import 'package:invoice_producer/features/user/profile/Profile_Extended/tax_setting/controller/tax_controller.dart';
import 'package:invoice_producer/models/tax_model/tax_model.dart';
import 'package:invoice_producer/utils/constants/app_constants.dart';

import '../../../../../../commons/common_imports/common_libs.dart';
import '../../../../../../commons/common_widgets/floatingActionButton.dart';
import '../../../../../../utils/constants/assets_manager.dart';
import 'package:uuid/uuid.dart';

class CreateTaxScreen extends ConsumerStatefulWidget {
  final TaxModel? tax;

  const CreateTaxScreen({Key? key, this.tax}) : super(key: key);

  @override
  ConsumerState<CreateTaxScreen> createState() => _CreateTaxScreenState();
}

class _CreateTaxScreenState extends ConsumerState<CreateTaxScreen> {
  TextEditingController taxNameController = TextEditingController();
  TextEditingController taxAmountController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  TaxModel? oldTax;

  @override
  void initState() {
    if (widget.tax != null) {
      oldTax = widget.tax;
      taxNameController.text = oldTax!.name;
      taxAmountController.text = oldTax!.percentage.toString();
    }
    super.initState();
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
          'Create Tax',
          style: getLibreBaskervilleBoldStyle(
              color: context.titleColor, fontSize: MyFonts.size16),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: EdgeInsets.all(AppConstants.padding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Add Tax percentage",
              style: getSemiBoldStyle(
                  color: context.titleColor, fontSize: MyFonts.size16),
            ),
            padding12,
            Form(
              key: formKey,
              child: Column(
                children: [
                  CustomTextField(
                    controller: taxNameController,
                    hintText: '',
                    label: 'Tax name',
                    validatorFn: taxNameValidator,
                  ),
                  CustomTextField(
                    controller: taxAmountController,
                    hintText: '',
                    label: 'Tax amount%',
                    validatorFn: percentageValidator,
                  ),
                ],
              ),
            ),
            CustomButton(
                isLoading: ref.watch(taxControllerProvider),
                onPressed: oldTax == null ? save : upDate,
                buttonText:  oldTax == null ? 'Add Tax' : 'Update Tax')
          ],
        ),
      )),
    );
  }

  save() {
    if (formKey.currentState!.validate()) {
      TaxModel tax = TaxModel(
          taxId: const Uuid().v4(),
          name: taxNameController.text,
          percentage: double.parse(taxAmountController.text));
      ref
          .read(taxControllerProvider.notifier)
          .addTax(context: context, taxModel: tax);
    }
  }

  upDate() {
    if (formKey.currentState!.validate()) {
      TaxModel tax = TaxModel(
          taxId: oldTax!.taxId,
          name: taxNameController.text,
          percentage: double.parse(taxAmountController.text));
      ref
          .read(taxControllerProvider.notifier)
          .addTax(context: context, taxModel: tax);
    }
  }
}
