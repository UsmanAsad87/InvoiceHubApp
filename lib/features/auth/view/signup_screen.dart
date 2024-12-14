import 'package:invoice_producer/commons/common_functions/validator.dart';
import 'package:invoice_producer/commons/common_imports/apis_commons.dart';
import 'package:invoice_producer/commons/common_widgets/custom_text_fields.dart';
import 'package:invoice_producer/commons/common_widgets/custom_button.dart';
import 'package:invoice_producer/commons/common_widgets/show_toast.dart';
import 'package:invoice_producer/features/auth/widgets/signupbuttons.dart';
import 'package:invoice_producer/routes/route_manager.dart';
import 'package:invoice_producer/utils/constants/app_constants.dart';
import 'package:flutter/cupertino.dart';
import '../../../commons/common_imports/common_libs.dart';
import '../controller/auth_controller.dart';
import '../widgets/Info_widget.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  const SignUpScreen({super.key});

  @override
  ConsumerState<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  final nameController = TextEditingController();
  final passwordConfirmController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  var passObscure = true;
  var passConObscure = true;
  var checkbox = false;

  @override
  void dispose() {
    nameController.dispose();
    passwordConfirmController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  signUp() async {
    // Navigator.pushNamed(context, AppRoutes.createAuthCompanyScreen);
    if (!checkbox) {
      showSnackBar(context, 'To signup must agree with Terms and Conditions.');
      return;
    }
    if (passwordController.text != passwordConfirmController.text) {
      showSnackBar(context, 'Password and Re-type Password did not match.');
    }
    if (formKey.currentState!.validate()) {
      await ref
          .read(authControllerProvider.notifier)
          .registerWithEmailAndPassword(
            email: emailController.text.trim(),
            password: passwordController.text.trim(),
            context: context,
            fName: nameController.text.trim(),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.all(AppConstants.padding),
              child: Column(
                children: [
                  SizedBox(
                    height: 20.h,
                  ),
                  Text(
                    'Get started',
                    style: getLibreBaskervilleExtraBoldStyle(
                        color: context.titleColor, fontSize: MyFonts.size22),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text('You will get 3 Days free trail after signup',
                      style: getRegularStyle(
                          color: context.bodyTextColor,
                          fontSize: MyFonts.size14)),
                  SizedBox(
                    height: 30.h,
                  ),
                  Form(
                    key: formKey,
                    child: Column(
                      children: [
                        CustomTextField(
                          controller: nameController,
                          hintText: 'Enter Full Name',
                          label: 'Full Name',
                          validatorFn: uNameValidator,
                        ),
                        CustomTextField(
                          controller: emailController,
                          hintText: 'Enter Email',
                          label: 'Email Address',
                          validatorFn: emailValidator,
                        ),
                        CustomTextField(
                          controller: passwordController,
                          hintText: 'Enter Password',
                          label: 'Password',
                          validatorFn: passValidator,
                          obscure: passObscure,
                          tailingIcon: passObscure == false
                              ? InkWell(
                                  onTap: () {
                                    setState(() {
                                      passObscure = !passObscure;
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
                                      passObscure = !passObscure;
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
                          controller: passwordConfirmController,
                          hintText: 'Confirm Password',
                          label: 'Re-type Password',
                          validatorFn: passValidator,
                          obscure: passConObscure,
                          tailingIcon: passConObscure == false
                              ? InkWell(
                                  onTap: () {
                                    setState(() {
                                      passConObscure = !passConObscure;
                                    });
                                  },
                                  child: Icon(
                                    CupertinoIcons.eye,
                                    color: context.bodyTextColor,
                                    size: 20.h,
                                  ))
                              : InkWell(
                                  onTap: () {
                                    setState(() {
                                      passConObscure = !passConObscure;
                                    });
                                  },
                                  child: Icon(
                                    CupertinoIcons.eye_slash,
                                    color: context.bodyTextColor,
                                    size: 20.h,
                                  )),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
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
                      Row(
                        children: [
                          Text('I agree with the ',
                              style: getRegularStyle(
                                  fontSize: MyFonts.size12,
                                  color: context.titleColor)),
                          Text('Terms and Conditions',
                              style: getRegularStyle(
                                  fontSize: MyFonts.size12,
                                  color: context.greenColor)),
                        ],
                      ),
                    ],
                  ),
                  CustomButton(
                    isLoading: ref.watch(authControllerProvider),
                    onPressed: signUp,
                    buttonText: 'Register',
                    buttonHeight: 45.h,
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  // const InfoWidget(),
                  SizedBox(
                    height: 25.h,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 1.h,
                          color: context.titleColor,
                        ),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      Text(
                        "Or Login With",
                        style: getRegularStyle(
                            color: context.titleColor,
                            fontSize: MyFonts.size14),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      Expanded(
                        child: Container(
                          height: 1.h,
                          color: context.titleColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  SignupButtons(
                    onAppleTap: (){},
                    onGoogleTap: (){
                      ref.read(authControllerProvider.notifier).signInWithGoogle(context: context, ref: ref);
                    },
                  ),
                  SizedBox(
                    height: 25.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Have an account? ",
                        style: getRegularStyle(
                            color: context.titleColor,
                            fontSize: MyFonts.size14),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, AppRoutes.signInScreen);
                        },
                        child: Text(
                          'Login',
                          style: getRegularStyle(
                              color: context.greenColor,
                              fontSize: MyFonts.size14),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
