import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../commons/common_imports/common_libs.dart';
import '../../../../commons/common_widgets/custom_button.dart';
import '../../../auth/controller/auth_controller.dart';

class DeleteAccountDialogBox extends StatelessWidget {
  const DeleteAccountDialogBox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0.r)), //this right here
      child: SizedBox(
        width: 340.w,
        height: 220.h,
        // color: MyColors.white,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 10.h,
              ),
              Icon(
                Icons.info_outline,
                size: 40.sp,
                color: MyColors.red,
              ),
              SizedBox(
                height: 10.h,
              ),
              Text(
                'Do You Want delete the Account?',
                style: getSemiBoldStyle(fontSize: 14.spMin, color: MyColors.darkButtonTextColor),
              ),
              SizedBox(
                height: 5.h,
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(
                  'Your account will be deleted and you cannot recover the account.',
                  style: getRegularStyle(
                      fontSize: 12.spMin, color: MyColors.redTagColor),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    buttonText: 'No',
                    buttonWidth: 50.w,
                    buttonHeight: 30,
                    fontSize: 14.spMin,
                  ),
                  SizedBox(width: 20.w,),
                  Consumer(
                    builder: (context,ref,child) {
                      return CustomButton(
                        onPressed: () async {
                          final authCtr = ref.read(authControllerProvider.notifier);
                          await authCtr.delete(context: context);
                        },
                        buttonText: 'Yes',
                        isLoading: ref.watch(authControllerProvider),
                        buttonWidth: 50.w,
                        buttonHeight: 30,
                        fontSize: 14.spMin,
                        backColor: MyColors.red,
                      );
                    }
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
