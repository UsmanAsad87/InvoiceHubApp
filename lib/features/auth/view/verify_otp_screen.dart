import 'dart:async';

import 'package:invoice_producer/commons/common_widgets/custom_button.dart';
import 'package:invoice_producer/routes/route_manager.dart';
import 'package:invoice_producer/utils/constants/app_constants.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../commons/common_imports/common_libs.dart';
import '../../../utils/constants/assets_manager.dart';

class VerifyOtpScreen extends StatefulWidget {
  const VerifyOtpScreen({super.key});

  @override
  State<VerifyOtpScreen> createState() => _VerifyOtpScreenState();
}

class _VerifyOtpScreenState extends State<VerifyOtpScreen> {
  final otpCtr = TextEditingController();
  final formKey = GlobalKey<FormState>();
  int seconds = 90;
  Timer? timer;
  Color textColor = MyColors.lightThemeColor;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    otpCtr.dispose();
    timer?.cancel();
    super.dispose();
  }

  String formatTime(int time) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;

    String minutesStr = (minutes < 10) ? '0$minutes' : '$minutes';
    String secondsStr =
        (remainingSeconds < 10) ? '0$remainingSeconds' : '$remainingSeconds';

    return '$minutesStr:$secondsStr';
  }

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    timer = Timer.periodic(oneSec, (Timer timer) {
      setState(() {
        if (seconds > 0) {
          seconds--;
          if (seconds <= 10) {
            textColor = context.errorColor;
          }
        } else {
          textColor = context.greenColor;
          timer.cancel();
        }
      });
    });
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
                        width: 18.w, height: 18.h, color: context.titleColor),
                  ),
                  SizedBox(
                    height: 40.h,
                  ),
                  Text(
                    'OTP Verification',
                    style: getLibreBaskervilleExtraBoldStyle(
                        color: context.titleColor, fontSize: MyFonts.size22),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(
                      'We just sent you an SMS with 4-digit code. Looks like very soon you will be logged in!',
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
                        Text(
                          'Enter the code into field below',
                          style: getRegularStyle(
                              fontSize: MyFonts.size14,
                              color: context.titleColor),
                        ),
                        SizedBox(height: 10.h,),
                        OtpTextField(
                          numberOfFields: 4,
                          borderColor: context.greenColor,
                          focusedBorderColor: context.greenColor,
                          enabledBorderColor: context.bodyTextColor.withOpacity(0.7),
                          styles: [
                            getRegularStyle(
                                fontSize: MyFonts.size16,
                                color: context.titleColor),
                            getRegularStyle(
                                fontSize: MyFonts.size16,
                                color: context.titleColor),
                            getRegularStyle(
                                fontSize: MyFonts.size16,
                                color: context.titleColor),
                            getRegularStyle(
                                fontSize: MyFonts.size16,
                                color: context.titleColor),
                          ],
                          showFieldAsBox: true,
                          borderWidth: 1.h,
                          fieldWidth: 50.w,
                          margin: EdgeInsets.only(left: 22.w),
                          onCodeChanged: (String code) {},
                          onSubmit: (String verificationCode) {},
                        ),
                        SizedBox(height: 10.h,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Resend code in ',
                              style: getRegularStyle(
                                  fontSize: MyFonts.size14,
                                  color: context.titleColor),
                            ),
                            Text(
                              formatTime(seconds),
                              style: getRegularStyle(
                                  fontSize: MyFonts.size14, color: textColor),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 25.h,
                  ),
                  CustomButton(
                    onPressed: () {
                      Navigator.pushNamed(context, AppRoutes.resetPasswordScreen);
                    },
                    buttonText: 'Verify',
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
