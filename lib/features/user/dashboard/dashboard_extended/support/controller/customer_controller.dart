import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:invoice_producer/features/auth/data/auth_apis/auth_apis.dart';
import 'package:invoice_producer/models/support_model/support_model.dart';
import '../../../../../../commons/common_widgets/show_toast.dart';
import '../api/support_api_provider.dart';

final supportControllerProvider =
    StateNotifierProvider<SupportController, bool>((ref) {
  return SupportController(
    authApis: ref.watch(authApisProvider),
    databaseApis: ref.watch(supportDatabaseApiProvider),
  );
});

final getAllSupportMailsProvider =
    StreamProvider((ref) {
  final customerCtr = ref.watch(supportControllerProvider.notifier);
  return customerCtr.getAllSupports();
});

class SupportController extends StateNotifier<bool> {
  final AuthApis _authApis;
  final SupportDatabaseApi _databaseApis;

  SupportController({
    required AuthApis authApis,
    required SupportDatabaseApi databaseApis,
  })  : _authApis = authApis,
        _databaseApis = databaseApis,
        super(false);

  Future<void> addSupport({
    required BuildContext context,
    required SupportModel supportModel,
  }) async {
    state = true;
    final userId = _authApis.getCurrentUser();

    final result = await _databaseApis.addSupport(
        supportModel: supportModel.copyWith(userId: userId?.uid ?? ''));

    result.fold((l) {
      state = false;
      showSnackBar(context, l.message);
    }, (r) async {
      state = false;
      showSnackBar(context, 'customer added successfully');
      Navigator.of(context).pop();
    });
  }

  Stream<List<SupportModel>> getAllSupports() {
    try {
      final user = _authApis.getCurrentUser();
      Stream<List<SupportModel>> customers =
          _databaseApis.getAllSupportMails(userId: user!.uid);
      return customers;
    } catch (error) {
      return const Stream.empty();
    }
  }

  Future<void> deleteSupport({
    required BuildContext context,
    required String supportId,
  }) async {
    try {
      await _databaseApis.deleteSupport(
          supportId: supportId);
      showSnackBar(context, 'customer deleted successfully');
    } catch (e) {
      showSnackBar(context, 'something went wrong');
    }
  }
}
