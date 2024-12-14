import 'dart:io';
import 'package:invoice_producer/commons/common_functions/upload_image_to_firebase.dart';
import 'package:invoice_producer/commons/common_widgets/show_toast.dart';
import 'package:invoice_producer/core/constants/firebase_constants.dart';
import 'package:invoice_producer/features/user/profile/Profile_Extended/payment_settings/api/payment_api_provider.dart';
import 'package:invoice_producer/models/auth_models/user_model.dart';
import '../../../../../../commons/common_imports/apis_commons.dart';
import '../../../../../../commons/common_imports/common_libs.dart';
import '../../../../../../models/payment_account_model/payment_account_model.dart';
import '../../../../../../routes/route_manager.dart';
import '../../../../../auth/data/auth_apis/auth_apis.dart';
import '../../../../../auth/data/auth_apis/database_apis.dart';

final paymentAccountControllerProvider =
StateNotifierProvider<PaymentAccountController, bool>((ref) {
  return PaymentAccountController(
    authApis: ref.watch(authApisProvider),
    databaseApis: ref.watch(paymentDataBaseApiProvider),
    userdatabaseApis: ref.watch(databaseApisProvider),
  );
});

final getAllPaymentAccountsProvider =
StreamProvider.family((ref, BuildContext context) {
  final paymentCtr = ref.watch(paymentAccountControllerProvider.notifier);
  return paymentCtr.getAllPaymentAccounts(context: context);
});

class PaymentAccountController extends StateNotifier<bool> {
  final AuthApis _authApis;
  final PaymentDatabaseApi _databaseApis;
  final DatabaseApis _userdatabaseApis;

  PaymentAccountController({
    required AuthApis authApis,
    required PaymentDatabaseApi databaseApis,
    required DatabaseApis userdatabaseApis,
  })  : _authApis = authApis,
        _databaseApis = databaseApis,
        _userdatabaseApis = userdatabaseApis,
  // _companyNotifier = companyNotifier,
        super(false);

  Future<void> addPaymentAccount(
      {required BuildContext context,
      required PaymentAccountModel paymentModel,
      required bool isDefault,
      // required UserModel user,
        required bool isSkip
      }) async {
    state = true;
    final userId = _authApis.getCurrentUser();
    final result = await _databaseApis.addPaymentAccount(
        userId: userId!.uid, payment: paymentModel);
    final result2 = await _userdatabaseApis.getCurrentUserInfo(uid: userId.uid);
    final user = UserModel.fromMap(result2.data()  as Map<String, dynamic>);
    result.fold((l) {
      state = false;
      showSnackBar(context, l.message);
    }, (r) async {
      state = false;
      if (isDefault) {
        final updateUser =
        user.copyWith(defaultCard: paymentModel.paymentId);
        _userdatabaseApis.updateFirestoreCurrentUserInfo(userModel: updateUser);
      }
      showSnackBar(context, 'payment account added successfully');
      if (isSkip) {
        Navigator.pushNamedAndRemoveUntil(
          context, AppRoutes.mainMenuScreen, (route) => false,);
      } else {
        Navigator.of(context).pop();
      }
    });
  }

  Stream<List<PaymentAccountModel>> getAllPaymentAccounts({
    required BuildContext context,
  }) {
    try {
      final user = _authApis.getCurrentUser();
      Stream<List<PaymentAccountModel>> paymentAccounts =
      _databaseApis.getAllPaymentAccounts(userId: user!.uid);
      return paymentAccounts;
    } catch (error) {
      showSnackBar(context, 'Error getting companies: $error');
      return Stream.value([]);
      // Handle the error as needed
    }
  }

  Future<void> updatePaymentAccount(
      {
    required BuildContext context,
    required PaymentAccountModel paymentModel,
    required bool isDefault,
    required UserModel user,
  }) async {
    state = true;
    final userId = _authApis.getCurrentUser();

    final result = await _databaseApis.updatePaymentAccount(
        userId: userId!.uid, payment: paymentModel);
    result.fold((l) {
      state = false;
      showSnackBar(context, l.message);
    }, (r) {
      state = false;
      if (isDefault) {
        final updateUser =
        user.copyWith(defaultCard : paymentModel.paymentId);
        _userdatabaseApis.updateFirestoreCurrentUserInfo(userModel: updateUser);
      }
      showSnackBar(context, 'company update successfully');
      Navigator.of(context).pop();
    });
  }

  Future<void> deletePaymentAccount({required BuildContext context, required String paymentId}) async {
    try {
      final userId = _authApis.getCurrentUser();
      await _databaseApis.deletePaymentAccount(userId: userId!.uid,paymentId: paymentId);
      showSnackBar(context, 'Payment account deleted successfully');
    } catch (e) {
      showSnackBar(context, 'something went wrong');
    }
  }
}
