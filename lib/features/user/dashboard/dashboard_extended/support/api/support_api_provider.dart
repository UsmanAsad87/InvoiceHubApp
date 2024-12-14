import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:invoice_producer/commons/common_providers/global_providers.dart';
import 'package:invoice_producer/core/constants/firebase_constants.dart';
import 'package:invoice_producer/models/support_model/support_model.dart';
import '../../../../../../../commons/common_imports/apis_commons.dart';

final supportDatabaseApiProvider = Provider<SupportDatabaseApi>((ref) {
  final firebase = ref.watch(firebaseDatabaseProvider);
  return SupportDatabaseApi(firebase: firebase);
});

class SupportDatabaseApi {
  final FirebaseFirestore _firestore;

  SupportDatabaseApi({required FirebaseFirestore firebase})
      : _firestore = firebase;

  FutureEitherVoid addSupport({
    required SupportModel supportModel}) async {
    try {
      CollectionReference customerRef = _firestore
          .collection(FirebaseConstants.supportCollection);
      await customerRef
          .doc(supportModel.id)
          .set(supportModel.toMap());
      return const Right(null);
    } on FirebaseException catch (e, stackTrace) {
      return Left(Failure(e.message ?? 'Firebase error occure', stackTrace));
    } catch (e, stackTrace) {
      return Left(Failure(e.toString(), stackTrace));
    }
  }

  Stream<List<SupportModel>> getAllSupportMails({required String userId}) {
    try {
      final supportRef = _firestore
          .collection(FirebaseConstants.supportCollection)
          .where('userId', isEqualTo: userId);

      return supportRef.snapshots().map((querySnapshot) {
        return querySnapshot.docs.map((doc) {
          return SupportModel.fromMap(doc.data());
        }).toList();
      });
    } catch (error) {
      print('Error fetching companies: $error');
      return const Stream.empty();
    }
  }

  FutureEitherVoid deleteSupport({required String supportId}) async {
    try {
      final supportDoc = _firestore
          .collection(FirebaseConstants.supportCollection).doc(supportId);
      await supportDoc.delete();

      return const Right(null);
    } on FirebaseException catch (e, stackTrace) {
      return Left(Failure(e.message ?? 'Firebase error occure', stackTrace));
    } catch (e, stackTrace) {
      return Left(Failure(e.toString(), stackTrace));
    }
  }
}
