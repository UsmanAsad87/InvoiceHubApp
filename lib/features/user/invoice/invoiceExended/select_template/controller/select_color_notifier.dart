import 'package:flutter/material.dart';

import '../../../../../../commons/common_imports/apis_commons.dart';


class SelectedColorNotifier extends ChangeNotifier {
  int _selectedColorIndex = 0;

  int get selectedColorIndex => _selectedColorIndex;

  set selectedColorIndex(int index) {
    _selectedColorIndex = index;
    notifyListeners();
  }
}

final selectedColorProvider = ChangeNotifierProvider<SelectedColorNotifier>((ref) => SelectedColorNotifier());
