import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:invoice_producer/features/user/profile/Profile_Extended/My_Subscription/controller/subscription_controller.dart';

import '../../../../../../commons/common_imports/common_libs.dart';

class IAPService {
  void listenToPurchaseUpdate(
      {required List<PurchaseDetails> purchaseDetailList,
      required WidgetRef ref,
      required BuildContext context}) {
    purchaseDetailList.forEach((PurchaseDetails purchaseDetails) async {
      if (purchaseDetails.status == PurchaseStatus.purchased ||
          purchaseDetails.status == PurchaseStatus.restored) {
        _handelSuccessfulPurchase(
          purchaseDetails: purchaseDetails,
          ref: ref,
          context: context,
        );
      }
      if (purchaseDetails.pendingCompletePurchase) {
        await InAppPurchase.instance.completePurchase(purchaseDetails);
      }
    });
  }

  void _handelSuccessfulPurchase({
    required PurchaseDetails purchaseDetails,
    required WidgetRef ref,
    required BuildContext context,
  }) {
    ref.read(subscriptionControllerProvider.notifier).updateCurrentUserInfo(
        context: context, ref: ref, purchaseDetail: purchaseDetails);
  }
}
