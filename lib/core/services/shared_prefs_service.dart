import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../main.dart';


final sharedPrefsCtr = Provider<ISharefPrefsController>((ref) {
  final sharedPreferences = ref.read(sharedPreferencesProvider);
  return ISharefPrefsController(sharedPreferences: sharedPreferences);
});

abstract class SharefPrefsController {
  Future<void> setCurrency(String currecny);
  Future<String?> getCurrecny();
}

class ISharefPrefsController extends SharefPrefsController {
  final SharedPreferences sharedPreferences;

  ISharefPrefsController({required this.sharedPreferences});

  @override
  Future<void> setCurrency(String currecny) async {
    await sharedPreferences.setString("currecny", currecny);
  }

  @override
  Future<String?> getCurrecny() async {
    String? currecny = sharedPreferences.getString('currecny');
    if (currecny != null) {
      return currecny;
    } else {
      return null;
    }
  }
}
