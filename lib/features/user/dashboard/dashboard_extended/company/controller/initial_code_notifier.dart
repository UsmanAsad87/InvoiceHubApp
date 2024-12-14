import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class InitialCountryNotifier extends StateNotifier<String?> {
  InitialCountryNotifier() : super(null);

  void setInitialCountry(String? country) {
    state = country;
  }
}

final initialCountryProvider =
StateNotifierProvider<InitialCountryNotifier, String?>((ref) {
  return InitialCountryNotifier();
});