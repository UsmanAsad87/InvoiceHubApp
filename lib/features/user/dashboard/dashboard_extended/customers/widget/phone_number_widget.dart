import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:invoice_producer/commons/common_imports/common_libs.dart';
import 'package:libphonenumber_plugin/libphonenumber_plugin.dart';
import '../../../../../../utils/constants/app_constants.dart';
import '../../company/controller/initial_code_notifier.dart';

class PhoneNumberWidget extends ConsumerStatefulWidget {
  final TextEditingController phoneController;
  String? initialNumber;

  // String? initialCountry;

  PhoneNumberWidget({
    super.key,
    required this.phoneController,
    required this.initialNumber,
    // this.initialCountry
  });

  @override
  ConsumerState<PhoneNumberWidget> createState() => _PhoneNumberWidgetState();
}

class _PhoneNumberWidgetState extends ConsumerState<PhoneNumberWidget> {
  String? initialCountry;

  getCode({required String? number}) async {
    if (widget.initialNumber != '') {
      final info = await PhoneNumberUtil.getRegionInfo(number ?? '', '');
      initialCountry = info.isoCode ?? 'US';
      ref
          .read(initialCountryProvider.notifier)
          .setInitialCountry(initialCountry);
    }
  }

  @override
  initState() {
    getCode(number: widget.phoneController.text);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    widget.initialNumber = ref.watch(initialCountryProvider);
    return Container(
      margin: EdgeInsets.symmetric(vertical: 0.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 0.0.w, bottom: 5.h),
            child: Text(
              'Contact number',
              style: getRegularStyle(
                  fontSize: MyFonts.size12, color: context.titleColor),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 15.w, right: 15.w, bottom: 0.h),
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(
                color: context.bodyTextColor.withOpacity(0.4),
                width: 1.w,
              ),
            ),
            child: InternationalPhoneNumberInput(
              spaceBetweenSelectorAndTextField: 0,
              onInputChanged: (PhoneNumber number) {
                ref.read(initialCountryProvider.notifier)
                    .setInitialCountry(number.isoCode);
                widget.phoneController.text = number.phoneNumber ?? '';
              },
              scrollPadding: EdgeInsets.symmetric(
                  horizontal: AppConstants.paddingHorizontal,
                  vertical: AppConstants.paddingVertical),
              selectorConfig: const SelectorConfig(
                selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
              ),
              textStyle: getRegularStyle(
                  fontSize: MyFonts.size12, color: context.bodyTextColor),
              selectorTextStyle: getRegularStyle(
                  fontSize: MyFonts.size12, color: context.bodyTextColor),
              initialValue: widget.initialNumber != null
                  ? PhoneNumber(
                      isoCode: widget.initialNumber,
                      phoneNumber: widget.initialNumber,
                    )
                  : PhoneNumber(isoCode: 'US'),
              inputDecoration: InputDecoration(
                hintText: '',
                hintStyle: getRegularStyle(
                    fontSize: MyFonts.size14,
                    color: MyColors.darkButtonTextColor),
                border: InputBorder.none,
              ),
            ),
          ),
          // }),
        ],
      ),
    );
  }
}
