import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:invoice_producer/commons/common_functions/padding.dart';
import 'package:invoice_producer/core/extensions/color_extension.dart';
import 'package:invoice_producer/features/user/profile/Profile_Extended/term_and_condition/widget/version_widget.dart';
import 'package:invoice_producer/utils/constants/app_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:invoice_producer/utils/themes/styles_manager.dart';
import '../../../../../../utils/constants/assets_manager.dart';
import '../../../../../../utils/constants/font_manager.dart';

class TermAndConditionScreen extends StatelessWidget {
  const TermAndConditionScreen({super.key});

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
          'Terms and conditions',
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
                children: [
                  const Version(),
                  padding8,
                  Row(
                    children: [
                      Text(
                        '01',
                        style: getSemiBoldStyle(
                            fontSize: MyFonts.size16,
                            color: context.greenColor),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      Text(
                        'Your agreement',
                        style: getSemiBoldStyle(
                            fontSize: MyFonts.size16,
                            color: context.titleColor),
                      ),
                    ],
                  ),
                  Text(
                    'There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don\'t look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isn\'t anything embarrassing hidden in the middle of text. All the Lorem Ipsum generators on the Internet tend to repeat predefined chunks as necessary, making this the first true generator on the Internet. It uses a dictionary of over 200 Latin words, combined with a handful of model sentence structures, to generate Lorem Ipsum which looks reasonable. The generated Lorem Ipsum is therefore always free from repetition, injected humour, or non-characteristic words etc.',
                    style: getMediumStyle(
                        fontSize: MyFonts.size14, color: context.bodyTextColor),
                  ),

                  padding8,
                  Row(
                    children: [
                      Text(
                        '02',
                        style: getSemiBoldStyle(
                            fontSize: MyFonts.size16,
                            color: context.greenColor),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      Text(
                        'Privacy',
                        style: getSemiBoldStyle(
                            fontSize: MyFonts.size16,
                            color: context.titleColor),
                      ),
                    ],
                  ),
                  Text(
                    'There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don\'t look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isn\'t anything embarrassing hidden in the middle of text. All the Lorem Ipsum generators on the Internet tend to repeat predefined chunks as necessary, making this the first true generator on the Internet. It uses a dictionary of over 200 Latin words, combined with a handful of model sentence structures, to generate Lorem Ipsum which looks reasonable. The generated Lorem Ipsum is therefore always free from repetition, injected humour, or non-characteristic words etc.',
                    style: getMediumStyle(
                        fontSize: MyFonts.size14, color: context.bodyTextColor),
                  ),
                  SizedBox(height: 50.h,),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
