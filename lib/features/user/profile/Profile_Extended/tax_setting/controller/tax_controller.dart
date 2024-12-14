import 'package:invoice_producer/commons/common_widgets/show_toast.dart';
import 'package:invoice_producer/features/user/profile/Profile_Extended/payment_settings/api/payment_api_provider.dart';
import 'package:invoice_producer/features/user/profile/Profile_Extended/tax_setting/api/tax_api_provider.dart';
import 'package:invoice_producer/models/auth_models/user_model.dart';
import '../../../../../../commons/common_imports/apis_commons.dart';
import '../../../../../../commons/common_imports/common_libs.dart';
import '../../../../../../models/tax_model/tac_stat_model.dart';
import '../../../../../../models/tax_model/tax_model.dart';
import '../../../../../auth/data/auth_apis/auth_apis.dart';
import '../../../../../auth/data/auth_apis/database_apis.dart';

final taxControllerProvider =
StateNotifierProvider<TaxController, bool>((ref) {
  return TaxController(
    authApis: ref.watch(authApisProvider),
    databaseApis: ref.watch(taxDataBaseApiProvider),
    userdatabaseApis: ref.watch(databaseApisProvider),
  );
});

final getAllTaxesProvider =
StreamProvider((ref) {
  final taxCtr = ref.watch(taxControllerProvider.notifier);
  return taxCtr.getAllTax();
});

final getTaxStatus =
StreamProvider.family((ref, BuildContext context) {
  final taxCtr = ref.watch(taxControllerProvider.notifier);
  return taxCtr.getTaxStatus(context: context);
});

class TaxController extends StateNotifier<bool> {
  final AuthApis _authApis;
  final TaxDatabaseApi _databaseApis;
  final DatabaseApis _userdatabaseApis;

  TaxController({
    required AuthApis authApis,
    required TaxDatabaseApi databaseApis,
    required DatabaseApis userdatabaseApis,
  })  : _authApis = authApis,
        _databaseApis = databaseApis,
        _userdatabaseApis = userdatabaseApis,
  // _companyNotifier = companyNotifier,
        super(false);

  Future<void> addTax(
      {required BuildContext context,
        required TaxModel taxModel,}) async {
    state = true;
    final userId = _authApis.getCurrentUser();
    final result = await _databaseApis.addTax(
        userId: userId!.uid, tax: taxModel);

    result.fold((l) {
      state = false;
      showSnackBar(context, l.message);
    }, (r) async {
      state = false;
      showSnackBar(context, 'Tax added successfully');
      Navigator.of(context).pop();
    });
  }

  Future<void> enableDisableTax(
      {required BuildContext context,
        required TaxStatModel taxModel,}) async {
    state = true;
    final userId = _authApis.getCurrentUser();
    final result = await _databaseApis.enableDisableTax(
        userId: userId!.uid, taxModel: taxModel);

    result.fold((l) {
      state = false;
      showSnackBar(context, l.message);
    }, (r) async {
      state = false;
      showSnackBar(context, 'Tax added successfully');
      Navigator.of(context).pop();
    });
  }

  Stream<TaxStatModel> getTaxStatus({
    required BuildContext context,
  }) {
      final user = _authApis.getCurrentUser();
      return _databaseApis.getTaxStatus(userId: user!.uid);
  }

  Stream<List<TaxModel>> getAllTax() {
    try {
      final user = _authApis.getCurrentUser();
      Stream<List<TaxModel>> allTax =
      _databaseApis.getAllTax(userId: user!.uid);
      return allTax;
    } catch (error) {
      return Stream.value([]);
      // Handle the error as needed
    }
  }

  Future<void> updateTax(
      {
        required BuildContext context,
        required TaxModel taxModel,
      }) async {
    state = true;
    final userId = _authApis.getCurrentUser();

    final result = await _databaseApis.updateTax(
        userId: userId!.uid, tax: taxModel);
    result.fold((l) {
      state = false;
      showSnackBar(context, l.message);
    }, (r) {
      state = false;
      showSnackBar(context, 'Tax update successfully');
      Navigator.of(context).pop();
    });
  }

  Future<void> deleteTax({required BuildContext context, required String taxId}) async {
    try {
      final userId = _authApis.getCurrentUser();
      await _databaseApis.deleteTax(userId: userId!.uid,taxId: taxId);
      showSnackBar(context, 'Tax account deleted successfully');
    } catch (e) {
      showSnackBar(context, 'something went wrong');
    }
  }
}
