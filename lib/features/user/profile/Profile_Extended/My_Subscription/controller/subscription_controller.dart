import 'package:in_app_purchase_platform_interface/src/types/purchase_details.dart';

import '../../../../../../commons/common_imports/apis_commons.dart';
import '../../../../../../commons/common_imports/common_libs.dart';
import '../../../../../../commons/common_widgets/show_toast.dart';
import '../../../../../../models/auth_models/user_model.dart';
import '../../../../../auth/data/auth_apis/auth_apis.dart';
import '../../../../../auth/data/auth_apis/database_apis.dart';
import '../../../../userController.dart';

final subscriptionControllerProvider =
    StateNotifierProvider<SubscriptionController, bool>((ref) {
  return SubscriptionController(
    authApis: ref.watch(authApisProvider),
    databaseApis: ref.watch(databaseApisProvider),
  );
});

class SubscriptionController extends StateNotifier<bool> {
  final AuthApis _authApis;
  final DatabaseApis _databaseApis;

  SubscriptionController(
      {required AuthApis authApis, required DatabaseApis databaseApis})
      : _authApis = authApis,
        _databaseApis = databaseApis,
        super(false);

  Future<void> updateCurrentUserInfo({
    required BuildContext context,
    required WidgetRef ref,
    required PurchaseDetails purchaseDetail,
  }) async {
    state = true;
    final userId = _authApis.getCurrentUser();
    final result1 = await _databaseApis.getCurrentUserInfo(uid: userId!.uid);
    UserModel userModel =
        UserModel.fromMap(result1.data() as Map<String, dynamic>);
    UserModel updatedUser;
    final now = DateTime.now();

    /// here we will check the subscription id of the purchase details
    if (purchaseDetail.productID == '1Month') {
      updatedUser = userModel.copyWith(
          subscriptionName: '1 month',
          subscriptionIsValid: true,
          subscriptionApproved: true,
          subscriptionId: purchaseDetail.productID,
          subscriptionAdded: now,
          subscriptionExpire: now.add(const Duration(days: 30)));
    } else if (purchaseDetail.productID == '3Month') {
      updatedUser = userModel.copyWith(
          subscriptionName: '3 months',
          subscriptionIsValid: true,
          subscriptionApproved: true,
          subscriptionId: purchaseDetail.productID,
          subscriptionAdded: now,
          subscriptionExpire: now.add(const Duration(days: 90)));
    } else {
      updatedUser = userModel.copyWith(
          subscriptionName: '1 year',
          subscriptionIsValid: true,
          subscriptionApproved: true,
          subscriptionId: purchaseDetail.productID,
          subscriptionAdded: now,
          subscriptionExpire: now.add(const Duration(days: 365)));
    }

    final result = await _databaseApis.updateFirestoreCurrentUserInfo(
        userModel: updatedUser);

    result.fold((l) {
      state = false;
      showSnackBar(context, l.message);
    }, (r) {
      state = false;
      UserController().refreshUserData(ref);
      showSnackBar(context, 'Profile Updated Successfully');
      Navigator.of(context).pop();
    });
  }
}
