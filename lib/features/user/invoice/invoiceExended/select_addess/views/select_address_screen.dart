import 'package:invoice_producer/commons/common_functions/padding.dart';
import 'package:invoice_producer/commons/common_widgets/custom_button.dart';

import '../../../../../../commons/common_imports/apis_commons.dart';
import '../../../../../../commons/common_imports/common_libs.dart';
import '../../../../../../commons/common_widgets/common_dropdown.dart';
import '../../../../../../commons/common_widgets/custom_text_fields.dart';
import '../../../../../../core/enums/addreess_type.dart';
import '../../../../../../utils/constants/assets_manager.dart';
import '../../../controller/invoice_controller.dart';

class SelectAddressScreen extends ConsumerStatefulWidget {
  const SelectAddressScreen({super.key});

  @override
  ConsumerState<SelectAddressScreen> createState() =>
      _SelectAddressScreenState();
}

class _SelectAddressScreenState extends ConsumerState<SelectAddressScreen> {
  // var checkbox = false;
  // final addressLine2Controller = TextEditingController();
  // final addressLine1Controller = TextEditingController();
  // AddressTypeEnum? selectedAddressType;

  @override
  void dispose() {
    // addressLine2Controller.dispose();
    // addressLine1Controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final invoiceCtr = ref.watch(invoiceDataProvider);
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
          'Select address type',
          style: getLibreBaskervilleExtraBoldStyle(
            color: context.titleColor,
            fontSize: MyFonts.size16,
          ),
        ),
        centerTitle: true,
      ),
      body: InkWell(
        overlayColor:
            const WidgetStatePropertyAll(WidgetStateColor.transparent),
        onTap: (){
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 18.w),
                child: CommonDropDown(
                  valueItems: [
                    AddressTypeEnum.workAddress.type,
                    AddressTypeEnum.inspectionAddress.type,
                    AddressTypeEnum.shippingAddress.type,
                    AddressTypeEnum.serviceAddress.type,
                  ],
                  value: invoiceCtr.selectAddressType?.type,
                  onChanged: (value) {
                    invoiceCtr.setAddressType(
                        addressType: (value)?.toAddressTypeEnum());
                    // setState(() {
                    //   selectedAddressType = (value)?.toAddressTypeEnum();
                    // });
                  },
                  hintText: 'Select Address',
                  label: 'Select Address',
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Checkbox(
                      value: invoiceCtr.sameAsBilling,
                      //checkbox,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6.r),
                      ),
                      fillColor: MaterialStateColor.resolveWith((states) =>
                          invoiceCtr.sameAsBilling
                              ? context.greenColor
                              : context.whiteColor),
                      checkColor: context.whiteColor,
                      onChanged: (bool? value) {
                        invoiceCtr.setAddressAsBilling(value ?? false);
                        // setState(() {
                        //   checkbox = value!;
                        // });
                      },
                    ),
                    Text(
                      'Same as Billing address',
                      style: getRegularStyle(
                        fontSize: MyFonts.size14,
                        color: context.titleColor,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 18.w),
                child: Column(
                  children: [
                    CustomTextField(
                      controller: invoiceCtr.addressLine1Controller,
                      hintText: '',
                      label: 'Address line 1',
                      enabled: !invoiceCtr.sameAsBilling,
                      // validatorFn: sectionValidator,
                    ),
                    CustomTextField(
                      controller: invoiceCtr.addressLine2Controller,
                      hintText: '',
                      label: 'Address line 2',
                      enabled: !invoiceCtr.sameAsBilling,
                      // validatorFn: sectionValidator,
                    ),
                    padding100,
                    CustomButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      buttonText: 'Save',
                      // buttonWidth: 200.w,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
