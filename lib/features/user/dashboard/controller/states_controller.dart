import 'package:invoice_producer/core/enums/currency_sign_enum.dart';
import 'package:invoice_producer/features/user/dashboard/controller/dashboard_notifiar_ctr.dart';

import '../../../../commons/common_functions/calculateStartAndEndDate.dart';
import '../../../../commons/common_functions/currency_converter.dart';
import '../../../../commons/common_imports/apis_commons.dart';
import '../../../../commons/common_imports/common_libs.dart';
import '../../../../core/enums/date_filter_type.dart';
import '../../../../models/invoice_model/invoice_model.dart';
import '../../invoice/controller/invoice_upload_controller.dart';

Future<String> getTotalPaidInTargetCurrency(
    String toCurrency, List<InVoiceModel> invoices) async {
  double total = 0.0;
  for (var invoice in invoices) {
    final convertedAmount = await CurrencyConverter().convertCurrency(
      fromCurrency: invoice.currency?.name ?? 'USD',
      toCurrency: toCurrency,
      amount: invoice.paid ?? 0.0,
    );
    total += convertedAmount;
  }
  return total.toStringAsFixed(2);

}


final getTotalPaidInTargetProvider =
    FutureProvider.family<String, String>((ref, toCurrency) async {
  final invoices = await ref
      .read(invoiceUploadControllerProvider.notifier)
      .getAllInVoices()
      .first;
  return getTotalPaidInTargetCurrency(toCurrency, invoices);
});

final getTotalPaidThisMonthProvider =
    FutureProvider.family.autoDispose<int, bool>((ref, bool isPaid) async {
  final invoices = await ref
      .read(invoiceUploadControllerProvider.notifier)
      .getAllInVoices()
      .first;

  DateTime now = DateTime.now();
  int currentMonth = now.month;
  int currentYear = now.year;
  Map<int, int> dailyInvoiceCount = {};
  int totalInvoices = 0;
  for (InVoiceModel invoice in invoices) {
    DateTime issueDate = invoice.issueDate;
    if ((invoice.isPaid == isPaid) &&
        issueDate.month == currentMonth &&
        issueDate.year == currentYear) {
      int day = issueDate.day;
      dailyInvoiceCount[day] = (dailyInvoiceCount[day] ?? 0) + 1;
      totalInvoices++;
    }
  }
  return totalInvoices;
});

final getTotalPaidAmountThisMonthProvider =
    FutureProvider.family.autoDispose<double, bool>((ref, bool isPaid) async {
  final invoices = await ref
      .read(invoiceUploadControllerProvider.notifier)
      .getAllInVoices()
      .first;

  DateTime now = DateTime.now();
  int currentMonth = now.month;
  int currentYear = now.year;
  Map<int, int> dailyInvoiceCount = {};
  double totalAmount = 0;

  for (InVoiceModel invoice in invoices) {
    DateTime issueDate = invoice.issueDate;
    if ((invoice.isPaid == isPaid) &&
        issueDate.month == currentMonth &&
        issueDate.year == currentYear) {
      final price = await CurrencyConverter().convertCurrency(
          fromCurrency: invoice.currency?.name ?? 'USD',
          toCurrency:
              ref.read(dashBoardNotifierCtr).currencyTypeEnum?.name ?? 'USD',
          amount: invoice.total ?? 0);
      int day = issueDate.day;
      dailyInvoiceCount[day] = (dailyInvoiceCount[day] ?? 0) + 1;
      totalAmount += price; //invoice.total!;
    }
  }
  return totalAmount;
});

final getAllInvoiceAmountProvider = FutureProvider.family
    .autoDispose<double, DateFilterType>(
        (ref, DateFilterType filterType) async {
  DateTime startDate = calculateStartDate(filterType: filterType);
  DateTime endDate = calculateEndDate(filterType: filterType);
  final invoices = await ref
      .read(invoiceUploadControllerProvider.notifier)
      .getPaidInvoices(startDate: startDate, endDate: endDate);

  double totalAmount = 0;

  for (InVoiceModel invoice in invoices) {
    final price = await CurrencyConverter().convertCurrency(
        fromCurrency: invoice.currency?.name ?? 'USD',
        toCurrency:
            ref.read(dashBoardNotifierCtr).currencyTypeEnum?.name ?? 'USD',
        amount: invoice.total ?? 0);
    totalAmount += price; //invoice.total!;
  }
  return totalAmount;
});
