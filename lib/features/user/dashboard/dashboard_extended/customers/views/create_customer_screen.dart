import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:invoice_producer/commons/common_functions/search_tags_handler.dart';
import 'package:invoice_producer/commons/common_functions/validator.dart';
import 'package:invoice_producer/commons/common_widgets/common_dropdown.dart';
import 'package:invoice_producer/commons/common_widgets/custom_text_fields.dart';
import 'package:invoice_producer/commons/common_widgets/custom_button.dart';
import 'package:invoice_producer/commons/common_widgets/image_picker_widget.dart';
import 'package:invoice_producer/commons/common_widgets/show_toast.dart';
import 'package:invoice_producer/core/extensions/color_extension.dart';
import 'package:invoice_producer/features/auth/widgets/company_image_upload.dart';
import 'package:invoice_producer/features/user/dashboard/dashboard_extended/customers/controller/customer_controller.dart';
import 'package:invoice_producer/models/customer_model/customer_model.dart';
import 'package:invoice_producer/utils/constants/app_constants.dart';
import 'package:invoice_producer/utils/themes/styles_manager.dart';
import 'package:libphonenumber_plugin/libphonenumber_plugin.dart';
import '../../../../../../commons/common_imports/apis_commons.dart';
import '../../../../../../models/country_model/country_model.dart';
import '../../../../../../utils/constants/assets_manager.dart';
import '../../../../../../utils/constants/font_manager.dart';
import '../../../../../../utils/themes/my_colors.dart';
import '../../../../profile/Profile_Extended/edit_profile/widget/edit_profile_image_upload.dart';
import 'package:uuid/uuid.dart';

import '../../company/dropdown_widget/country_dropdown.dart';
import '../widget/phone_number_widget.dart';

class CreateCustomerScreen extends ConsumerStatefulWidget {
  final CustomerModel? customer;

  const CreateCustomerScreen({super.key, this.customer});

  @override
  ConsumerState<CreateCustomerScreen> createState() =>
      _CreateCustomerScreenState();
}

class _CreateCustomerScreenState extends ConsumerState<CreateCustomerScreen> {
  final nameController = TextEditingController();
  final noteCtr = TextEditingController();
  final companyNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final billingAddress1Controller = TextEditingController();
  final billingAddress2Controller = TextEditingController();
  // final addressLine2Controller = TextEditingController();
  // final addressLine1Controller = TextEditingController();
  Country? selectedCountry;
  File? image;
  final formKey = GlobalKey<FormState>();
  CustomerModel? oldCustomer;
  String? imageUrl;

  // List<String> countries = [
  //   'Afghanistan',
  //   'Albania',
  //   'Algeria',
  //   'Andorra',
  //   'Angola',
  //   'Antigua and Barbuda',
  //   'Argentina',
  //   'Armenia',
  //   'Australia',
  //   'Austria',
  //   'Azerbaijan',
  //   'Bahamas',
  //   'Bahrain',
  //   'Bangladesh',
  //   'Barbados',
  //   'Belarus',
  //   'Belgium',
  //   'Belize',
  //   'Benin',
  //   'Bhutan',
  //   'Bolivia',
  //   'Bosnia and Herzegovina',
  //   'Botswana',
  //   'Brazil',
  //   'Brunei',
  //   'Bulgaria',
  //   'Burkina Faso',
  //   'Burundi',
  //   'Cabo Verde',
  //   'Cambodia',
  //   'Cameroon',
  //   'Canada',
  //   'Central African Republic',
  //   'Chad',
  //   'Chile',
  //   'China',
  //   'Colombia',
  //   'Comoros',
  //   'Congo (Congo-Brazzaville)',
  //   'Costa Rica',
  //   'Croatia',
  //   'Cuba',
  //   'Cyprus',
  //   'Czech Republic (Czechia)',
  //   'Democratic Republic of the Congo',
  //   'Denmark',
  //   'Djibouti',
  //   'Dominica',
  //   'Dominican Republic',
  //   'East Timor (Timor-Leste)',
  //   'Ecuador',
  //   'Egypt',
  //   'El Salvador',
  //   'Equatorial Guinea',
  //   'Eritrea',
  //   'Estonia',
  //   'Eswatini (fmr. "Swaziland")',
  //   'Ethiopia',
  //   'Fiji',
  //   'Finland',
  //   'France',
  //   'Gabon',
  //   'Gambia',
  //   'Georgia',
  //   'Germany',
  //   'Ghana',
  //   'Greece',
  //   'Grenada',
  //   'Guatemala',
  //   'Guinea',
  //   'Guinea-Bissau',
  //   'Guyana',
  //   'Haiti',
  //   'Honduras',
  //   'Hungary',
  //   'Iceland',
  //   'India',
  //   'Indonesia',
  //   'Iran',
  //   'Iraq',
  //   'Ireland',
  //   'Israel',
  //   'Italy',
  //   'Ivory Coast',
  //   'Jamaica',
  //   'Japan',
  //   'Jordan',
  //   'Kazakhstan',
  //   'Kenya',
  //   'Kiribati',
  //   'Kuwait',
  //   'Kyrgyzstan',
  //   'Laos',
  //   'Latvia',
  //   'Lebanon',
  //   'Lesotho',
  //   'Liberia',
  //   'Libya',
  //   'Liechtenstein',
  //   'Lithuania',
  //   'Luxembourg',
  //   'Madagascar',
  //   'Malawi',
  //   'Malaysia',
  //   'Maldives',
  //   'Mali',
  //   'Malta',
  //   'Marshall Islands',
  //   'Mauritania',
  //   'Mauritius',
  //   'Mexico',
  //   'Micronesia',
  //   'Moldova',
  //   'Monaco',
  //   'Mongolia',
  //   'Montenegro',
  //   'Morocco',
  //   'Mozambique',
  //   'Myanmar (formerly Burma)',
  //   'Namibia',
  //   'Nauru',
  //   'Nepal',
  //   'Netherlands',
  //   'New Zealand',
  //   'Nicaragua',
  //   'Niger',
  //   'Nigeria',
  //   'North Korea',
  //   'North Macedonia',
  //   'Norway',
  //   'Oman',
  //   'Pakistan',
  //   'Palau',
  //   'Palestine State',
  //   'Panama',
  //   'Papua New Guinea',
  //   'Paraguay',
  //   'Peru',
  //   'Philippines',
  //   'Poland',
  //   'Portugal',
  //   'Qatar',
  //   'Romania',
  //   'Russia',
  //   'Rwanda',
  //   'Saint Kitts and Nevis',
  //   'Saint Lucia',
  //   'Saint Vincent and the Grenadines',
  //   'Samoa',
  //   'San Marino',
  //   'Sao Tome and Principe',
  //   'Saudi Arabia',
  //   'Senegal',
  //   'Serbia',
  //   'Seychelles',
  //   'Sierra Leone',
  //   'Singapore',
  //   'Slovakia',
  //   'Slovenia',
  //   'Solomon Islands',
  //   'Somalia',
  //   'South Africa',
  //   'South Korea',
  //   'South Sudan',
  //   'Spain',
  //   'Sri Lanka',
  //   'Sudan',
  //   'Suriname',
  //   'Sweden',
  //   'Switzerland',
  //   'Syria',
  //   'Tajikistan',
  //   'Tanzania',
  //   'Thailand',
  //   'Togo',
  //   'Tonga',
  //   'Trinidad and Tobago',
  //   'Tunisia',
  //   'Turkey',
  //   'Turkmenistan',
  //   'Tuvalu',
  //   'Uganda',
  //   'Ukraine',
  //   'United Arab Emirates',
  //   'United Kingdom',
  //   'United States of America',
  //   'Uruguay',
  //   'Uzbekistan',
  //   'Vanuatu',
  //   'Vatican City',
  //   'Venezuela',
  //   'Vietnam',
  //   'Yemen',
  //   'Zambia',
  //   'Zimbabwe'
  // ];

  @override
  void initState() {
    if (widget.customer != null) {
      oldCustomer = widget.customer;
      nameController.text = oldCustomer!.name;
      noteCtr.text = oldCustomer!.note;
      companyNameController.text = oldCustomer!.companyName;
      emailController.text = oldCustomer!.email;
      phoneController.text = oldCustomer!.phoneNo;
      billingAddress1Controller.text = oldCustomer!.billingAddress1;
      billingAddress2Controller.text = oldCustomer!.billingAddress2;
      // addressLine1Controller.text = oldCustomer!.workingAddress1;
      // addressLine2Controller.text = oldCustomer!.workingAddress2;
      selectedCountry = oldCustomer?.country;
      imageUrl = oldCustomer!.image;
    }
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    noteCtr.dispose();
    billingAddress1Controller.dispose();
    emailController.dispose();
    phoneController.dispose();
    // addressLine2Controller.dispose();
    // addressLine1Controller.dispose();
    companyNameController.dispose();
    billingAddress2Controller.dispose();
    super.dispose();
  }

  void selectImage() async {
    image = await pickImageFromGallery(context);
    setState(() {});
  }

  save() async {
    if (formKey.currentState!.validate()) {
      Map<String, dynamic> map = userSearchTagsHandler(
          fName: nameController.text, email: companyNameController.text);
      CustomerModel customer = CustomerModel(
          customerId: const Uuid().v4(),
          companyName: companyNameController.text,
          name: nameController.text,
          email: emailController.text,
          phoneNo: phoneController.text,
          billingAddress1: billingAddress1Controller.text,
          billingAddress2: billingAddress2Controller.text,
          country: selectedCountry,
          // workingAddress1: addressLine1Controller.text,
          // workingAddress2: addressLine2Controller.text,
          image: image?.path ?? '',
          note: noteCtr.text,
          searchTags: map);
      await ref
          .read(customerControllerProvider.notifier)
          .addCustomer(context: context, customerModel: customer);
    }
  }

  upDate() async {
    if (formKey.currentState!.validate()) {
      Map<String, dynamic> map = {};
      CustomerModel customer = CustomerModel(
          customerId: oldCustomer!.customerId,
          companyName: companyNameController.text,
          name: nameController.text,
          email: emailController.text,
          phoneNo: phoneController.text,
          billingAddress1: billingAddress1Controller.text,
          billingAddress2: billingAddress2Controller.text,
          country: selectedCountry,
          // workingAddress1: addressLine1Controller.text,
          // workingAddress2: addressLine2Controller.text,
          image: imageUrl ?? '',
          note: noteCtr.text,
          searchTags: map);
      await ref.read(customerControllerProvider.notifier).updateCustomer(
          context: context, customerModel: customer, imagePath: image?.path);
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
            'Create customers',
            style: getLibreBaskervilleExtraBoldStyle(
              color: context.titleColor,
              fontSize: MyFonts.size16,
            ),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              oldCustomer == null
                  ? CompanyImageUploadWidget(
                      onTap: selectImage,
                      image: image,
                    )
                  : EditProfileImageUploadWidget(
                      onTap: selectImage,
                      image: image,
                      imgUrl: oldCustomer!.image,
                    ),
              // CustomerImageUpload(
              //   onTap: selectImage,
              //   image: image,
              //   imgUrl: personImg,
              // ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: AppConstants.padding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 20.h,
                    ),
                    Text(
                      'Customer information',
                      style: getSemiBoldStyle(
                          color: context.titleColor, fontSize: MyFonts.size16),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Column(
                      children: [
                        Form(
                          key: formKey,
                          child: CustomTextField(
                            controller: nameController,
                            hintText: '',
                            label: 'Full Name',
                            validatorFn: uNameValidator,
                          ),
                        ),
                        CustomTextField(
                          controller: companyNameController,
                          hintText: '',
                          label: 'Company name',
                          // validatorFn: sectionValidator,
                        ),
                        CustomTextField(
                          controller: emailController,
                          hintText: '',
                          label: 'Email',
                          // validatorFn: emailValidator,
                        ),
                        PhoneNumberWidget(
                          phoneController: phoneController,
                          initialNumber: phoneController.text,
                        ),
                        CustomTextField(
                          controller: billingAddress1Controller,
                          hintText: '',
                          label: 'Billing address 1',
                          // validatorFn: sectionValidator,
                        ),
                        CustomTextField(
                          controller: billingAddress2Controller,
                          hintText: '',
                          label: 'Billing address 2',
                          // validatorFn: sectionValidator,
                        ),
                        CountryDropDown(
                          onChanged: (dynamic newValue) {
                            setState(() {
                              selectedCountry = newValue!;
                            });
                          },
                          value: selectedCountry,
                          hintText: '',
                          label: 'Country',
                        )        ,
                        // CommonDropDown(
                        //   valueItems: countries,
                        //   onChanged: (String? newValue) {
                        //     setState(() {
                        //       selectedCountry = newValue!;
                        //     });
                        //   },
                        //   value: selectedCountry,
                        //   hintText: '',
                        //   label: 'Country',
                        // ),
                        // CustomTextField(
                        //   controller: addressLine1Controller,
                        //   hintText: '',
                        //   label: 'Address line 1',
                        //   // validatorFn: sectionValidator,
                        // ),
                        // CustomTextField(
                        //   controller: addressLine2Controller,
                        //   hintText: '',
                        //   label: 'Address line 2',
                        //   // validatorFn: sectionValidator,
                        // ),
                        CustomTextField(
                          controller: noteCtr,
                          hintText: '',
                          label: 'Note',
                          verticalPadding: 10.h,
                          maxLines: 6,
                          // validatorFn: sectionValidator,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: AppConstants.padding),
                child: CustomButton(
                  isLoading: ref.watch(customerControllerProvider),
                  onPressed: oldCustomer != null ? upDate : save,
                  buttonText:
                      oldCustomer != null ? 'Update customer' : 'Save Customer',
                  buttonHeight: 45.h,
                ),
              ),
              SizedBox(
                height: 50.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
