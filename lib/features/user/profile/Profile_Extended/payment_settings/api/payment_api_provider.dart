import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:invoice_producer/core/constants/firebase_constants.dart';
import '../../../../../../commons/common_imports/apis_commons.dart';
import '../../../../../../commons/common_providers/global_providers.dart';
import '../../../../../../core/type_defs.dart';
import '../../../../../../models/payment_account_model/payment_account_model.dart';

final paymentDataBaseApiProvider = Provider<PaymentDatabaseApi>((ref) {
  final firestore = ref.watch(firebaseDatabaseProvider);
  return PaymentDatabaseApi(firestore: firestore);
});

// abstract class ICompanyApis {
//   FutureEitherVoid addOrUpdateCompany({
//     required String companyName,
//   });
// }

class PaymentDatabaseApi {
  final FirebaseFirestore _firestore;

  PaymentDatabaseApi({required FirebaseFirestore firestore})
      : _firestore = firestore;

  FutureEitherVoid addPaymentAccount({
    required String userId,
    required PaymentAccountModel payment,
  }) async {
    try {
      CollectionReference userPaymentAccountRef = _firestore
          .collection(FirebaseConstants.userCollection)
          .doc(userId)
          .collection(FirebaseConstants.paymentCollection);

      await userPaymentAccountRef.doc(payment.paymentId).set(payment.toMap());
      return const Right(null);
    } on FirebaseException catch (e, stackTrace) {
      return Left(Failure(e.message ?? 'Firebase error occure', stackTrace));
    } catch (e, stackTrace) {
      return Left(Failure(e.toString(), stackTrace));
    }
  }

  Stream<List<PaymentAccountModel>> getAllPaymentAccounts({required String userId}) {
    try {
      CollectionReference userPaymentAccountRef = _firestore
          .collection(FirebaseConstants.userCollection)
          .doc(userId)
          .collection(FirebaseConstants.paymentCollection);

      return userPaymentAccountRef.snapshots().map((querySnapshot) {
        return querySnapshot.docs.map((doc) {
          return PaymentAccountModel.fromMap(doc.data() as Map<String, dynamic>);
        }).toList();
      });
    } catch (error) {
      print('Error fetching companies: $error');
      return Stream.value([]);
    }
  }

  FutureEitherVoid updatePaymentAccount({
    required String userId,
    required PaymentAccountModel payment,
  }) async {
    try {
      CollectionReference userPaymentAccountRef = _firestore
          .collection(FirebaseConstants.userCollection)
          .doc(userId)
          .collection(FirebaseConstants.paymentCollection);

      // Update existing company
      await userPaymentAccountRef.doc(payment.paymentId).update(payment.toMap());

      return const Right(null);
    } on FirebaseException catch (e, stackTrace) {
      return Left(Failure(e.message ?? 'Firebase error occure', stackTrace));
    } catch (e, stackTrace) {
      return Left(Failure(e.toString(), stackTrace));
    }
  }

  FutureEitherVoid deletePaymentAccount(
      {required String userId, required String paymentId}) async {
    try {
      final CollectionReference userPaymentAccountRef = _firestore
          .collection(FirebaseConstants.userCollection)
          .doc(userId)
          .collection(FirebaseConstants.paymentCollection);
      await userPaymentAccountRef.doc(paymentId).delete();

      return const Right(null);
    } on FirebaseException catch (e, stackTrace) {
      return Left(Failure(e.message ?? 'Firebase error occure', stackTrace));
    } catch (e, stackTrace) {
      return Left(Failure(e.toString(), stackTrace));
    }
  }
}
