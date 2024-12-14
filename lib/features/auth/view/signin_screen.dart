import 'package:invoice_producer/commons/common_functions/validator.dart';
import 'package:invoice_producer/commons/common_imports/apis_commons.dart';
import 'package:invoice_producer/commons/common_widgets/custom_text_fields.dart';
import 'package:invoice_producer/commons/common_widgets/custom_button.dart';
import 'package:invoice_producer/features/auth/widgets/signupbuttons.dart';
import 'package:invoice_producer/routes/route_manager.dart';
import 'package:invoice_producer/utils/constants/app_constants.dart';
import 'package:flutter/cupertino.dart';
import '../../../commons/common_imports/common_libs.dart';
import '../controller/auth_controller.dart';

class SignInScreen extends ConsumerStatefulWidget {
  const SignInScreen({super.key});

  @override
  ConsumerState<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends ConsumerState<SignInScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  var passObscure = true;
  var checkbox = false;

  // bool isGoogleLoading = false;
  bool isAppleLoading = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  login() async {
   if (formKey.currentState!.validate()) {
      await ref.read(authControllerProvider.notifier).
      loginWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
          rememberMe: checkbox,
          context: context,
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
                    'Welcome back',
                    style: getLibreBaskervilleExtraBoldStyle(
                        color: context.titleColor, fontSize: MyFonts.size22),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text('Enter your email and password to continue',
                      style: getRegularStyle(
                          color: context.bodyTextColor,
                          fontSize: MyFonts.size14)),
                  SizedBox(
                    height: 50.h,
                  ),
                  Form(
                    key: formKey,
                    child: Column(
                      children: [
                        CustomTextField(
                          controller: emailController,
                          hintText: 'Enter Email',
                          label: 'Email',
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
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Checkbox(
                            value: checkbox,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6.r),
                            ),
                            fillColor: MaterialStateColor.resolveWith((states) => checkbox?context.greenColor:context.whiteColor),
                            checkColor: context.whiteColor,
                            onChanged: (bool? value) {
                              setState(() {
                                checkbox = value!;
                              });
                            },
                          ),
                          Text(
                              'Remember Me',
                              style: getRegularStyle(
                                  fontSize: MyFonts.size12, color: context.titleColor)),
                        ],
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.pushNamed(
                                context, AppRoutes.forgetPasswordScreen);
                          },
                          child: Text(
                            'Forget password?',
                            style: getMediumStyle(
                                color: context.titleColor,
                                fontSize: MyFonts.size12),
                          )),
                    ],
                  ),
                  CustomButton(
                      isLoading: ref.watch(authControllerProvider),
                      onPressed: login,
                      buttonText: 'login'),
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
                    onGoogleTap: ()async{
                      await ref.read(authControllerProvider.notifier).signInWithGoogle(context: context, ref: ref);
                    },
                  ),
                  SizedBox(
                    height: 25.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account? ",
                        style: getRegularStyle(
                            color: context.titleColor,
                            fontSize: MyFonts.size14),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, AppRoutes.signUpScreen);
                        },
                        child: Text(
                          'Register',
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
