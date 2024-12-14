import 'package:invoice_producer/commons/common_imports/common_libs.dart';
import 'package:invoice_producer/utils/constants/assets_manager.dart';

import '../../../../../../commons/common_imports/apis_commons.dart';
import '../../../../../../models/country_model/country_model.dart';
import '../../../controller/country_controller.dart';

class CountryDropDown extends ConsumerWidget {
  final String hintText;
  final String label;
  Country? value;

  // final List<dynamic> valueItems;
  final Function(dynamic) onChanged;

  CountryDropDown({
    super.key,
    required this.hintText,
    required this.label,
    this.value,
    // required this.valueItems,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context, ref) {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 10.h),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
            padding: EdgeInsets.only(left: 0.0.w, bottom: 5.h),
            child: Text(
              label,
              style: getRegularStyle(
                  fontSize: MyFonts.size12, color: context.titleColor),
            ),
          ),
          Container(
              height: 45.h,
              padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 5.h),
              decoration: BoxDecoration(
                color: context.whiteColor,
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(
                    color: context.bodyTextColor.withOpacity(0.4), width: 1.w),
              ),
              child: ref.watch(getAllCountriesProvider).when(
                    data: (countriesModel) {
                      value = value == null
                          ? null
                          : countriesModel.countries
                              .where((e) => e.id == value?.id)
                              .first;
                      return DropdownButton(
                          hint: Text(
                            hintText,
                            style: getRegularStyle(
                                color: Theme.of(context).colorScheme.secondary,
                                fontSize: MyFonts.size12),
                          ),
                          //menuMaxHeight: 250.h,
                          isExpanded: true,
                          menuMaxHeight: 300.h,
                          dropdownColor: context.whiteColor,
                          borderRadius: BorderRadius.circular(20.r),
                          underline: const SizedBox(),
                          icon: ImageIcon(
                              const AssetImage(AppAssets.arrowDownIcon),
                              size: 24.h,
                              color: context.titleColor),
                          value: countriesModel.countries.contains(value)
                              ? value
                              : null,
                          //null,
                          // countriesModel.countries.isNotEmpty ? value : null,

                          focusColor: Colors.blue,
                          style: getRegularStyle(
                              color: context.titleColor,
                              fontSize: MyFonts.size12),
                          onChanged: onChanged,
                          items: countriesModel.countries
                              .map<DropdownMenuItem<Country>>((Country value) {
                            return DropdownMenuItem(
                              value: value,
                              child: Text(value.name),
                            );
                          }).toList());
                    },
                    error: (e, s) => Row(
                      children: [
                        Text(
                          'Loading...',
                          style: getRegularStyle(
                              color: Theme.of(context).colorScheme.secondary,
                              fontSize: MyFonts.size12),
                        ),
                      ],
                    ),
                    loading: () => Row(
                      children: [
                        Text(
                          'Loading...',
                          style: getRegularStyle(
                              color: Theme.of(context).colorScheme.secondary,
                              fontSize: MyFonts.size12),
                        ),
                      ],
                    ),
                  ))
        ]));
  }
}
