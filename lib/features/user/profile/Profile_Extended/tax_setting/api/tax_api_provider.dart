import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:invoice_producer/core/constants/firebase_constants.dart';
import 'package:invoice_producer/models/tax_model/tax_model.dart';
import '../../../../../../commons/common_imports/apis_commons.dart';
import '../../../../../../commons/common_providers/global_providers.dart';
import '../../../../../../core/type_defs.dart';
import '../../../../../../models/tax_model/tac_stat_model.dart';

final taxDataBaseApiProvider = Provider<TaxDatabaseApi>((ref) {
  final firestore = ref.watch(firebaseDatabaseProvider);
  return TaxDatabaseApi(firestore: firestore);
});


class TaxDatabaseApi {
  final FirebaseFirestore _firestore;

  TaxDatabaseApi({required FirebaseFirestore firestore})
      : _firestore = firestore;

  FutureEitherVoid addTax({
    required String userId,
    required TaxModel tax,
  }) async {
    try {
      CollectionReference taxRef = _firestore
          .collection(FirebaseConstants.userCollection)
          .doc(userId)
          .collection(FirebaseConstants.taxCollection);

      await taxRef.doc(tax.taxId).set(tax.toMap());
      return const Right(null);
    } on FirebaseException catch (e, stackTrace) {
      return Left(Failure(e.message ?? 'Firebase error occure', stackTrace));
    } catch (e, stackTrace) {
      return Left(Failure(e.toString(), stackTrace));
    }
  }

  FutureEitherVoid enableDisableTax({
    required String userId,
    required TaxStatModel taxModel,
  }) async {
    try {
      _firestore
          .collection(FirebaseConstants.userCollection)
          .doc(userId)
          .collection(FirebaseConstants.taxStatCollection)
          .doc(userId).set(taxModel.toMap());
      return const Right(null);
    } on FirebaseException catch (e, stackTrace) {
      return Left(Failure(e.message ?? 'Firebase error occure', stackTrace));
    } catch (e, stackTrace) {
      return Left(Failure(e.toString(), stackTrace));
    }
  }

  Stream<TaxStatModel> getTaxStatus({required String userId}) {
          return _firestore
          .collection(FirebaseConstants.userCollection)
          .doc(userId)
          .collection(FirebaseConstants.taxStatCollection)
          .doc(userId).snapshots().map((querySnapshot) {
            return TaxStatModel.fromMap(querySnapshot.data() as Map<String, dynamic>);
          });
  }
  Stream<List<TaxModel>> getAllTax({required String userId}) {
    try {
      CollectionReference taxRef = _firestore
          .collection(FirebaseConstants.userCollection)
          .doc(userId)
          .collection(FirebaseConstants.taxCollection);

      return taxRef.snapshots().map((querySnapshot) {
        return querySnapshot.docs.map((doc) {
          return TaxModel.fromMap(doc.data() as Map<String, dynamic>);
        }).toList();
      });
    } catch (error) {
      print('Error fetching companies: $error');
      return Stream.value([]);
    }
  }

  FutureEitherVoid updateTax({
    required String userId,
    required TaxModel tax,
  }) async {
    try {
      CollectionReference taxRef = _firestore
          .collection(FirebaseConstants.userCollection)
          .doc(userId)
          .collection(FirebaseConstants.taxCollection);

      // Update existing company
      await taxRef.doc(tax.taxId).update(tax.toMap());

      return const Right(null);
    } on FirebaseException catch (e, stackTrace) {
      return Left(Failure(e.message ?? 'Firebase error occure', stackTrace));
    } catch (e, stackTrace) {
      return Left(Failure(e.toString(), stackTrace));
    }
  }

  FutureEitherVoid deleteTax(
      {required String userId, required String taxId}) async {
    try {
      final CollectionReference taxRef = _firestore
          .collection(FirebaseConstants.userCollection)
          .doc(userId)
          .collection(FirebaseConstants.taxCollection);
      await taxRef.doc(taxId).delete();

      return const Right(null);
    } on FirebaseException catch (e, stackTrace) {
      return Left(Failure(e.message ?? 'Firebase error occure', stackTrace));
    } catch (e, stackTrace) {
      return Left(Failure(e.toString(), stackTrace));
    }
  }
}
