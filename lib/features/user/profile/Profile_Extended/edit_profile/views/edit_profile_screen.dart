import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:invoice_producer/commons/common_functions/validator.dart';
import 'package:invoice_producer/commons/common_widgets/common_dropdown.dart';
import 'package:invoice_producer/commons/common_widgets/custom_text_fields.dart';
import 'package:invoice_producer/commons/common_widgets/custom_button.dart';
import 'package:invoice_producer/commons/common_widgets/image_picker_widget.dart';
import 'package:invoice_producer/commons/common_widgets/show_toast.dart';
import 'package:invoice_producer/core/extensions/color_extension.dart';
import 'package:invoice_producer/features/auth/controller/auth_controller.dart';
import 'package:invoice_producer/features/auth/controller/auth_notifier_controller.dart';
import 'package:invoice_producer/features/auth/widgets/company_image_upload.dart';
import 'package:invoice_producer/routes/route_manager.dart';
import 'package:invoice_producer/utils/constants/app_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:invoice_producer/utils/themes/styles_manager.dart';
import '../../../../../../commons/common_imports/apis_commons.dart';
import '../../../../../../models/auth_models/user_model.dart';
import '../../../../../../utils/constants/assets_manager.dart';
import '../../../../../../utils/constants/font_manager.dart';
import '../widget/edit_profile_image_upload.dart';

class EditProfileScreen extends ConsumerStatefulWidget {
  const EditProfileScreen({super.key});

  @override
  ConsumerState<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends ConsumerState<EditProfileScreen> {
  final nameController = TextEditingController();
  final zipCodeController = TextEditingController();
  final comRegistrationNoController = TextEditingController();
  final addressController = TextEditingController();
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
  late UserModel userModel;

  @override
  initState() {
    super.initState();
    userModel = ref.read(authNotifierCtr).userModel!;
    initialization();
  }

  initialization() {
    //   userModel =  ref.watch(authNotifierCtr).userModel!;
    nameController.text = userModel.fullName;
    emailController.text = userModel.email;
    phoneController.text = userModel.phoneNo ?? '';
    addressController.text = userModel.address ?? '';
    selectedCity = userModel.city;
    selectedState = userModel.state;
    selectedCountry = userModel.country;
    zipCodeController.text = userModel.zipCode ?? '';
  }

  List<String> countries = [
    '',
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
    '',
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
    '',
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
    nameController.dispose();
    zipCodeController.dispose();
    comRegistrationNoController.dispose();
    addressController.dispose();
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

  update() async {
    if (formKey.currentState!.validate()) {
      if (selectedCity == '' || selectedState == '' || selectedCountry == '') {
        showSnackBar(context, 'fields can\'t be empty');
        return;
      }
      if (image == null && userModel.profileImage == '') {
        showSnackBar(context, 'upload image');
        return;
      }
      final newUser = userModel.copyWith(
        fullName: nameController.text.trim(),
        email: emailController.text.trim(),
        phoneNo: phoneController.text.trim(),
        address: addressController.text.trim(),
        city: selectedCity,
        state: selectedState,
        country: selectedCountry,
        zipCode: zipCodeController.text.trim(),
      );

      await ref.read(authControllerProvider.notifier).updateCurrentUserInfo(
          context: context,
          ref: ref,
          userModel: newUser,
          newImagePath: image?.path,
          oldImage: userModel.profileImage);

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
            'Edit profile',
            style: getLibreBaskervilleExtraBoldStyle(
                color: context.titleColor, fontSize: MyFonts.size16),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              EditProfileImageUploadWidget(
                onTap: selectImage,
                image: image,
                imgUrl: userModel.profileImage != '' ? userModel.profileImage! : personImg,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: AppConstants.padding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 20.h,
                    ),
                    Text(
                      'Update your profile information',
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
                            controller: nameController,
                            hintText: '',
                            label: 'Full Name',
                            validatorFn: uNameValidator,
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
                            controller: addressController,
                            hintText: '',
                            label: 'Address',
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
                            controller: zipCodeController,
                            hintText: '',
                            label: 'Zip Code',
                            inputType: TextInputType.number,
                            validatorFn: sectionValidator,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: AppConstants.padding),
                child: CustomButton(
                  isLoading: ref.watch(authControllerProvider),
                  onPressed: update,
                  buttonText: 'Update info',
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
