import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/enums/currency_sign_enum.dart';

final dashBoardNotifierCtr = ChangeNotifierProvider((ref) => DashBoardNotifierController());
class DashBoardNotifierController extends ChangeNotifier{
  CurrencySignEnum? _currencyTypeEnum;
  CurrencySignEnum? get currencyTypeEnum=> _currencyTypeEnum;
  setCurrency(CurrencySignEnum val){
    _currencyTypeEnum = val;
    notifyListeners();
  }
}