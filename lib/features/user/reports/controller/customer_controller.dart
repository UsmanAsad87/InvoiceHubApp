import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../models/customer_model/customer_model.dart';


final customerNotifierCtr = ChangeNotifierProvider((ref) => CustomerNotifierController());
class CustomerNotifierController extends ChangeNotifier{
  CustomerModel? _customerModel;
  CustomerModel? get customerModel=> _customerModel;
  setCustomerModelData(CustomerModel? model){
    _customerModel = model;
    notifyListeners();
  }
}