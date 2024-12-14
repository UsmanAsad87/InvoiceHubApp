import 'dart:io';

import 'package:invoice_producer/features/user/products/api/product_api_provider.dart';
import 'package:invoice_producer/models/product_model/item_model.dart';

import '../../../../commons/common_functions/upload_image_to_firebase.dart';
import '../../../../commons/common_imports/apis_commons.dart';
import '../../../../commons/common_imports/common_libs.dart';
import '../../../../commons/common_widgets/show_toast.dart';
import '../../../../core/constants/firebase_constants.dart';
import '../../../../core/enums/date_filter_type.dart';
import '../../../auth/data/auth_apis/auth_apis.dart';

final productControllerProvider =
StateNotifierProvider<ProductController, bool>((ref) {
  return ProductController(
    authApis: ref.watch(authApisProvider),
    databaseApis: ref.watch(productDatabaseApiProvider),
  );
});

final getAllProductsProvider = StreamProvider.family((ref, BuildContext context) {
  final customerCtr = ref.watch(productControllerProvider.notifier);
  return customerCtr.getAllProducts(context);
});

final getProductCountProvider =
StreamProvider.family((ref, BuildContext context) {
  final customerCtr = ref.watch(productControllerProvider.notifier);
  return customerCtr.getAllProductCount(context: context);
});

final getFilterProductCountProvider =
FutureProvider.family((ref, DateFilterType filterType) {
  final invoiceCtr = ref.watch(productControllerProvider.notifier);
  return invoiceCtr.getProductCount(filterType: filterType);
});

class ProductController extends StateNotifier<bool> {
  final AuthApis _authApis;
  final ProductDatabaseApi _databaseApis;
  ProductController(
      {required AuthApis authApis,
        required ProductDatabaseApi databaseApis,
      })
      : _authApis = authApis,
        _databaseApis = databaseApis,
        super(false);

  Future<void> addProduct(
      BuildContext context,
      ItemModel itemModel,
      ) async {
    state = true;
    final userId = _authApis.getCurrentUser();

    String? image;
    if (itemModel.image != '') {
      image = await uploadImage(
          img: File(itemModel.image),
          storageFolderName: userId!.uid,
          subFolderName: FirebaseConstants.productCollection);
    }

    final updateItem = itemModel.copyWith(image: image ?? '');

    final result = await _databaseApis.addProduct(
        userId: userId!.uid, itemModel: updateItem);

    result.fold((l) {
      state = false;
      showSnackBar(context, l.message);
    }, (r) async {
      state = false;
      showSnackBar(context, 'Item added successfully');
      Navigator.of(context).pop();
    });
  }

  Stream<List<ItemModel>> getAllProducts(BuildContext context,)  {
    try {
      final user = _authApis.getCurrentUser();
      Stream<List<ItemModel>> products = _databaseApis.getAllProducts(user!.uid);
      return products;
    } catch (error) {
      showSnackBar(context, 'Error getting items: $error');
      return const Stream.empty();
      // Handle the error as needed
    }
  }

  Future<void> updateProducts(BuildContext context, ItemModel itemModel,
     [ String? imagePath]) async {
    state = true;
    final userId = _authApis.getCurrentUser();
    ItemModel? updateItem;
    if (imagePath != null) {
      String? image = await uploadImage(
          img: File(imagePath!),
          storageFolderName: userId!.uid,
          subFolderName: FirebaseConstants.companyCollection);
      updateItem = itemModel.copyWith(image: image);
    }
    final result = await _databaseApis.updateProduct(
        userId: userId!.uid, itemModel: updateItem ?? itemModel);
    result.fold((l) {
      state = false;
      showSnackBar(context, l.message);
    }, (r) {
      state = false;
      showSnackBar(context, 'item update successfully');
      Navigator.of(context).pop();
    });
  }

  Stream<int> getAllProductCount({
    required BuildContext context,
  }) {
    try {
      final user = _authApis.getCurrentUser();
      Stream<int> productCount =
      _databaseApis.getAllProductCount(userId: user!.uid);
      return productCount;
    } catch (error) {
      showSnackBar(context, 'Error getting Products: $error');
      return Stream.value(0);
      // Handle the error as needed
    }
  }


  Future<int?> getProductCount({
    required DateFilterType filterType,
  }) async {
    try {
      final user = _authApis.getCurrentUser();
      final count = await _databaseApis.getProductsCount(
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


  Future<void> deleteProduct(context, String itemId) async {
    try {
      final userId = _authApis.getCurrentUser();
      await _databaseApis.deleteProduct(userId!.uid, itemId);
      showSnackBar(context, 'item deleted successfully');
    } catch (e) {
      showSnackBar(context, 'something went wrong');
    }
  }

}
