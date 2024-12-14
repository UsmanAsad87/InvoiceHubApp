import 'package:invoice_producer/commons/common_functions/validator.dart';
import 'package:invoice_producer/commons/common_widgets/custom_button.dart';
import 'package:invoice_producer/routes/route_manager.dart';
import 'package:invoice_producer/utils/constants/app_constants.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../commons/common_imports/common_libs.dart';
import '../../../utils/constants/assets_manager.dart';
import '../widgets/custom_phone_field.dart';

class PhoneVerificationScreen extends StatefulWidget {
  const PhoneVerificationScreen({super.key});

  @override
  State<PhoneVerificationScreen> createState() => _PhoneVerificationScreenState();
}

class _PhoneVerificationScreenState extends State<PhoneVerificationScreen> {
  final phoneController = TextEditingController();

  final formKey = GlobalKey<FormState>();


  @override
  void dispose() {
    phoneController.dispose();
    super.dispose();
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
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Image.asset(
                            AppAssets.backArrowIcon,
                            width: 20.w,
                            height: 20.h,
                            color: context.greenColor
                        ),
                      ),
                      // SvgPicture.asset(
                      //   AppAssets.storeLogo,
                      //   height: 95.h,
                      //   width: 93.w,
                      // ),
                      SizedBox(
                        width: 20.w,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Text(
                    'Phone Verification',
                    style: getSemiBoldStyle(
                        color: context.greenColor,
                        fontSize: MyFonts.size24),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  Text(
                      'Welcome! Ozzie barber lounge \n Verify your phone!',
                      textAlign: TextAlign.center,
                      style: getRegularStyle(
                          color: context.greenColor,
                          fontSize: MyFonts.size14)),
                  SizedBox(
                    height: 34.h,
                  ),
                  Form(
                    key: formKey,
                    child: Column(
                      children: [
                        CustomPhoneField(
                          onChanged: (val){},
                          onFieldSubmitted: (val){},
                          labelText: 'Phone Number',
                          controller: phoneController,
                          hintText: 'Enter New Password',
                          validatorFn: passValidator,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  CustomButton(
                    onPressed: (){
                      Navigator.pushNamed(context, AppRoutes.verifyOtpScreen);
                    },
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

}


