import 'package:invoice_producer/models/auth_models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final authNotifierCtr = ChangeNotifierProvider((ref) => AuthNotifierController());
class AuthNotifierController extends ChangeNotifier{
  UserModel? _userModel;
  UserModel? get userModel=> _userModel;
  setUserModelData(UserModel model){
    _userModel = model;
    notifyListeners();
  }
}