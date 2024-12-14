import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:invoice_producer/features/user/invoice/invoiceExended/signature/controller/signature_controller.dart';
import 'package:invoice_producer/models/signature_model/signature_model.dart';

import '../../../../../../../commons/common_imports/common_libs.dart';
import '../../../../../../../commons/common_widgets/cached_retangular_network_image.dart';
import '../../../../../../../utils/constants/app_constants.dart';
import '../../../../../../../utils/constants/assets_manager.dart';

class SignatureContainer extends ConsumerWidget {
  final index;
  Function(int) onChange;
  SignatureModel signature;
  late final selectedSignatureIndex;

  SignatureContainer(
      {Key? key,
      required this.index,
      required this.onChange,
      required this.signature,
      required this.selectedSignatureIndex})
      : super(key: key);

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return Container(
      width: double.infinity,
      height: 98.h,
      margin: EdgeInsets.only(bottom: 10.h),
      padding: EdgeInsets.all(8.h),
      decoration: BoxDecoration(
          color: context.whiteColor,
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(
              color: selectedSignatureIndex == index
                  ? context.greenColor
                  : context.containerColor,
              width: 1.w)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Radio(
                  value: index,
                  activeColor: context.greenColor,
                  groupValue: selectedSignatureIndex,
                  onChanged: (value) {
                    if (value != null) {
                      onChange(value);
                    }
                  }),
             // Image.network(signature.image, width: 98,height: 80),
              CachedRectangularNetworkImageWidget(
                image: signature.image,
                width: 98,
                height: 80,
              ),
            ],
          ),
          SizedBox(width: 10.w),
          PopupMenuButton<String>(
            onSelected: (String value) {
              if (value == 'edit') {
                // Navigator.pushNamed(context, AppRoutes.addSignatureScreen,
                //     arguments: {
                //       'signatureModel': signature,
                //     });
              } else {
                ref.read(signatureControllerProvider.notifier)
                    .deleteSignature(
                        context: context, signatureId: signature.signatureId);
              }
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4.r),
            ),
            elevation: 2,
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              PopupMenuItem<String>(
                value: 'edit',
                height: 30.h,
                padding: EdgeInsets.only(left: 15.w, right: 30.w),
                child: Row(
                  children: [
                    Image.asset(AppAssets.editProductIcon,
                        width: 16.w, height: 16.h),
                    SizedBox(width: 8.w),
                    Text(
                      'Edit',
                      style: getMediumStyle(
                          color: context.titleColor, fontSize: MyFonts.size14),
                    ),
                  ],
                ),
              ),
              PopupMenuItem<String>(
                value: 'delete',
                height: 30.h,
                padding: EdgeInsets.only(left: 15.w, right: 40.w),
                child: Row(
                  children: [
                    Image.asset(AppAssets.deleteIcon,
                        width: 16.w, height: 16.h),
                    SizedBox(width: 8.w),
                    Text(
                      'Delete',
                      style: getMediumStyle(
                          color: context.titleColor, fontSize: MyFonts.size14),
                    ),
                  ],
                ),
              ),
            ],
            child: Container(
              color: context.scaffoldBackgroundColor,
              padding: EdgeInsets.symmetric(horizontal: 0.w, vertical: 10.h),
              child: Image.asset(AppAssets.moreVertIcon,
                  width: 24.w, height: 24.h, color: context.titleColor),
            ),
          ),
        ],
      ),
    );
  }
}
