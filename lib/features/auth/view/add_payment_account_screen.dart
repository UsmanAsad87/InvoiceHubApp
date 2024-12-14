import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:invoice_producer/commons/common_functions/validator.dart';
import 'package:invoice_producer/commons/common_widgets/custom_text_fields.dart';
import 'package:invoice_producer/commons/common_widgets/custom_button.dart';
import 'package:invoice_producer/commons/common_widgets/show_toast.dart';
import 'package:invoice_producer/core/enums/account_type.dart';
import 'package:invoice_producer/core/extensions/color_extension.dart';
import 'package:invoice_producer/features/user/profile/Profile_Extended/payment_settings/controller/payment_controller.dart';
import 'package:invoice_producer/models/payment_account_model/payment_account_model.dart';
import 'package:invoice_producer/routes/route_manager.dart';
import 'package:invoice_producer/utils/constants/app_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:invoice_producer/utils/themes/styles_manager.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../commons/common_imports/apis_commons.dart';
import '../../../utils/constants/assets_manager.dart';
import '../../../utils/constants/font_manager.dart';
import 'package:uuid/uuid.dart';
import '../controller/auth_notifier_controller.dart';

class AddPaymentAccountScreen extends ConsumerStatefulWidget {
  bool? skip;
  PaymentAccountModel? paymentAccount;

  AddPaymentAccountScreen({super.key, this.skip, this.paymentAccount});

  @override
  ConsumerState<AddPaymentAccountScreen> createState() =>
      _AddPaymentAccountScreenState();
}

class _AddPaymentAccountScreenState extends ConsumerState<AddPaymentAccountScreen> {
  late final skip;
  final accountHolderNameController = TextEditingController();
  final cardNoController = TextEditingController();
  final expireDateController = TextEditingController();
  final bankNameController = TextEditingController();
  // final accountNameController = TextEditingController();
  final accountNoController = TextEditingController();
  // final branchNameController = TextEditingController();
  final sortCodeController = TextEditingController();
  final branchAddressController = TextEditingController();
  final emailController = TextEditingController();
  final cvvController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  var checkbox = false;
  int selectedMode = 2;
  AccountTypeEnum selectedType = AccountTypeEnum.stripe;
  PaymentAccountModel? oldPaymentAcc;



  final String clientId = 'ca_PUnpu5iIUzQZ1kp29F7safasfasfasfasfas';
  final String redirectUri = 'https://invoiceproducer.page.link/29hsdsdsdQ';
  final String responseType = 'code';
  final String scope = 'read_write'; // Adjust scopes as per your requirements

  String getAuthorizationUrl() {
    return 'https://connect.stripe.com/oauth/authorize?response_type=$responseType&client_id=$clientId&scope=$scope&redirect_uri=$redirectUri';
  }

  void launchAuthorizationUrl() async {
    final url = getAuthorizationUrl();
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }


  List<String> paymentModes = [
    AppAssets.bankIcon,
    // AppAssets.masterIcon,
    AppAssets.paypalIcon,
    // AppAssets.visaIcon,
    AppAssets.stripeIcon,
  ];

  @override
  void initState() {
    super.initState();
    skip = widget.skip ?? true;
    if (widget.paymentAccount != null) {
      oldPaymentAcc = widget.paymentAccount;
      final user = ref.read(authNotifierCtr).userModel;
      if (user!.defaultCard == oldPaymentAcc!.paymentId) {
        checkbox = true;
      }
      accountHolderNameController.text = oldPaymentAcc!.holderName;
      cardNoController.text = oldPaymentAcc!.cardNo;
      expireDateController.text = oldPaymentAcc!.expireDate;
      bankNameController.text = oldPaymentAcc!.bankName;
      accountNoController.text = oldPaymentAcc!.accountNo;
      accountNoController.text = oldPaymentAcc!.accountName;
      // branchNameController.text = oldPaymentAcc!.branchName;
      sortCodeController.text = oldPaymentAcc!.sortCode;
      branchAddressController.text = oldPaymentAcc!.branchAddress;
      emailController.text = oldPaymentAcc!.email;
      cvvController.text = oldPaymentAcc!.cvv;
      selectedMode = getIndex(oldPaymentAcc!.accountType);
      selectedType = oldPaymentAcc!.accountType;
    }
  }

  @override
  void dispose() {
    accountHolderNameController.dispose();
    cardNoController.dispose();
    expireDateController.dispose();
    cvvController.dispose();
    super.dispose();
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
            'Add payment account ',
            style: getLibreBaskervilleExtraBoldStyle(
                color: context.titleColor, fontSize: MyFonts.size16),
          ),
          centerTitle: true,
          actions: [
            if (skip)
              TextButton(
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(
                        context, AppRoutes.mainMenuScreen, (route) => false,);
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
              Container(
                height: 120.h,
                padding: EdgeInsets.only(bottom: 18.w),
                width: double.infinity,
                decoration: BoxDecoration(
                    color: context.greenColor,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20.r),
                        bottomRight: Radius.circular(20.r))),
                child: Container(
                    height: double.infinity,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: context.whiteColor,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(20.r),
                            bottomRight: Radius.circular(20.r))),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 50.h,
                          child: ListView.builder(
                              itemCount: paymentModes.length,
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectedMode = index;
                                      selectedType = getSelectedType(index);
                                    });
                                  },
                                  child: Container(
                                    width: 50.h,
                                    height: 50.h,
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 5.w),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: selectedMode == index
                                            ? Border.all(
                                                color: context.greenColor,
                                                width: 2.0)
                                            : null,
                                        image: DecorationImage(
                                            image:
                                                AssetImage(paymentModes[index]),
                                            fit: BoxFit.contain),
                                        borderRadius:
                                            BorderRadius.circular(8.r)),
                                  ),
                                );
                              }),
                        )
                      ],
                    )),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: AppConstants.padding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 30.h,
                    ),
                    Form(
                      key: formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CustomTextField(
                            controller: accountHolderNameController,
                            hintText: '',
                            label: 'Account holder name',
                            validatorFn: uNameValidator,
                          ),
                          if (selectedMode == 0)
                            CustomTextField(
                              controller: emailController,
                              hintText: '',
                              label: 'Email',
                              validatorFn: bankValidator,
                            ),
                          if (selectedMode == 0)
                            CustomTextField(
                              controller: bankNameController,
                              hintText: '',
                              label: 'Bank name',
                              validatorFn: bankValidator,
                            ),
                          // if (selectedMode == 0)
                          //   CustomTextField(
                          //     controller: accountNameController,
                          //     hintText: '',
                          //     label: 'Account Name',
                          //     validatorFn: bankValidator,
                          //   ),
                          if (selectedMode == 0)
                            CustomTextField(
                              controller: accountNoController,
                              hintText: '',
                              label: 'Account number',
                              validatorFn: bankValidator,
                            ),
                          if (selectedMode == 0)
                            CustomTextField(
                              controller: sortCodeController,
                              hintText: '',
                              label: 'Sort Code',
                              validatorFn: bankValidator,
                            ),
                          // CustomTextField(
                          //     controller: branchNameController,
                          //     hintText: '',
                          //     label: 'branch name',
                          //     validatorFn: bankValidator,
                          //   ),
                          // if (selectedMode == 0)
                          //   CustomTextField(
                          //     controller: branchAddressController,
                          //     hintText: '',
                          //     label: 'branch address',
                          //     validatorFn: bankValidator,
                          //   ),
                          if (selectedMode != 0)
                          CustomTextField(
                            controller: cardNoController,
                            hintText: '',
                            label: 'Card number',
                            validatorFn: sectionValidator,
                          ),
                          if (selectedMode != 0)
                          Row(
                            children: [
                              Expanded(
                                child: CustomTextField(
                                  controller: expireDateController,
                                  hintText: '',
                                  label: 'Expire Date',
                                  validatorFn: sectionValidator,
                                ),
                              ),
                              SizedBox(
                                width: 15.w,
                              ),
                              Expanded(
                                child: CustomTextField(
                                  controller: cvvController,
                                  hintText: '',
                                  label: 'CVV',
                                  validatorFn: sectionValidator,
                                ),
                              ),
                            ],
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
                  Text('Set as default payment account',
                      style: getRegularStyle(
                          fontSize: MyFonts.size12, color: context.titleColor)),
                ],
              ),
              Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: AppConstants.padding),
                  child: _addAccountButton()),
            ],
          ),
        ),
      ),
    );
  }

  _addAccountButton() {
    return CustomButton(
      isLoading: ref.watch(paymentAccountControllerProvider),
      onPressed: oldPaymentAcc == null ? addPayment : update,
      buttonText: skip ? 'Save & continue' :
      oldPaymentAcc == null ? 'Add account' : 'Update account',
      buttonHeight: 45.h,
    );
  }

  addPayment() async {
    if (selectedType != AccountTypeEnum.bank) {
      // showSnackBar(context, 'Only bank account supported.');
      if(selectedType == AccountTypeEnum.stripe){
        launchAuthorizationUrl();
      }
      return;

    }
    if (formKey.currentState!.validate()) {
      PaymentAccountModel payment = PaymentAccountModel(
          paymentId: const Uuid().v4(),
          holderName: accountHolderNameController.text,
          accountType: selectedType,
          cardNo: cardNoController.text,
          expireDate: expireDateController.text,
          isDefault: checkbox,
          cvv: cvvController.text,
          bankName: bankNameController.text,
          accountName: accountHolderNameController.text,
          accountNo: accountNoController.text,
          sortCode: sortCodeController.text,
          // branchName: branchNameController.text,
          branchAddress: branchAddressController.text,
          email: emailController.text);
      // final user = ref.read(authNotifierCtr).userModel;
      await ref
          .read(paymentAccountControllerProvider.notifier)
          .addPaymentAccount(
          context: context,
          paymentModel: payment,
          isDefault: checkbox,
          // user: user!,
          isSkip: skip
      );
    }
  }

  update() async {
    if (formKey.currentState!.validate()) {
      PaymentAccountModel payment = PaymentAccountModel(
          paymentId: oldPaymentAcc!.paymentId,
          holderName: accountHolderNameController.text,
          accountType: selectedType,
          cardNo: cardNoController.text,
          expireDate: expireDateController.text,
          isDefault: checkbox,
          cvv: cvvController.text,
          bankName: bankNameController.text,
          accountName: accountHolderNameController.text,
          accountNo: accountNoController.text,
          sortCode: sortCodeController.text,
          // branchName: branchNameController.text,
          branchAddress: branchAddressController.text,
          email: emailController.text);
      final user = ref.read(authNotifierCtr).userModel;
      await ref
          .read(paymentAccountControllerProvider.notifier)
          .updatePaymentAccount(
          context: context,
          paymentModel: payment,
          isDefault: checkbox,
          user: user!);
    }
  }


  int getIndex(accountType) {
    switch (accountType) {
      case AccountTypeEnum.bank:
        return 0;
      case AccountTypeEnum.paypal:
        return 1;
      case AccountTypeEnum.stripe:
        return 2;
      case AccountTypeEnum.masterCard:
        return 3;
      case AccountTypeEnum.visa:
        return 4;
      default:
        return 5;
    }
  }
  AccountTypeEnum getSelectedType(index) {
    switch (index) {
      case 0:
        return AccountTypeEnum.bank;
      case 1:
        return AccountTypeEnum.paypal;
      case 2:
        return AccountTypeEnum.stripe;
      case 3:
        return AccountTypeEnum.visa;
      case 4:
        return AccountTypeEnum.masterCard;
      default:
        return AccountTypeEnum.paypal;
    }
  }
}
