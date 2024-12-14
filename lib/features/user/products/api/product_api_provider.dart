import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:invoice_producer/commons/common_providers/global_providers.dart';
import 'package:invoice_producer/core/constants/firebase_constants.dart';
//
import '../../../../../../../commons/common_imports/apis_commons.dart';
import '../../../../core/enums/date_filter_type.dart';
import '../../../../models/product_model/item_model.dart';


final productDatabaseApiProvider = Provider<ProductDatabaseApi>((ref) {
  final firebase = ref.watch(firebaseDatabaseProvider);
  return ProductDatabaseApi(firebase: firebase);
});



class ProductDatabaseApi {
  final FirebaseFirestore _firestore;
//
  ProductDatabaseApi({required FirebaseFirestore firebase})
      : _firestore = firebase;

  FutureEitherVoid addProduct(
      {required userId, required ItemModel itemModel}) async {
    try {
      CollectionReference customerRef = _firestore
          .collection(FirebaseConstants.userCollection)
          .doc(userId)
          .collection(FirebaseConstants.productCollection);
      await customerRef
          .doc(itemModel.itemId)
          .set(itemModel.toMap());
      return const Right(null);
    } on FirebaseException catch (e, stackTrace) {
      return Left(Failure(e.message ?? 'Firebase error occure', stackTrace));
    } catch (e, stackTrace) {
      return Left(Failure(e.toString(), stackTrace));
    }
  }

  Stream<List<ItemModel>> getAllProducts(String userId) {
    try {
      CollectionReference userProductRef = _firestore
          .collection(FirebaseConstants.userCollection)
          .doc(userId)
          .collection(FirebaseConstants.productCollection);

      return userProductRef.snapshots().map((querySnapshot) {
        return querySnapshot.docs.map((doc) {
          return ItemModel.fromMap(doc.data() as Map<String, dynamic>);
        }).toList();
      });
    } catch (error) {
      return const Stream.empty();
    }
  }

  FutureEitherVoid updateProduct({
    required String userId,
    required ItemModel itemModel,
  }) async {
    try {
      CollectionReference customerColRef = _firestore
          .collection(FirebaseConstants.userCollection)
          .doc(userId)
          .collection(FirebaseConstants.productCollection);

      // Update existing company
      await customerColRef
          .doc(itemModel.itemId)
          .update(itemModel.toMap());

      return const Right(null);
    } on FirebaseException catch (e, stackTrace) {
      return Left(Failure(e.message ?? 'Firebase error occure', stackTrace));
    } catch (e, stackTrace) {
      return Left(Failure(e.toString(), stackTrace));
    }
  }

  Stream<int> getAllProductCount({required String userId}) {
    try {
      CollectionReference productRef = _firestore
          .collection(FirebaseConstants.userCollection)
          .doc(userId)
          .collection(FirebaseConstants.productCollection);

      return productRef.snapshots().map((querySnapshot) {
        return querySnapshot.size;
      });
    } catch (error) {
      print('Error fetching customers: $error');
      return Stream.value(0);
    }
  }

  Future<Either<Failure, int>> getProductsCount({
    required String userId,
    DateFilterType filterType = DateFilterType.monthly,
  }) async {
    try {
      CollectionReference productRef = _firestore
          .collection(FirebaseConstants.userCollection)
          .doc(userId)
          .collection(FirebaseConstants.productCollection);

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

  FutureEitherVoid deleteProduct(String userId, String itemId) async {
    try {
      final CollectionReference productRef = _firestore
          .collection(FirebaseConstants.userCollection)
          .doc(userId)
          .collection(FirebaseConstants.productCollection);
      await productRef.doc(itemId).delete();

      return const Right(null);
    } on FirebaseException catch (e, stackTrace) {
      return Left(Failure(e.message ?? 'Firebase error occure', stackTrace));
    } catch (e, stackTrace) {
      return Left(Failure(e.toString(), stackTrace));
    }
  }
}
