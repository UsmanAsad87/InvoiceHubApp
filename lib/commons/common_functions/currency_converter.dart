import 'dart:convert';
import 'package:http/http.dart' as http;
import '../common_imports/common_libs.dart';

class CurrencyConverter {
  final String apiKey = 'e1f793e22d545b4793dabbd7';

  Future<double> convertCurrency({
    required String fromCurrency,
    required String toCurrency,
    required double amount,
  }) async {
    if(fromCurrency == toCurrency || amount == 0){
      return amount;
    }
    final String url =
        'https://v6.exchangerate-api.com/v6/$apiKey/pair/$fromCurrency/$toCurrency/$amount';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['conversion_result'];
      } else {
        debugPrint('Failed to load exchange rate data');
        return 0;
      }
    } catch (e) {
      debugPrint('Error: $e');
      return 0;
    }
  }
}

// Class to hold parameters for conversion
class CurrencyConversionParams {
  final String fromCurrency;
  final String toCurrency;
  final double amount;

  CurrencyConversionParams({
    required this.fromCurrency,
    required this.toCurrency,
    required this.amount,
  });

  @override
  String toString() {
    return 'fromCurrency:$fromCurrency,toCurrency:$toCurrency,amount:$amount';
  }
  factory CurrencyConversionParams.fromString(String string) {
    final parts = string.split(',');
    final fromCurrency = parts[0].split(':')[1];
    final toCurrency = parts[1].split(':')[1];
    final amount = double.parse(parts[2].split(':')[1]);
    return CurrencyConversionParams(
      fromCurrency: fromCurrency,
      toCurrency: toCurrency,
      amount: amount,
    );
  }
}
