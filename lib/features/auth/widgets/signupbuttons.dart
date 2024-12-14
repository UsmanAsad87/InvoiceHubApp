import 'package:invoice_producer/commons/common_imports/apis_commons.dart';
import 'package:invoice_producer/commons/common_imports/common_libs.dart';
import 'package:invoice_producer/features/auth/controller/auth_controller.dart';
import 'package:invoice_producer/features/auth/widgets/another_auth_button.dart';
import 'package:invoice_producer/utils/constants/assets_manager.dart';

class SignupButtons extends StatelessWidget {
  final VoidCallback onGoogleTap;
  final VoidCallback onAppleTap;
  const SignupButtons({Key? key, required this.onGoogleTap, required this.onAppleTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double gapWidth = MediaQuery.of(context).size.width * 0.05;
    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
               // Expanded(
               //     child: AnotherAuthButton(
               //         image: AppAssets.appleImage,
               //         text: "Apple",
               //         onTap: onAppleTap,
               //         bgColor: MyColors.linkedInColor,
               //     )),
               //  SizedBox(
               //    width: 20.w,
               //  ),
                Expanded(
                    child: AnotherAuthButton(
                      isLoading: ref.watch(authControllerProvider),
                        image: AppAssets.googleImage,
                        text: "Google",
                        onTap: onGoogleTap,
                        bgColor: MyColors.googleColor,
                    )),

              ],
            ),
            // SizedBox(height: 20.h,),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     Expanded(child: AnotherAuthButton(image: AppAssets.appleImage, text: "Apple", onTap: (){}, bgColor:MyColors.appleColor)),
            //     SizedBox(
            //       width: 20.w,
            //     ),
            //     Expanded(child: AnotherAuthButton(image: AppAssets.instagramImage, text: "Instagram", onTap: (){}, bgColor: MyColors.instagramColor)),
            //
            //   ],
            // ),
          ],
        );
      },
    );
  }
}
