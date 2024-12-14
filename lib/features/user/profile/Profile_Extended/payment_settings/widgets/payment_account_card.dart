import 'package:invoice_producer/commons/common_imports/common_libs.dart';
import 'package:invoice_producer/models/payment_account_model/payment_account_model.dart';

import '../../../../../../core/enums/account_type.dart';
import '../../../../../../utils/constants/assets_manager.dart';

class PaymentAccountCard extends StatelessWidget {
  PaymentAccountModel paymentAcc;
  final onSelect;
  Decoration? decoration;

  PaymentAccountCard(
      {Key? key, required this.paymentAcc, required this.onSelect,this.decoration})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 88.h,
          margin: EdgeInsets.only(bottom: 10.h),
          padding: EdgeInsets.all(8.h),
          decoration: decoration ?? BoxDecoration(
              color: context.whiteColor,
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(color: context.containerColor, width: 1.w)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 76.w,
                height: 76.h,
                padding: EdgeInsets.all(8.h),
                decoration: BoxDecoration(
                    color: MyColors.payPalColor,
                    borderRadius: BorderRadius.circular(8.r),
                    border:
                        Border.all(color: context.containerColor, width: 1.w)),
                child: Image.asset(
                  getIconAssetPath(paymentAcc.accountType),
                  //color: MyColors.payPalColor,
                ),
              ),
              SizedBox(
                width: 10.w,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      paymentAcc.holderName,
                      style: getSemiBoldStyle(
                          fontSize: MyFonts.size14, color: context.titleColor),
                    ),
                    Text(
                      paymentAcc.accountType.type,
                      style: getRegularStyle(
                          fontSize: MyFonts.size14, color: context.titleColor),
                    ),
                  ],
                ),
              ),
              PopupMenuButton<String>(
                onSelected: onSelect,
                //     (String value) {
                //   print(value);
                //   update();
                // },
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
                              color: context.titleColor,
                              fontSize: MyFonts.size14),
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
                              color: context.titleColor,
                              fontSize: MyFonts.size14),
                        ),
                      ],
                    ),
                  ),
                ],
                child: Container(
                  color: context.scaffoldBackgroundColor,
                  padding:
                      EdgeInsets.symmetric(horizontal: 0.w, vertical: 10.h),
                  child: Image.asset(AppAssets.moreVertIcon,
                      width: 24.w, height: 24.h, color: context.titleColor),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  String getIconAssetPath(accountType) {
    switch (accountType) {
      case AccountTypeEnum.bank:
        return AppAssets.bank_Icon;
      case AccountTypeEnum.masterCard:
        return AppAssets.master_Icon;
      case AccountTypeEnum.visa:
        return AppAssets.visa_Icon;
      case AccountTypeEnum.stripe:
        return AppAssets.stripe_Icon;
      case AccountTypeEnum.paypal:
        return AppAssets.paypal_Icon;
      default:
        return AppAssets.paypal_Icon;
    }
  }

}
