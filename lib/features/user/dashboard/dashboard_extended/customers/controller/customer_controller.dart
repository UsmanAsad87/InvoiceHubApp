import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:invoice_producer/features/auth/data/auth_apis/auth_apis.dart';
import 'package:invoice_producer/features/user/dashboard/dashboard_extended/customers/api/customer_api_provider.dart';
import 'package:invoice_producer/models/customer_model/customer_model.dart';
import '../../../../../../commons/common_functions/upload_image_to_firebase.dart';
import '../../../../../../commons/common_widgets/show_toast.dart';
import '../../../../../../core/constants/firebase_constants.dart';
import '../../../../../../core/enums/date_filter_type.dart';

final customerControllerProvider =
    StateNotifierProvider<CustomerController, bool>((ref) {
  return CustomerController(
    authApis: ref.watch(authApisProvider),
    databaseApis: ref.watch(customerDatabaseApiProvider),
  );
});

final getAllCustomersProvider =
    StreamProvider.family((ref, BuildContext context) {
  final customerCtr = ref.watch(customerControllerProvider.notifier);
  return customerCtr.getAllCustomers(context: context);
});

final getCustomerCountProvider =
StreamProvider.family((ref, BuildContext context) {
  final customerCtr = ref.watch(customerControllerProvider.notifier);
  return customerCtr.getAllCustomerCount(context: context);
});

final getFilterCustomerCountProvider =
FutureProvider.family((ref, DateFilterType filterType) {
  final customerCtr = ref.watch(customerControllerProvider.notifier);
  return customerCtr.getCustomerCount(filterType: filterType);
});

class CustomerController extends StateNotifier<bool> {
  final AuthApis _authApis;
  final SupportDatabaseApi _databaseApis;

  CustomerController({
    required AuthApis authApis,
    required SupportDatabaseApi databaseApis,
  })  : _authApis = authApis,
        _databaseApis = databaseApis,
        super(false);

  Future<void> addCustomer({
    required BuildContext context,
    required CustomerModel customerModel,
  }) async {
    state = true;
    final userId = _authApis.getCurrentUser();
    String? image;

    if (customerModel.image != ''){
      image = await uploadImage(
          img: File(customerModel.image),
          storageFolderName: userId!.uid,
          subFolderName: FirebaseConstants.customerCollection);
    }

    final updateCustomer = customerModel.copyWith(image: image ?? '');

    final result = await _databaseApis.addCustomer(
        userId: userId!.uid, customerModel: updateCustomer);

    result.fold((l) {
      state = false;
      showSnackBar(context, l.message);
    }, (r) async {
      state = false;
      showSnackBar(context, 'customer added successfully');
      Navigator.of(context).pop();
    });
  }

  Stream<List<CustomerModel>> getAllCustomers({
    required BuildContext context,
  }) {
    try {
      final user = _authApis.getCurrentUser();
      Stream<List<CustomerModel>> customers =
          _databaseApis.getAllCustomers(userId: user!.uid);
      return customers;
    } catch (error) {
      showSnackBar(context, 'Error getting companies: $error');
      return Stream.empty();
      // Handle the error as needed
    }
  }

  Stream<int> getAllCustomerCount({
    required BuildContext context,
  }) {
    try {
      final user = _authApis.getCurrentUser();
      Stream<int> customersCount =
      _databaseApis.getAllCustomersCount(userId: user!.uid);
      return customersCount;
    } catch (error) {
      showSnackBar(context, 'Error getting companies: $error');
      return Stream.value(0);
      // Handle the error as needed
    }
  }

  Future<void> updateCustomer(
      {required BuildContext context,
      required CustomerModel customerModel,
      String? imagePath}) async {
    state = true;
    final userId = _authApis.getCurrentUser();
    CustomerModel? updateCus;
    if (imagePath != null) {
      String? image = await uploadImage(
          img: File(imagePath!),
          storageFolderName: userId!.uid,
          subFolderName: FirebaseConstants.companyCollection);
      updateCus = customerModel.copyWith(image: image);
    }
    final result = await _databaseApis.updateCustomer(
        userId: userId!.uid, customerModel: updateCus ?? customerModel);
    result.fold((l) {
      state = false;
      showSnackBar(context, l.message);
    }, (r) {
      state = false;
      showSnackBar(context, 'customer update successfully');
      Navigator.of(context).pop();
    });
  }

  Future<int?> getCustomerCount({
    required DateFilterType filterType,
  }) async {
    try {
      final user = _authApis.getCurrentUser();
      final count = await _databaseApis.getCustomerCount(
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

  Future<void> deleteCustomer(
      {required BuildContext context, required String customerId}) async {
    try {
      final userId = _authApis.getCurrentUser();
      await _databaseApis.deleteCustomer(
          userId: userId!.uid, customerId: customerId);
      showSnackBar(context, 'customer deleted successfully');
    } catch (e) {
      showSnackBar(context, 'something went wrong');
    }
  }
}
