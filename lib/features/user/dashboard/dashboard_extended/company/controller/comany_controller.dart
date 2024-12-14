import 'dart:io';

import 'package:invoice_producer/commons/common_functions/upload_image_to_firebase.dart';
import 'package:invoice_producer/commons/common_widgets/show_toast.dart';
import 'package:invoice_producer/core/constants/firebase_constants.dart';
import 'package:invoice_producer/models/auth_models/user_model.dart';
import '../../../../../../commons/common_imports/apis_commons.dart';
import '../../../../../../commons/common_imports/common_libs.dart';
import '../../../../../../core/enums/date_filter_type.dart';
import '../../../../../../models/company_models/company_model.dart';
import '../../../../../../routes/route_manager.dart';
import '../../../../../auth/data/auth_apis/auth_apis.dart';
import '../../../../../auth/data/auth_apis/database_apis.dart';
import '../api/comany_api_provider.dart';

final companyControllerProvider =
    StateNotifierProvider<CompanyController, bool>((ref) {
  return CompanyController(
    authApis: ref.watch(authApisProvider),
    databaseApis: ref.watch(companyDataBaseApiProvider),
    userdatabaseApis: ref.watch(databaseApisProvider),
  );
});

final getAllCompaniesProvider =
    StreamProvider.family((ref, BuildContext context) {
  final companyCtr = ref.watch(companyControllerProvider.notifier);
  return companyCtr.getAllCompanies();
});

final getCompaniesCountProvider =
    StreamProvider.family((ref, BuildContext context) {
  final companyCtr = ref.watch(companyControllerProvider.notifier);
  return companyCtr.getAllCompaniesCount(context: context);
});

final getFilterCompanyCountProvider =
FutureProvider.family((ref, DateFilterType filterType) {
  final companyCtr = ref.watch(companyControllerProvider.notifier);
  return companyCtr.getCompanyCount(filterType: filterType);
});

class CompanyController extends StateNotifier<bool> {
  final AuthApis _authApis;
  final CompanyDatabaseApi _databaseApis;
  final DatabaseApis _userdatabaseApis;

  CompanyController({
    required AuthApis authApis,
    required CompanyDatabaseApi databaseApis,
    required DatabaseApis userdatabaseApis,
  })  : _authApis = authApis,
        _databaseApis = databaseApis,
        _userdatabaseApis = userdatabaseApis,
        super(false);

  Future<void> addCompany({
    required BuildContext context,
    required CompanyModel companyModel,
    required bool isDefault,
    // required UserModel user,
    required bool isSkip,
  }) async {
    state = true;
    final userId = _authApis.getCurrentUser();

    String? image;
    if (companyModel.logo != '') {
      image = await uploadImage(
          img: File(companyModel.logo),
          storageFolderName: userId!.uid,
          subFolderName: FirebaseConstants.companyCollection);
    }

    final updateCompany = companyModel.copyWith(logo: image ?? '');

    final result = await _databaseApis.addCompany(
        userId: userId!.uid, company: updateCompany);
    final result2 = await _userdatabaseApis.getCurrentUserInfo(uid: userId.uid);
    final user = UserModel.fromMap(result2.data()  as Map<String, dynamic>);
    result.fold((l) {
      state = false;
      showSnackBar(context, l.message);
    }, (r) async {
      state = false;
      if (isDefault) {
        final updateUser =
            user.copyWith(defaultCompany: companyModel.companyId);
        _userdatabaseApis.updateFirestoreCurrentUserInfo(userModel: updateUser);
      }
      showSnackBar(context, 'company added successfully');
      if (isSkip) {
        Navigator.pushNamedAndRemoveUntil(context,
            AppRoutes.addPaymentAccountScreen, (route) => false,
            arguments: {'skip': true});
      } else {
        Navigator.of(context).pop();
      }
    });
  }

  Stream<List<CompanyModel>> getAllCompanies() {
    try {
      final user = _authApis.getCurrentUser();
      Stream<List<CompanyModel>> companies =
          _databaseApis.getAllCompanies(userId: user!.uid);
      return companies;
    } catch (error) {
      return Stream.value([]);
      // Handle the error as needed
    }
  }

  Stream<int> getAllCompaniesCount({
    required BuildContext context,
  }) {
    try {
      final user = _authApis.getCurrentUser();
      Stream<int> companiesCount =
          _databaseApis.getAllCompaniesCount(userId: user!.uid);
      return companiesCount;
    } catch (error) {
      showSnackBar(context, 'Error getting companies: $error');
      return Stream.value(0);
      // Handle the error as needed
    }
  }

  Future<void> updateCompany(
      {required BuildContext context,
      required CompanyModel companyModel,
      required bool isDefault,
      required UserModel user,
      String? imagePath}) async {
    state = true;
    final userId = _authApis.getCurrentUser();
    CompanyModel? updateCom;
    print(imagePath);
    if (imagePath != null && imagePath != '') {
      String? image = await uploadImage(
          img: File(imagePath),
          storageFolderName: userId!.uid,
          subFolderName: FirebaseConstants.companyCollection);
      updateCom = companyModel.copyWith(logo: image);
    }
    final result = await _databaseApis.updateCompany(
        userId: userId!.uid, company: updateCom ?? companyModel);
    result.fold((l) {
      state = false;
      showSnackBar(context, l.message);
    }, (r) {
      state = false;
      if (isDefault) {
        final updateUser =
            user.copyWith(defaultCompany: companyModel.companyId);
        _userdatabaseApis.updateFirestoreCurrentUserInfo(userModel: updateUser);
      }
      showSnackBar(context, 'company update successfully');
      Navigator.of(context).pop();
    });
  }

  Future<int?> getCompanyCount({
    required DateFilterType filterType,
  }) async {
    try {
      final user = _authApis.getCurrentUser();
      final count = await _databaseApis.getCompanyCount(
        userId: user!.uid,
        filterType: filterType,
      );

      return count.fold(
            (l) {
          return 0;
        },
            (r) {
          return r;
        },
      );
    } catch (error) {
      return null;
    }
  }

  Future<void> deleteCompany(
      {required context, required String companyId}) async {
    try {
      final userId = _authApis.getCurrentUser();
      await _databaseApis.deleteCompany(
          userId: userId!.uid, companyId: companyId);
      // refresh(context);
      showSnackBar(context, 'company deleted successfully');
    } catch (e) {
      showSnackBar(context, 'something went wrong');
    }
  }
}
