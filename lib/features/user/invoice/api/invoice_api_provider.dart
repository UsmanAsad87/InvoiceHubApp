import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:invoice_producer/core/constants/firebase_constants.dart';
import 'package:invoice_producer/core/enums/invoice_status_enum.dart';
import 'package:invoice_producer/models/invoice_model/invoice_model.dart';
import '../../../../../../commons/common_imports/apis_commons.dart';
import '../../../../../../commons/common_providers/global_providers.dart';
import '../../../../../../core/type_defs.dart';
import '../../../../commons/common_functions/calculateStartAndEndDate.dart';
import '../../../../core/enums/date_filter_type.dart';

final invoiceDataBaseApiProvider = Provider<InvoiceDatabaseApi>((ref) {
  final firestore = ref.watch(firebaseDatabaseProvider);
  return InvoiceDatabaseApi(firestore: firestore);
});

class InvoiceDatabaseApi {
  final FirebaseFirestore _firestore;

  InvoiceDatabaseApi({required FirebaseFirestore firestore})
      : _firestore = firestore;

  FutureEitherVoid addInvoice({
    required String userId,
    required InVoiceModel invoice,
  }) async {
    try {
      CollectionReference userInvoiceRef = _firestore
          .collection(FirebaseConstants.userCollection)
          .doc(userId)
          .collection(FirebaseConstants.invoiceCollection);

      await userInvoiceRef.doc(invoice.invoiceNo).set(invoice.toMap());
      return const Right(null);
    } on FirebaseException catch (e, stackTrace) {
      return Left(Failure(e.message ?? 'Firebase error occur', stackTrace));
    } catch (e, stackTrace) {
      return Left(Failure(e.toString(), stackTrace));
    }
  }

  FutureEitherVoid updateInvoice({
    required String userId,
    required InVoiceModel invoice,
  }) async {
    try {
      CollectionReference userInvoiceRef = _firestore
          .collection(FirebaseConstants.userCollection)
          .doc(userId)
          .collection(FirebaseConstants.invoiceCollection);

      await userInvoiceRef.doc(invoice.invoiceNo).update(invoice.toMap());
      return const Right(null);
    } on FirebaseException catch (e, stackTrace) {
      return Left(Failure(e.message ?? 'Firebase error occur', stackTrace));
    } catch (e, stackTrace) {
      return Left(Failure(e.toString(), stackTrace));
    }
  }

  Stream<List<InVoiceModel>> getAllInVoices(
      {required String userId, required String searchQuery}) {
    try {
      return _firestore
          .collection(FirebaseConstants.userCollection)
          .doc(userId)
          .collection(FirebaseConstants.invoiceCollection)
          .where('isDraft', isNotEqualTo: true)
          .snapshots()
          .map((event) {
        List<InVoiceModel> models = [];
        for (var document in event.docs) {
          var model = InVoiceModel.fromMap(document.data());
          models.add(model);
        }
        if (searchQuery.isNotEmpty) {
          List<String> filters = searchQuery.split(' ');
          models = models.where((invoice) {
            return invoice.searchTags == null
                ? false
                : filters.any((filter) => (invoice.searchTags ?? {})
                    .entries
                    .any((entry) =>
                        entry.key.toLowerCase().contains(filter) ||
                        entry.value.toString().toLowerCase().contains(filter)));
          }).toList();
        }
        return models;
      });
    } catch (error) {
      return Stream.value([]);
    }
  }

  Stream<List<InVoiceModel>> getAllDraftInVoices(
      {required String userId, required String searchQuery}) {
    try {
      return _firestore
          .collection(FirebaseConstants.userCollection)
          .doc(userId)
          .collection(FirebaseConstants.invoiceCollection)
          .where('invoiceStatusEnum', isEqualTo: InvoiceStatusEnum.draft.name)
          .snapshots()
          .map((event) {
        List<InVoiceModel> models = [];
        for (var document in event.docs) {
          var model =
              InVoiceModel.fromMap(document.data() as Map<String, dynamic>);
          models.add(model);
        }
        if (searchQuery.isNotEmpty) {
          List<String> filters = searchQuery.split(' ');
          models = models.where((invices) {
            return filters.any((filter) => (invices.searchTags ?? {})
                .entries
                .any((entry) =>
                    entry.key.toLowerCase().contains(filter) ||
                    entry.value.toString().toLowerCase().contains(filter)));
          }).toList();
        }
        return models;
      });
    } catch (error) {
      return Stream.value([]);
    }
  }

  /// get specific customerInvoices
  Future<List<InVoiceModel>> getInVoicesOfCustomerId({
    required String userId,
    String? customerId,
  }) async {
    try {
      CollectionReference userInvoiceRef = _firestore
          .collection(FirebaseConstants.userCollection)
          .doc(userId)
          .collection(FirebaseConstants.invoiceCollection);

      QuerySnapshot querySnapshot = await userInvoiceRef.get();

      List<InVoiceModel> invoices = querySnapshot.docs
          .where(
              (doc) => (doc.data() as Map<String, dynamic>)['isDraft'] == false)
          .where((doc) =>
              customerId == null ||
              ((doc.data() as Map<String, dynamic>)['customer'] != null &&
                  (doc.data() as Map<String, dynamic>)['customer']
                          ['customerId'] ==
                      customerId))
          .map(
              (doc) => InVoiceModel.fromMap(doc.data() as Map<String, dynamic>))
          .toList();

      return invoices;
    } catch (error) {
      return []; // Handle error as needed
    }
  }

  Stream<List<InVoiceModel>> getInVoicesOfCustomerIdStream({
    required String userId,
    String? customerId,
  }) {
    try {
      CollectionReference userInvoiceRef = _firestore
          .collection(FirebaseConstants.userCollection)
          .doc(userId)
          .collection(FirebaseConstants.invoiceCollection);

      // Construct the query
      Query query = userInvoiceRef.where('isDraft', isEqualTo: false);
      if (customerId != null) {
        query = query.where('customer.customerId', isEqualTo: customerId);
      }

      // Return the stream directly from Firestore
      return query.snapshots().map((querySnapshot) => querySnapshot.docs
          .map(
              (doc) => InVoiceModel.fromMap(doc.data() as Map<String, dynamic>))
          .toList());
    } catch (error) {
      // Handle error as needed
      return Stream.error(error);
    }
  }

  Stream<int> getAllInVoicesCount({
    required String userId,
  }) {
    try {
      CollectionReference userInvoiceRef = _firestore
          .collection(FirebaseConstants.userCollection)
          .doc(userId)
          .collection(FirebaseConstants.invoiceCollection);

      return userInvoiceRef.snapshots().map((querySnapshot) {
        return querySnapshot.size;
      });
    } catch (error) {
      return Stream.value(0);
    }
  }

  Future<Either<Failure, int>> getInvoicesCount({
    required String userId,
    DateFilterType filterType = DateFilterType.monthly,
  }) async {
    try {
      DateTime startDate = calculateStartDate(filterType: filterType);
      DateTime endDate = calculateEndDate(filterType: filterType);

      QuerySnapshot querySnapshot = await getInvoicesWithinDateRange(
        userId: userId,
        startDate: startDate,
        endDate: endDate,
      );

      return Right(querySnapshot.size);
    } catch (e, stackTrace) {
      return Left(Failure(e.toString(), stackTrace));
    }
  }

  Future<Either<Failure, int>> getPaidInvoicesCount({
    required String userId,
    DateFilterType filterType = DateFilterType.monthly,
  }) async {
    try {
      DateTime startDate = calculateStartDate(filterType: filterType);
      DateTime endDate = calculateEndDate(filterType: filterType);

      QuerySnapshot querySnapshot = await getInvoicesWithinDateRange(
        userId: userId,
        startDate: startDate,
        endDate: endDate,
      );

      int paidCount = 0;
      for (QueryDocumentSnapshot doc in querySnapshot.docs) {
        bool isPaid = doc['isPaid'] ?? false;
        if (isPaid) {
          paidCount++;
        }
      }
      return Right(paidCount);
    } catch (e, stackTrace) {
      return Left(Failure(e.toString(), stackTrace));
    }
  }

  /// helper to get invoices
  Future<QuerySnapshot> getInvoicesWithinDateRange({
    required String userId,
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    try {
      CollectionReference userInvoiceRef = _firestore
          .collection(FirebaseConstants.userCollection)
          .doc(userId)
          .collection(FirebaseConstants.invoiceCollection);

      Timestamp startTimestamp = Timestamp.fromDate(startDate);
      Timestamp endTimestamp = Timestamp.fromDate(endDate);

      QuerySnapshot querySnapshot = await userInvoiceRef
          .where('issueDate', isGreaterThanOrEqualTo: startTimestamp)
          .where('issueDate', isLessThanOrEqualTo: endTimestamp)
          .get();

      return querySnapshot;
    } catch (e, stackTrace) {
      throw Failure(e.toString(), stackTrace);
    }
  }

  FutureEitherVoid deleteInvoice(
      {required String userId, required String invoiceId}) async {
    try {
      CollectionReference userInvoiceRef = _firestore
          .collection(FirebaseConstants.userCollection)
          .doc(userId)
          .collection(FirebaseConstants.invoiceCollection);

      await userInvoiceRef.doc(invoiceId).delete();
      return const Right(null);
    } on FirebaseException catch (e, stackTrace) {
      return Left(Failure(e.message ?? 'Firebase error occure', stackTrace));
    } catch (e, stackTrace) {
      return Left(Failure(e.toString(), stackTrace));
    }
  }

  // Future<void> deleteAllUserInvoices() async {
  //   final userCollection =
  //       FirebaseFirestore.instance.collection(FirebaseConstants.userCollection);
  //   final users = await userCollection.get();
  //
  //   for (var user in users.docs) {
  //
  //       final userInvoicesCollection = userCollection
  //           .doc(user.id)
  //           .collection(FirebaseConstants.invoiceCollection);
  //       final snapshot = await userInvoicesCollection.get();
  //       WriteBatch batch = FirebaseFirestore.instance.batch();
  //       for (var doc in snapshot.docs) {
  //         batch.delete(doc.reference);
  //       }
  //       await batch.commit();
  //   }
  // }
}
