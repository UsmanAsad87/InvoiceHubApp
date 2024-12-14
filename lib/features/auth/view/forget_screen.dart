import 'package:invoice_producer/commons/common_functions/validator.dart';
import 'package:invoice_producer/commons/common_widgets/custom_text_fields.dart';
import 'package:invoice_producer/commons/common_widgets/custom_button.dart';
import 'package:invoice_producer/routes/route_manager.dart';
import 'package:invoice_producer/utils/constants/app_constants.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../commons/common_imports/common_libs.dart';
import '../../../utils/constants/assets_manager.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  forget() async {
    if (formKey.currentState!.validate()) {
      Navigator.pushNamed(context, AppRoutes.verifyOtpScreen);
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Image.asset(AppAssets.backArrowIcon,
                        width: 18.w,
                        height: 18.h,
                        color: context.titleColor),
                  ),
                  SizedBox(
                    height: 40.h,
                  ),
                  Text(
                    'Forgot password?',
                    style: getLibreBaskervilleExtraBoldStyle(
                        color: context.titleColor, fontSize: MyFonts.size22),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text('Don’t worry! it happens, Please enter the address associated with your account.',
                      style: getRegularStyle(
                          color: context.bodyTextColor,
                          fontSize: MyFonts.size14)),
                  SizedBox(
                    height: 40.h,
                  ),
                  Form(
                    key: formKey,
                    child: Column(
                      children: [
                        CustomTextField(
                          controller: emailController,
                          hintText: '',
                          label: 'Email/Phone',
                          //validatorFn: emailValidator,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  CustomButton(onPressed: forget, buttonText: 'Send',buttonHeight: 48.h,),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
