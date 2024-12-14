import 'package:invoice_producer/commons/common_widgets/custom_button.dart';
import 'package:invoice_producer/features/user/main_menu/controller/main_menu_controller.dart';
import 'package:invoice_producer/utils/constants/app_constants.dart';
import 'package:invoice_producer/utils/constants/assets_manager.dart';

import '../../../../commons/common_imports/apis_commons.dart';
import '../../../../commons/common_imports/common_libs.dart';
import '../../../../routes/route_manager.dart';

class ScanQrcodeScreen extends StatelessWidget {
  const ScanQrcodeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body : Padding(
        padding:  EdgeInsets.all(AppConstants.padding),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  SizedBox(height: 30.h,),
                  Text(
                    'Scan QR Code',
                    style: getBoldStyle(
                        color: context.titleColor, fontSize: MyFonts.size18),
                  ),
                  Text(
                    'Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit ',
                    style: getRegularStyle(
                        color: context.titleColor.withOpacity(.9),
                        fontSize: MyFonts.size14),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              Image.asset(AppAssets.qrcodeImage,width: 280.w,height: 280.h,),
              Consumer(
                builder: (context,ref,child) {
                  return CustomButton(onPressed: (){
                    ref.read(mainMenuProvider).setIndex(0);
                    Navigator.pushNamedAndRemoveUntil(context, AppRoutes.mainMenuScreen, (route) => false);
                  }, buttonText: 'Back to Home');
                }
              ),
            ],
          ),
        ),
      ),
    );
  }
}
