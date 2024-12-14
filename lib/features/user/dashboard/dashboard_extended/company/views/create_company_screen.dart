import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:invoice_producer/commons/common_functions/padding.dart';
import 'package:invoice_producer/commons/common_functions/validator.dart';
import 'package:invoice_producer/commons/common_widgets/custom_text_fields.dart';
import 'package:invoice_producer/commons/common_widgets/custom_button.dart';
import 'package:invoice_producer/commons/common_widgets/image_picker_widget.dart';
import 'package:invoice_producer/core/extensions/color_extension.dart';
import 'package:invoice_producer/features/auth/controller/auth_notifier_controller.dart';
import 'package:invoice_producer/features/auth/widgets/company_image_upload.dart';
import 'package:invoice_producer/features/user/dashboard/dashboard_extended/company/controller/comany_controller.dart';
import 'package:invoice_producer/utils/constants/app_constants.dart';
import 'package:invoice_producer/utils/constants/font_manager.dart';
import 'package:invoice_producer/utils/themes/styles_manager.dart';
import 'package:uuid/uuid.dart';
import '../../../../../../commons/common_imports/apis_commons.dart';
import '../../../../../../commons/common_widgets/common_dropdown.dart';
import '../../../../../../models/auth_models/user_model.dart';
import '../../../../../../models/city_model/city_model.dart';
import '../../../../../../models/company_models/company_model.dart';
import '../../../../../../models/country_model/country_model.dart';
import '../../../../../../models/state_model/state_model.dart';
import '../../../../../../routes/route_manager.dart';
import '../../../../../../utils/constants/assets_manager.dart';
import '../../../../profile/Profile_Extended/edit_profile/widget/edit_profile_image_upload.dart';
import '../../customers/widget/phone_number_widget.dart';
import '../dropdown_widget/city_dropdown.dart';
import '../dropdown_widget/country_dropdown.dart';
import '../dropdown_widget/state_dropdown.dart';

class CreateCompanyScreen extends ConsumerStatefulWidget {
  final CompanyModel? company;
  final bool? isSkip;

  const CreateCompanyScreen({super.key, this.company, this.isSkip});

  @override
  ConsumerState<CreateCompanyScreen> createState() =>
      _CreateCompanyScreenState();
}

class _CreateCompanyScreenState extends ConsumerState<CreateCompanyScreen> {
  final companyNameController = TextEditingController();
  final comRegistrationNoController = TextEditingController();
  final companyCategory = TextEditingController();
  final streetController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final faxController = TextEditingController();
  final websiteController = TextEditingController();
  final postCodeController = TextEditingController();
  String? selectedCategory;
  // String? selectedCountry;
  Country? selectedCountry;
  City? selectedCity;
  // String? selectedCity;
  StateModel? selectedState;
  // String? selectedState;
  File? image;
  bool? containCompanyCategory;
  String? imageUrl;
  final formKey = GlobalKey<FormState>();
  var passObscure = true;
  var passConObscure = true;
  var checkbox = false;
  CompanyModel? oldCompany;
  UserModel? user;
  bool isSkip = false;

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
    'Other',
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
  void initState() {
    isSkip = widget.isSkip ?? false;
    if (widget.company != null) {
      oldCompany = widget.company;
      user = ref.read(authNotifierCtr).userModel;
      if (user!.defaultCompany == oldCompany!.companyId) {
        checkbox = true;
      }
      companyNameController.text = oldCompany!.name;
      if (!companyCategories.contains(oldCompany!.companyType)) {
        companyCategory.text = oldCompany!.companyType;
      } else {
        print('Im else: ${oldCompany!.companyType}');
      }
      if (!companyCategories.contains(oldCompany!.companyType)) {
        containCompanyCategory = false;
      } else {
        containCompanyCategory = true;
      }

      comRegistrationNoController.text = oldCompany?.registrationNo ?? '';
      streetController.text = oldCompany!.street;
      emailController.text = oldCompany?.email ?? '';
      phoneController.text = oldCompany?.phoneNo ?? '';
      faxController.text = oldCompany?.fax ?? '';
      websiteController.text = oldCompany?.websiteName ?? '';
      postCodeController.text = oldCompany?.postCode ?? '';
      selectedCategory =
          oldCompany?.companyType == '' ? null : oldCompany?.companyType;
      selectedCountry =  oldCompany!.country;
      // selectedCountry = oldCompany!.country == '' ? null : oldCompany!.country;
      selectedCity = oldCompany!.city;
      selectedState = oldCompany!.state;
      imageUrl = oldCompany?.logo == '' ? null : oldCompany?.logo;
    } else {
      containCompanyCategory = true;
    }
    super.initState();
  }

  @override
  void dispose() {
    companyNameController.dispose();
    comRegistrationNoController.dispose();
    companyCategory.dispose();
    streetController.dispose();
    emailController.dispose();
    phoneController.dispose();
    faxController.dispose();
    websiteController.dispose();
    postCodeController.dispose();
    super.dispose();
  }

  void selectImage() async {
    image = await pickImageFromGallery(context);
    setState(() {});
  }

  next() async {
    if (formKey.currentState!.validate()) {
      Map<String, dynamic> map = {};
      CompanyModel company = CompanyModel(
          companyId: const Uuid().v4(),
          name: companyNameController.text.trim(),
          companyType: selectedCategory ?? '',
          registrationNo: comRegistrationNoController.text.trim() ?? '',
          country: selectedCountry,
          street: streetController.text.trim(),
          city: selectedCity,
          state: selectedState,
          email: emailController.text.trim() ?? '',
          phoneNo: phoneController.text.trim() ?? '',
          websiteName: websiteController.text.trim() ?? '',
          logo: image?.path ?? '',
          fax: faxController.text.trim() ?? '',
          postCode: postCodeController.text.trim() ?? '',
          searchTag: map);
      final user = ref.read(authNotifierCtr).userModel;
      await ref.read(companyControllerProvider.notifier).addCompany(
          context: context,
          companyModel: company,
          isDefault: checkbox,
          // user: user!,
          isSkip: isSkip);
    }
  }

  upDate() async {
    if (formKey.currentState!.validate()) {
      Map<String, dynamic> map = {};
      CompanyModel company = CompanyModel(
          companyId: oldCompany!.companyId,
          name: companyNameController.text.trim(),
          companyType: selectedCategory == 'Other'
              ? companyCategory.text
              : selectedCategory ?? '',
          registrationNo: comRegistrationNoController.text.trim(),
          country: selectedCountry,
          street: streetController.text.trim(),
          city: selectedCity,
          state: selectedState,
          email: emailController.text.trim(),
          phoneNo: phoneController.text.trim(),
          websiteName: websiteController.text.trim(),
          logo: imageUrl ?? '',
          fax: faxController.text.trim(),
          postCode: postCodeController.text.trim(),
          searchTag: map);
      final user = ref.read(authNotifierCtr).userModel;
      await ref.read(companyControllerProvider.notifier).updateCompany(
          context: context,
          companyModel: company,
          isDefault: checkbox,
          user: user!,
          imagePath: image?.path);
    }
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
            if (isSkip)
              TextButton(
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(context,
                        AppRoutes.addPaymentAccountScreen, (route) => false,
                        arguments: {'skip': true});
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
              oldCompany == null || oldCompany?.logo == ''
                  ? CompanyImageUploadWidget(
                      onTap: selectImage,
                      image: image,
                    )
                  : EditProfileImageUploadWidget(
                      onTap: selectImage,
                      image: image,
                      imgUrl: oldCompany!.logo,
                    ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: AppConstants.padding),
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
                          containCompanyCategory! && selectedCategory != 'Other'
                              ? CommonDropDown(
                                  valueItems: companyCategories,
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      // selectedCategory = newValue!;
                                    });
                                  },
                                  value: selectedCategory,
                                  hintText: '',
                                  label: 'Company category',
                                )
                              : CustomTextField(
                                  controller: companyCategory,
                                  hintText: '',
                                  label: 'Company category',
                                  // validatorFn: sectionValidator,
                                ),
                          CustomTextField(
                            controller: comRegistrationNoController,
                            hintText: '',
                            label: 'Registration number',
                            // validatorFn: sectionValidator,
                          ),
                          CountryDropDown(
                            onChanged: (dynamic newValue) {
                              setState(() {
                                selectedCountry = newValue;
                              });
                            },
                            value: selectedCountry,
                            hintText: '',
                            label: 'Country',
                          ),
                          // CountryDropDown(
                          //   valueItems: ref.watch(getAllCountriesProvider).when(
                          //       data: (countries) => countries.map((e) => e.id).toList(),
                          //       error: (e,s) => [],
                          //       loading: () => []),
                          //   //countries,
                          //   onChanged: (dynamic? newValue) {
                          //     setState(() {
                          //       selectedCountry = newValue!;
                          //     });
                          //   },
                          //   value: selectedCountry,
                          //   hintText: '',
                          //   label: 'Country',
                          // ),
                          CustomTextField(
                            controller: streetController,
                            hintText: '',
                            label: 'Street',
                            // validatorFn: sectionValidator,
                          ),
                          // CommonDropDown(
                          //   valueItems: cities,
                          //   onChanged: (String? newValue) {
                          //     setState(() {
                          //       selectedCity = newValue!;
                          //     });
                          //   },
                          //   value: selectedCity,
                          //   hintText: '',
                          //   label: 'City',
                          // ),
                          if(selectedCountry != null)
                          StateDropDown(
                            // valueItems: states,
                            onChanged: (dynamic newValue) {
                              setState(() {
                                selectedState = newValue!;
                              });
                            },
                            country: selectedCountry,
                            value: selectedState,
                            hintText: '',
                            label: 'State/Division/Province',
                          ),
                          if(selectedState != null)
                          CityDropDown(
                            onChanged: (dynamic newValue) {
                              setState(() {
                                selectedCity = newValue!;
                              });
                            },
                            state: selectedState,
                            value: selectedCity,
                            hintText: '',
                            label: 'City',
                          ),
                          // CommonDropDown(
                          //   valueItems: states,
                          //   onChanged: (String? newValue) {
                          //     setState(() {
                          //       selectedState = newValue!;
                          //     });
                          //   },
                          //   value: selectedState,
                          //   hintText: '',
                          //   label: 'State/Division/Province',
                          // ),
                          CustomTextField(
                            controller: emailController,
                            hintText: '',
                            label: 'Email',
                            //   validatorFn: emailValidator,
                          ),
                          PhoneNumberWidget(
                              phoneController: phoneController,
                              initialNumber: phoneController.text),
                          // CustomTextField(
                          //   controller: phoneController,
                          //   hintText: '',
                          //   label: 'Phone',
                          //   // validatorFn: phoneValidator,
                          // ),
                          CustomTextField(
                            controller: postCodeController,
                            hintText: '',
                            label: 'Post Code',
                            // validatorFn: phoneValidator,
                          ),
                          CustomTextField(
                            controller: faxController,
                            hintText: '',
                            label: 'FAX',
                            //  validatorFn: sectionValidator,
                          ),
                          CustomTextField(
                            controller: websiteController,
                            hintText: '',
                            label: 'Website',
                            //  validatorFn: sectionValidator,
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
                  SizedBox(
                    width: 2.w,
                  ),
                  Checkbox(
                    value: checkbox,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6.r),
                    ),
                    fillColor: MaterialStateColor.resolveWith((states) =>
                        checkbox ? context.greenColor : context.whiteColor),
                    checkColor: context.whiteColor,
                    onChanged: (bool? value) {
                      setState(() {
                        checkbox = value!;
                      });
                    },
                  ),
                  Text('Set company as default',
                      style: getRegularStyle(
                          fontSize: MyFonts.size12, color: context.titleColor)),
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: AppConstants.padding),
                child: CustomButton(
                  isLoading: ref.watch(companyControllerProvider),
                  onPressed: oldCompany != null ? upDate : next,
                  buttonText: oldCompany != null ? 'update' : 'Add', //'Next',
                  buttonHeight: 45.h,
                ),
              ),
              padding30,
            ],
          ),
        ),
      ),
    );
  }
}
