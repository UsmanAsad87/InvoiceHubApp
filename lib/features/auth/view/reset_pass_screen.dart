import 'package:invoice_producer/commons/common_functions/validator.dart';
import 'package:invoice_producer/commons/common_widgets/custom_text_fields.dart';
import 'package:invoice_producer/commons/common_widgets/custom_button.dart';
import 'package:invoice_producer/features/auth/widgets/reset_succsess_dialog.dart';
import 'package:invoice_producer/utils/constants/app_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../commons/common_imports/common_libs.dart';
import '../../../utils/constants/assets_manager.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final passwordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmNewPasswordController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  var passObscure = true;
  var newPassObscure = true;
  var confirmNewPassObscure = true;

  @override
  void dispose() {
    passwordController.dispose();
    newPasswordController.dispose();
    confirmNewPasswordController.dispose();
    super.dispose();
  }

  reset() async {
    // if (formKey.currentState!.validate()) {}
    //resetDone();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()=>FocusManager.instance.primaryFocus!.unfocus(),
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.all(AppConstants.padding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Image.asset(AppAssets.backArrowIcon,
                        width: 18.w, height: 18.h, color: context.titleColor),
                  ),
                  SizedBox(
                    height: 40.h,
                  ),
                  Text(
                    'Reset password',
                    style: getLibreBaskervilleExtraBoldStyle(
                        color: context.titleColor, fontSize: MyFonts.size22),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(
                      'Your password must be different from\npreviously used  password',
                      style: getRegularStyle(
                          color: context.bodyTextColor,
                          fontSize: MyFonts.size14)),
                  SizedBox(
                    height: 34.h,
                  ),
                  Form(
                    key: formKey,
                    child: Column(
                      children: [
                        // CustomTextField(
                        //   controller: passwordController,
                        //   hintText: 'Enter Current Password',
                        //   label: 'Current Password',
                        //   validatorFn: passValidator,
                        //   obscure: passObscure,
                        //   tailingIcon: passObscure == false
                        //       ? InkWell(
                        //           onTap: () {
                        //             setState(() {
                        //               passObscure = !passObscure;
                        //             });
                        //           },
                        //           child: Icon(
                        //             CupertinoIcons.eye,
                        //             color:
                        //                 Theme.of(context).colorScheme.secondary,
                        //             size: 20.h,
                        //           ))
                        //       : InkWell(
                        //           onTap: () {
                        //             setState(() {
                        //               passObscure = !passObscure;
                        //             });
                        //           },
                        //           child: Icon(
                        //             CupertinoIcons.eye_slash,
                        //             color:
                        //                 Theme.of(context).colorScheme.secondary,
                        //             size: 20.h,
                        //           )),
                        // ),
                        CustomTextField(
                          controller: newPasswordController,
                          hintText: 'Enter New Password',
                          label: 'New Password',
                          validatorFn: passValidator,
                          obscure: newPassObscure,
                          tailingIcon: newPassObscure == false
                              ? InkWell(
                                  onTap: () {
                                    setState(() {
                                      newPassObscure = !newPassObscure;
                                    });
                                  },
                                  child: Icon(
                                    CupertinoIcons.eye,
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                    size: 20.h,
                                  ))
                              : InkWell(
                                  onTap: () {
                                    setState(() {
                                      newPassObscure = !newPassObscure;
                                    });
                                  },
                                  child: Icon(
                                    CupertinoIcons.eye_slash,
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                    size: 20.h,
                                  )),
                        ),
                        CustomTextField(
                          controller: confirmNewPasswordController,
                          hintText: 'Enter Confirm Password',
                          label: 'Confirm Password',
                          validatorFn: passValidator,
                          obscure: confirmNewPassObscure,
                          tailingIcon: confirmNewPassObscure == false
                              ? InkWell(
                                  onTap: () {
                                    setState(() {
                                      confirmNewPassObscure =
                                          !confirmNewPassObscure;
                                    });
                                  },
                                  child: Icon(
                                    CupertinoIcons.eye,
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                    size: 20.h,
                                  ))
                              : InkWell(
                                  onTap: () {
                                    setState(() {
                                      confirmNewPassObscure =
                                          !confirmNewPassObscure;
                                    });
                                  },
                                  child: Icon(
                                    CupertinoIcons.eye_slash,
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                    size: 20.h,
                                  )),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  CustomButton(
                    onPressed: reset,
                    buttonText: 'Continue',
                    buttonHeight: 45.h,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Future<void> resetDone() async {
  //   return showDialog<void>(
  //     context: context,
  //     barrierDismissible: true,
  //     builder: (BuildContext context) {
  //       return const ResetSuccessDialog();
  //     },
  //   );
  // }
}


