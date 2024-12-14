import 'package:invoice_producer/commons/common_imports/common_libs.dart';
import 'package:invoice_producer/utils/constants/assets_manager.dart';

import '../../../../../../commons/common_imports/apis_commons.dart';
import '../../../../../../models/country_model/country_model.dart';
import '../../../../../../models/state_model/state_model.dart';
import '../../../controller/country_controller.dart';

class StateDropDown extends ConsumerWidget {
  final String hintText;
  final String label;
  StateModel? value;
  final Country? country;

  // final List<dynamic> valueItems;
  final Function(dynamic) onChanged;

  StateDropDown({
    super.key,
    required this.hintText,
    required this.label,
    this.value,
    this.country,
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
              child: country == null
                  ? Row(
                      children: [
                        Text(
                          'Select Country',
                          style: getRegularStyle(
                              color: Theme.of(context).colorScheme.secondary,
                              fontSize: MyFonts.size12),
                        ),
                      ],
                    )
                  : ref
                      .watch(getAllStatesProvider(country?.id.toString() ?? ''))
                      .when(
                        data: (stateModel) {
                          value = value == null
                              ? null
                              : stateModel.states
                                  .where((e) => e.id == value?.id)
                                  .first;
                          return DropdownButton(
                              hint: Text(
                                hintText,
                                style: getRegularStyle(
                                    color:
                                        Theme.of(context).colorScheme.secondary,
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
                              value: stateModel.states.contains(value)
                                  ? value
                                  : null,
                              focusColor: Colors.blue,
                              style: getRegularStyle(
                                  color: context.titleColor,
                                  fontSize: MyFonts.size12),
                              onChanged: onChanged,
                              items: stateModel.states
                                  .map<DropdownMenuItem<dynamic>>(
                                      (dynamic value) {
                                return DropdownMenuItem(
                                  value: value,
                                  child: Text(
                                    value.runtimeType == StateModel
                                        ? value.name
                                        : value,
                                  ),
                                );
                              }).toList()
                              // countriesModel.countries;
                              );
                        },
                        error: (e, s) => Row(
                          children: [
                            Text(
                              'Loading... $e',
                              style: getRegularStyle(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  fontSize: MyFonts.size12),
                            ),
                          ],
                        ),
                        loading: () => Row(
                          children: [
                            Text(
                              'Loading...',
                              style: getRegularStyle(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  fontSize: MyFonts.size12),
                            ),
                          ],
                        ),
                      ))
        ]));
  }
}
