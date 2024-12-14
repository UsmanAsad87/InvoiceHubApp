import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../../../commons/common_imports/apis_commons.dart';
import '../../../../../../commons/common_providers/global_providers.dart';
import '../../../../../../core/constants/firebase_constants.dart';
import '../../../../../../models/signature_model/signature_model.dart';

final SignatureDatabaseApiProvider = Provider<SignatureDatabaseApi>((ref) {
  final firebase = ref.watch(firebaseDatabaseProvider);
  return SignatureDatabaseApi(firebase: firebase);
});

class SignatureDatabaseApi {
  final FirebaseFirestore _firestore;

  SignatureDatabaseApi({required FirebaseFirestore firebase})
      : _firestore = firebase;

  FutureEitherVoid addSignature(
      {required userId, required SignatureModel signatureModel}) async {
    try {
      CollectionReference signatureRef = _firestore
          .collection(FirebaseConstants.userCollection)
          .doc(userId)
          .collection(FirebaseConstants.signatureCollection);
      await signatureRef
          .doc(signatureModel.signatureId)
          .set(signatureModel.toMap());
      return const Right(null);
    } on FirebaseException catch (e, stackTrace) {
      return Left(Failure(e.message ?? 'Firebase error occure', stackTrace));
    } catch (e, stackTrace) {
      return Left(Failure(e.toString(), stackTrace));
    }
  }

  Stream<List<SignatureModel>> getAllSignature({required String userId}) {
    try {
      CollectionReference signatureRef = _firestore
          .collection(FirebaseConstants.userCollection)
          .doc(userId)
          .collection(FirebaseConstants.signatureCollection);

      return signatureRef.snapshots().map((querySnapshot) {
        return querySnapshot.docs.map((doc) {
          return SignatureModel.fromMap(doc.data() as Map<String, dynamic>);
        }).toList();
      });
    } catch (error) {
      print('Error fetching companies: $error');
      return const Stream.empty();
    }
  }

  FutureEitherVoid updateSignature({
    required String userId,
    required SignatureModel signatureModel,
  }) async {
    try {
      CollectionReference signatureRef = _firestore
          .collection(FirebaseConstants.userCollection)
          .doc(userId)
          .collection(FirebaseConstants.signatureCollection);

      // Update existing company
      await signatureRef
          .doc(signatureModel.signatureId)
          .update(signatureModel.toMap());

      return const Right(null);
    } on FirebaseException catch (e, stackTrace) {
      return Left(Failure(e.message ?? 'Firebase error occure', stackTrace));
    } catch (e, stackTrace) {
      return Left(Failure(e.toString(), stackTrace));
    }
  }

  FutureEitherVoid deleteSignature({required String userId, required String signatureId}) async {
    try {
      final CollectionReference signatureRef = _firestore
          .collection(FirebaseConstants.userCollection)
          .doc(userId)
          .collection(FirebaseConstants.signatureCollection);
      await signatureRef.doc(signatureId).delete();

      return const Right(null);
    } on FirebaseException catch (e, stackTrace) {
      return Left(Failure(e.message ?? 'Firebase error occure', stackTrace));
    } catch (e, stackTrace) {
      return Left(Failure(e.toString(), stackTrace));
    }
  }
}
