import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:invoice_producer/commons/common_providers/global_providers.dart';
import 'package:invoice_producer/core/constants/firebase_constants.dart';

import '../../../../../../../commons/common_imports/apis_commons.dart';
import '../../../../../../core/enums/date_filter_type.dart';
import '../../../../../../models/customer_model/customer_model.dart';

final customerDatabaseApiProvider = Provider<SupportDatabaseApi>((ref) {
  final firebase = ref.watch(firebaseDatabaseProvider);
  return SupportDatabaseApi(firebase: firebase);
});

class SupportDatabaseApi {
  final FirebaseFirestore _firestore;

  SupportDatabaseApi({required FirebaseFirestore firebase})
      : _firestore = firebase;

  FutureEitherVoid addCustomer(
      {required userId, required CustomerModel customerModel}) async {
    try {
      CollectionReference customerRef = _firestore
          .collection(FirebaseConstants.userCollection)
          .doc(userId)
          .collection(FirebaseConstants.customerCollection);
      await customerRef
          .doc(customerModel.customerId)
          .set(customerModel.toMap());
      return const Right(null);
    } on FirebaseException catch (e, stackTrace) {
      return Left(Failure(e.message ?? 'Firebase error occure', stackTrace));
    } catch (e, stackTrace) {
      return Left(Failure(e.toString(), stackTrace));
    }
  }

  Stream<List<CustomerModel>> getAllCustomers({required String userId}) {
    try {
      CollectionReference userCustomerRef = _firestore
          .collection(FirebaseConstants.userCollection)
          .doc(userId)
          .collection(FirebaseConstants.customerCollection);

      return userCustomerRef.snapshots().map((querySnapshot) {
        return querySnapshot.docs.map((doc) {
          return CustomerModel.fromMap(doc.data() as Map<String, dynamic>);
        }).toList();
      });
    } catch (error) {
      print('Error fetching companies: $error');
      return const Stream.empty();
    }
  }

  Stream<int> getAllCustomersCount({required String userId}) {
    try {
      CollectionReference userCustomerRef = _firestore
          .collection(FirebaseConstants.userCollection)
          .doc(userId)
          .collection(FirebaseConstants.customerCollection);

      return userCustomerRef.snapshots().map((querySnapshot) {
        return querySnapshot.size;
      });
    } catch (error) {
      print('Error fetching customers: $error');
      return Stream.value(0); // Return a stream with the count 0 in case of an error
    }
  }

  FutureEitherVoid updateCustomer({
    required String userId,
    required CustomerModel customerModel,
  }) async {
    try {
      CollectionReference customerColRef = _firestore
          .collection(FirebaseConstants.userCollection)
          .doc(userId)
          .collection(FirebaseConstants.customerCollection);

      // Update existing company
      await customerColRef
          .doc(customerModel.customerId)
          .update(customerModel.toMap());

      return const Right(null);
    } on FirebaseException catch (e, stackTrace) {
      return Left(Failure(e.message ?? 'Firebase error occure', stackTrace));
    } catch (e, stackTrace) {
      return Left(Failure(e.toString(), stackTrace));
    }
  }

  Future<Either<Failure, int>> getCustomerCount({
    required String userId,
    DateFilterType filterType = DateFilterType.monthly,
  }) async {
    try {
      CollectionReference customerRef = _firestore
          .collection(FirebaseConstants.userCollection)
          .doc(userId)
          .collection(FirebaseConstants.customerCollection);

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

      QuerySnapshot querySnapshot = await customerRef
          .where('date', isGreaterThanOrEqualTo: startTimestamp)
          .where('date', isLessThanOrEqualTo: endTimestamp)
          .get();
      return Right(querySnapshot.size);
    } catch (e, stackTrace) {
      return Left(Failure(e.toString(), stackTrace));
    }
  }
  FutureEitherVoid deleteCustomer({required String userId, required String customerId}) async {
    try {
      final CollectionReference customersRef = _firestore
          .collection(FirebaseConstants.userCollection)
          .doc(userId)
          .collection(FirebaseConstants.customerCollection);
      await customersRef.doc(customerId).delete();

      return const Right(null);
    } on FirebaseException catch (e, stackTrace) {
      return Left(Failure(e.message ?? 'Firebase error occure', stackTrace));
    } catch (e, stackTrace) {
      return Left(Failure(e.toString(), stackTrace));
    }
  }
}
