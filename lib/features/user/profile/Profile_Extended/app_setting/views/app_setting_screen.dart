import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:invoice_producer/commons/common_functions/validator.dart';
import 'package:invoice_producer/commons/common_widgets/custom_button.dart';
import 'package:invoice_producer/commons/common_widgets/custom_text_fields.dart';
import 'package:invoice_producer/core/extensions/color_extension.dart';
import 'package:invoice_producer/utils/constants/app_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:invoice_producer/utils/themes/styles_manager.dart';
import '../../../../../../utils/constants/assets_manager.dart';
import '../../../../../../utils/constants/font_manager.dart';
import '../widget/switch_button.dart';

class AppSettingScreen extends StatefulWidget {
  const AppSettingScreen({super.key});

  @override
  State<AppSettingScreen> createState() => _AppSettingScreenState();
}

class _AppSettingScreenState extends State<AppSettingScreen> {
  bool isTwoStep = true;
  bool isLoginEmailNotify = true;
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
    return Scaffold(
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
          'App setting',
          style: getLibreBaskervilleExtraBoldStyle(
              color: context.titleColor, fontSize: MyFonts.size16),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: AppConstants.padding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SwitchButton(
                    onTap: () {
                      setState(() {
                        isTwoStep = !isTwoStep;
                      });
                    },
                    title: 'Two step verification',
                    value: isTwoStep,
                  ),
                  SwitchButton(
                      onTap: () {
                        setState(() {
                          isLoginEmailNotify = !isLoginEmailNotify;
                        });
                      },
                      title: 'Login email notification',
                      value: isLoginEmailNotify),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(
                    'Change password',
                    style: getSemiBoldStyle(
                        color: context.titleColor, fontSize: MyFonts.size16),
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
                          hintText: '',
                          label: 'Password',
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
                          hintText: '',
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
                    buttonText: 'Change',
                    buttonHeight: 45.h,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 50.h,
            ),
          ],
        ),
      ),
    );
  }
}
