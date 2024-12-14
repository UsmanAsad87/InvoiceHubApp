import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:invoice_producer/commons/common_functions/validator.dart';
import 'package:invoice_producer/commons/common_widgets/custom_text_fields.dart';
import 'package:invoice_producer/commons/common_widgets/custom_button.dart';
import 'package:invoice_producer/commons/common_widgets/image_picker_widget.dart';
import 'package:invoice_producer/core/extensions/color_extension.dart';
import 'package:invoice_producer/features/auth/widgets/company_image_upload.dart';
import 'package:invoice_producer/routes/route_manager.dart';
import 'package:invoice_producer/utils/constants/app_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:invoice_producer/utils/themes/styles_manager.dart';
import '../../../commons/common_imports/apis_commons.dart';
import '../../../commons/common_widgets/common_dropdown.dart';
import '../../../utils/constants/assets_manager.dart';
import '../../../utils/constants/font_manager.dart';

class CreateAuthCompanyScreen extends ConsumerStatefulWidget {
  const CreateAuthCompanyScreen({super.key});

  @override
  ConsumerState<CreateAuthCompanyScreen> createState() =>
      _CreateAuthCompanyScreenState();
}

class _CreateAuthCompanyScreenState extends ConsumerState<CreateAuthCompanyScreen> {
  final companyNameController = TextEditingController();
  final zipCodeController = TextEditingController();
  final comRegistrationNoController = TextEditingController();
  final streetController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final faxController = TextEditingController();
  final websiteController = TextEditingController();
  String? selectedCategory;
  String? selectedCountry;
  String? selectedCity;
  String? selectedState;
  File? image;
  final formKey = GlobalKey<FormState>();
  var passObscure = true;
  var passConObscure = true;
  var checkbox = false;

  List<String> companyCategories = [
    'Technology',
    'Finance',
    'Healthcare',
    'Manufacturing',
    'Retail',
    'Entertainment',
    'Telecommunications',
    'Energy',
    'Transportation',
    'Education',
    'Real Estate',
    'Hospitality',
  ];
  List<String> countries = [
    'United States',
    'Canada',
    'United Kingdom',
    'Germany',
    'France',
    'Australia',
    'India',
    'China',
    'Japan',
  ];

  // List of cities
  List<String> cities = [
    'New York',
    'Los Angeles',
    'Toronto',
    'London',
    'Berlin',
    'Paris',
    'Sydney',
    'Mumbai',
    'Beijing',
    'Tokyo',
  ];

  // List of states (provinces)
  List<String> states = [
    'California',
    'Texas',
    'Ontario',
    'Bavaria',
    'Île-de-France',
    'New South Wales',
    'Maharashtra',
    'Beijing',
    'Tokyo',
  ];

  @override
  void dispose() {
    companyNameController.dispose();
    zipCodeController.dispose();
    comRegistrationNoController.dispose();
    streetController.dispose();
    emailController.dispose();
    phoneController.dispose();
    faxController.dispose();
    websiteController.dispose();
    super.dispose();
  }

  void selectImage() async {
    image = await pickImageFromGallery(context);
    setState(() {});
  }

  next() async {
    Navigator.pushNamed(context, AppRoutes.addPaymentAccountScreen);
    // if (formKey.currentState!.validate()) {
    //
    // }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
      child: Scaffold(
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
            'Create company',
            style: getLibreBaskervilleExtraBoldStyle(
                color: context.titleColor, fontSize: MyFonts.size16),
          ),
          centerTitle: true,
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.addPaymentAccountScreen);
                },
                child: Text(
                  'Skip',
                  style: getMediumStyle(
                      color: context.greenColor, fontSize: MyFonts.size14),
                )),
          ],
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              CompanyImageUploadWidget(onTap: selectImage,image: image,),
              Padding(
                padding: EdgeInsets.symmetric(horizontal:AppConstants.padding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 30.h,
                    ),
                    Text(
                      'Company information',
                      style: getSemiBoldStyle(
                          color: context.titleColor, fontSize: MyFonts.size16),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Form(
                      key: formKey,
                      child: Column(
                        children: [
                          CustomTextField(
                            controller: companyNameController,
                            hintText: '',
                            label: 'Company Name',
                            validatorFn: uNameValidator,
                          ),
                          CommonDropDown(
                            valueItems: companyCategories,
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedCategory = newValue!;
                              });
                            },
                            value: selectedCategory,
                            hintText: '',
                            label: 'Company category',
                          ),
                          CustomTextField(
                            controller: comRegistrationNoController,
                            hintText: '',
                            label: 'Registration number',
                            validatorFn: sectionValidator,
                          ),
                          CommonDropDown(
                            valueItems: countries,
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedCountry = newValue!;
                              });
                            },
                            value: selectedCountry,
                            hintText: '',
                            label: 'Country',
                          ),
                          CustomTextField(
                            controller: streetController,
                            hintText: '',
                            label: 'Street',
                            validatorFn: sectionValidator,
                          ),
                          CommonDropDown(
                            valueItems: cities,
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedCity = newValue!;
                              });
                            },
                            value: selectedCity,
                            hintText: '',
                            label: 'City',
                          ),
                          CommonDropDown(
                            valueItems: states,
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedState = newValue!;
                              });
                            },
                            value: selectedState,
                            hintText: '',
                            label: 'State/Division/Province',
                          ),
                          CustomTextField(
                            controller: emailController,
                            hintText: '',
                            label: 'Email',
                            validatorFn: emailValidator,
                          ),
                          CustomTextField(
                            controller: phoneController,
                            hintText: '',
                            label: 'Phone',
                            validatorFn: phoneValidator,
                          ),
                          CustomTextField(
                            controller: faxController,
                            hintText: '',
                            label: 'FAX',
                            validatorFn: sectionValidator,
                          ),
                          CustomTextField(
                            controller: websiteController,
                            hintText: '',
                            label: 'Website',
                            validatorFn: sectionValidator,
                          ),
                        ],
                      ),
                    ),


                  ],
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(width: 2.w,),
                  Checkbox(
                    value: checkbox,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6.r),
                    ),
                    fillColor: MaterialStateColor.resolveWith((states) =>
                    checkbox
                        ? context.greenColor
                        : context.whiteColor),
                    checkColor: context.whiteColor,
                    onChanged: (bool? value) {
                      setState(() {
                        checkbox = value!;
                      });
                    },
                  ),
                  Text('Set company as default',
                      style: getRegularStyle(
                          fontSize: MyFonts.size12,
                          color: context.titleColor)),
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: AppConstants.padding),
                child: CustomButton(
                  // isLoading: ref.watch(authControllerProvider),
                  onPressed: next,
                  buttonText: 'Next',
                  buttonHeight: 45.h,
                ),
              ),
              SizedBox(height: 30.h,),
            ],
          ),
        ),
      ),
    );
  }
}

