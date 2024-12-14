import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:invoice_producer/core/constants/firebase_constants.dart';

import '../../../../../../commons/common_imports/apis_commons.dart';
import '../../../../../../commons/common_providers/global_providers.dart';
import '../../../../../../core/enums/date_filter_type.dart';
import '../../../../../../core/type_defs.dart';
import '../../../../../../models/company_models/company_model.dart';

final companyDataBaseApiProvider = Provider<CompanyDatabaseApi>((ref) {
  final firestore = ref.watch(firebaseDatabaseProvider);
  return CompanyDatabaseApi(firestore: firestore);
});

class CompanyDatabaseApi {
  final FirebaseFirestore _firestore;

  CompanyDatabaseApi({required FirebaseFirestore firestore})
      : _firestore = firestore;

  FutureEitherVoid addCompany({
    required String userId,
    required CompanyModel company,
  }) async {
    try {
      CollectionReference userCompaniesRef = _firestore
          .collection(FirebaseConstants.userCollection)
          .doc(userId)
          .collection(FirebaseConstants.companyCollection);

      await userCompaniesRef.doc(company.companyId).set(company.toMap());
      return const Right(null);
    } on FirebaseException catch (e, stackTrace) {
      return Left(Failure(e.message ?? 'Firebase error occure', stackTrace));
    } catch (e, stackTrace) {
      return Left(Failure(e.toString(), stackTrace));
    }
  }

  Stream<List<CompanyModel>> getAllCompanies({required String userId}) {
    try {
      CollectionReference userCompaniesRef = _firestore
          .collection(FirebaseConstants.userCollection)
          .doc(userId)
          .collection(FirebaseConstants.companyCollection);

      return userCompaniesRef.snapshots().map((querySnapshot) {
        return querySnapshot.docs.map((doc) {
          return CompanyModel.fromMap(doc.data() as Map<String, dynamic>);
        }).toList();
      });
    } catch (error) {
      print('Error fetching companies: $error');
      return Stream.value([]);
    }
  }

  Stream<int> getAllCompaniesCount({required String userId}) {
    try {
      CollectionReference userCompaniesRef = _firestore
          .collection(FirebaseConstants.userCollection)
          .doc(userId)
          .collection(FirebaseConstants.companyCollection);

      return userCompaniesRef.snapshots().map((querySnapshot) {
        return querySnapshot.size;
      });
    } catch (error) {
      print('Error fetching companies: $error');
      return Stream.value(0); // Return a stream with the count 0 in case of an error
    }
  }

  FutureEitherVoid updateCompany({
    required String userId,
    required CompanyModel company,
  }) async {
    try {
      CollectionReference userCompaniesRef = _firestore
          .collection(FirebaseConstants.userCollection)
          .doc(userId)
          .collection(FirebaseConstants.companyCollection);

      // Update existing company
      await userCompaniesRef.doc(company.companyId).update(company.toMap());

      return const Right(null);
    } on FirebaseException catch (e, stackTrace) {
      return Left(Failure(e.message ?? 'Firebase error occure', stackTrace));
    } catch (e, stackTrace) {
      return Left(Failure(e.toString(), stackTrace));
    }
  }

  Future<Either<Failure, int>> getCompanyCount({
    required String userId,
    DateFilterType filterType = DateFilterType.monthly,
  }) async {
    try {
      CollectionReference productRef = _firestore
          .collection(FirebaseConstants.userCollection)
          .doc(userId)
          .collection(FirebaseConstants.companyCollection);

      DateTime currentDate = DateTime.now();
      DateTime startDate;

      switch (filterType) {
        case DateFilterType.weekly:
          startDate = currentDate.subtract(Duration(days: currentDate.weekday - 1));
          currentDate = currentDate.add(Duration(days: (DateTime.daysPerWeek - currentDate.weekday).toInt()));
          break;
        case DateFilterType.monthly:
          startDate = DateTime(currentDate.year, currentDate.month, 1);
          currentDate = DateTime(currentDate.year, currentDate.month,
              DateTime(currentDate.year, currentDate.month + 1, 0).day);
          break;
        case DateFilterType.yearly:
          startDate = DateTime(currentDate.year,);
          currentDate = DateTime(currentDate.year + 1, 1, 0);
          break;
        default:
          startDate = currentDate.subtract(Duration(days: 7));
      }

      Timestamp startTimestamp = Timestamp.fromDate(startDate);
      Timestamp endTimestamp = Timestamp.fromDate(currentDate);

      QuerySnapshot querySnapshot = await productRef
          .where('date', isGreaterThanOrEqualTo: startTimestamp)
          .where('date', isLessThanOrEqualTo: endTimestamp)
          .get();
      return Right(querySnapshot.size);
    } catch (e, stackTrace) {
      return Left(Failure(e.toString(), stackTrace));
    }
  }

  FutureEitherVoid deleteCompany(
      {required String userId, required String companyId}) async {
    try {
      final CollectionReference customersRef = _firestore
          .collection(FirebaseConstants.userCollection)
          .doc(userId)
          .collection(FirebaseConstants.companyCollection);
      await customersRef.doc(companyId).delete();

      return const Right(null);
    } on FirebaseException catch (e, stackTrace) {
      return Left(Failure(e.message ?? 'Firebase error occure', stackTrace));
    } catch (e, stackTrace) {
      return Left(Failure(e.toString(), stackTrace));
    }
  }
}
