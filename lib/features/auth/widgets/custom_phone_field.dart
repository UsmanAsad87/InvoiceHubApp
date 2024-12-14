import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../commons/common_imports/common_libs.dart';


class CustomPhoneField extends ConsumerStatefulWidget {
  final TextEditingController controller;
  final String? hintText;
  final Function(String) onChanged;
  final Function(String) onFieldSubmitted;
  final TextInputType? inputType;
  final bool? obscure;
  final IconData? icon;
  final String? Function(String?)? validatorFn;
  final String labelText;
  final int? maxLines;
  final Widget? trailing;

  const CustomPhoneField({
    Key? key,
    required this.controller,
    this.hintText,
    required this.onChanged,
    required this.onFieldSubmitted,
    this.inputType,
    this.obscure,
    this.validatorFn,
    this.icon,
    required this.labelText,
    this.maxLines,
    this.trailing,
  }) : super(key: key);

  @override
  ConsumerState<CustomPhoneField> createState() => _CustomPhoneFieldState();
}

class _CustomPhoneFieldState extends ConsumerState<CustomPhoneField> {
  late bool invalid;

  @override
  Widget build(BuildContext context) {

    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding:  EdgeInsets.only(left: 20.0.w,bottom: 5.h),
            child: Row(
              children: [
                Text(
                  widget.labelText,
                  style: getSemiBoldStyle(
                      fontSize: MyFonts.size13,
                      color: context.greenColor),
                ),
                Text(
                  '*',
                  style: getSemiBoldStyle(
                      fontSize: MyFonts.size18,
                      color: Theme.of(context).colorScheme.error),
                ),
              ],
            ),
          ),
          SizedBox(height: 12.h,),
          Container(
            decoration: BoxDecoration(
                color: context.containerColor,
                borderRadius: BorderRadius.circular(100.r)
            ),
            child: Row(
              children: [
                Container(
                  height: 50.h,
                  margin: EdgeInsets.only(right: 10.w),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.r),
                      border: Border.all(
                          color: Colors.black.withOpacity(0.05)
                      )
                  ),
                  child: CountryCodePicker(
                    onChanged: (val){
                    },
                    initialSelection: 'IT',
                    favorite: const ['+39','FR'],
                    showCountryOnly: false,
                    showOnlyCountryWhenClosed: false,
                    alignLeft: false,
                    backgroundColor: context.scaffoldBackgroundColor,
                    dialogBackgroundColor: context.scaffoldBackgroundColor,
                    textStyle: getSemiBoldStyle(
                      color: context.whiteColor,
                      fontSize: MyFonts.size13
                    ),
                    flagDecoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    flagWidth: 28.w,

                  ),
                ),
                Expanded(
                  child: TextFormField(
                    validator: (val) {
                      if (val!.length < 5 || val.length > 12) {
                        setState(() {
                          invalid = true;
                        });
                        return 'Enter valid phone number!';
                      } else {
                        setState(() {
                          invalid = false;
                        });
                        return null;
                      }
                    },
                    controller: widget.controller,
                    keyboardType: TextInputType.phone,
                    style:
                    getRegularStyle(fontSize: MyFonts.size12, color: context.greenColor),
                    decoration: InputDecoration(
                      fillColor: context.containerColor,
                      filled: true,
                      contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
                      errorStyle: getRegularStyle(
                          fontSize: MyFonts.size10,
                          color: Theme.of(context).colorScheme.error),

                      hintText: widget.hintText,
                      hintStyle: getRegularStyle(
                          fontSize: MyFonts.size12,
                          color: Theme.of(context).colorScheme.secondary),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(100.r),
                        borderSide:const BorderSide(color: Colors.transparent, width: 0.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(100.r),
                        borderSide:const BorderSide(color: Colors.transparent, width: 0.0),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(100.r),
                        borderSide:const BorderSide(color: Colors.transparent, width: 0.0),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(100.r),
                        borderSide:const BorderSide(color: Colors.transparent, width: 0.0),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(100.r),
                        borderSide:const BorderSide(color: Colors.transparent, width: 0.0),
                      ),
                    ),
                    onFieldSubmitted: widget.onFieldSubmitted,
                    onChanged: widget.onChanged,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


