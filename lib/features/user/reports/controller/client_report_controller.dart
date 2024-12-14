import 'package:flutter/cupertino.dart';
import 'package:invoice_producer/commons/common_functions/currency_converter.dart';
import 'package:invoice_producer/features/user/dashboard/controller/dashboard_notifiar_ctr.dart';
import '../../../../commons/common_imports/apis_commons.dart';
import '../../../../models/invoice_model/invoice_model.dart';
import '../../invoice/controller/invoice_upload_controller.dart';

final clientReportCountsControllerProvider =
    StateNotifierProvider<ClientReportCountsController, Counts>((ref) {
  return ClientReportCountsController();
});

extension IterableInvoiceExtensions on Iterable<InVoiceModel>? {
  int countWhere(bool Function(InVoiceModel) condition) {
    return this?.where(condition).length ?? 0;
  }

  // double sumAmount(bool Function(InVoiceModel) condition,
  //     double Function(InVoiceModel) amountExtractor){
  //   return this
  //           ?.where(condition)
  //           .fold(0.0, (sum, invoice) => sum! + amountExtractor(invoice)) ??
  //       0;
  // }
  Future<double> sumAmount(bool Function(InVoiceModel) condition,
      double Function(InVoiceModel) amountExtractor, String toCurrency) async {
    double totalAmount = 0.0;
    if (this != null) {
      for (InVoiceModel invoice in this!.where(condition)) {
        final convertedPrice = await CurrencyConverter().convertCurrency(
          fromCurrency: invoice.currency?.name ?? 'USD',
          toCurrency: toCurrency,
          amount: amountExtractor(invoice),
        );
        totalAmount += convertedPrice;
      }
    }
    return totalAmount;
  }
}

class ClientReportCountsController extends StateNotifier<Counts> {
  ClientReportCountsController() : super(Counts(0, 0, 0, 0, 0));
  List<InVoiceModel>? clientInvoices;

  void updateCounts(
      {int? invoiceCount = 0,
      double? totalAmount = 0,
      double? paidAmount = 0,
      double? dueAmount = 0,
      double? overdueAmount = 0}) {
    state = Counts(
      state.invoiceCount = invoiceCount ?? state.invoiceCount,
      state.totalAmount = totalAmount ?? state.totalAmount,
      state.paidAmount = paidAmount ?? state.paidAmount,
      state.dueAmount = dueAmount ?? state.dueAmount,
      state.overdueAmount = overdueAmount ?? state.overdueAmount,
    );
  }

  void getClientInvoices(
      {required String customerId,
      required WidgetRef ref,
      required BuildContext context}) async {
    /// client invoices
    clientInvoices = await ref
        .read(invoiceUploadControllerProvider.notifier)
        .getInvoicesOfCustomerId(context: context, customerId: customerId);

    currentMonthDetail(toCurrency: ref.read(dashBoardNotifierCtr).currencyTypeEnum?.name ?? 'USD');
  }

  void updateCountsFromInvoices(Iterable<InVoiceModel>? invoices,
      DateTime start, DateTime end, String toCurrency) async {
    final paidAmount = await invoices?.sumAmount(
            (invoice) =>
                !invoice.isDraft! &&
                // invoice.isPaid! &&
                invoice.issueDate.isAfter(start) &&
                invoice.issueDate.isBefore(end),
            (invoice) => invoice.paid ?? 0,
            toCurrency) ??
        0;

    final dueAmount = await invoices?.sumAmount(
            (invoice) =>
                !invoice.isDraft! &&
                // !invoice.isPaid! &&
                invoice.issueDate.isAfter(start) &&
                invoice.issueDate.isBefore(end),
            (invoice) => invoice.dueBalance ?? 0,
            toCurrency) ??
        0;

    final totalAmount = await invoices?.sumAmount(
            (invoice) =>
                !invoice.isDraft! &&
                invoice.issueDate.isAfter(start) &&
                invoice.issueDate.isBefore(end),
            (invoice) => (invoice.total ?? 0),
            toCurrency) ??
        0;

    updateCounts(
      invoiceCount: invoices?.countWhere((invoice) =>
              !invoice.isDraft! &&
              invoice.issueDate.isAfter(start) &&
              invoice.issueDate.isBefore(end)) ??
          0,
      paidAmount: paidAmount,
      dueAmount: dueAmount,
      overdueAmount: invoices
          .countWhere(
            (invoice) =>
                !invoice.isDraft! &&
                invoice.isPaid == false &&
                invoice.dueDate.isBefore(DateTime.now()) &&
                invoice.issueDate.isAfter(start) &&
                invoice.issueDate.isBefore(end),
          )
          .toDouble(),
      totalAmount: totalAmount,
    );
  }

  /// monthly
  void currentMonthDetail({required String toCurrency}) {
    DateTime now = DateTime.now();
    DateTime startOfMonth = DateTime(now.year, now.month, 1);
    DateTime endOfMonth =
        DateTime(now.year, now.month + 1, 1).subtract(const Duration(days: 1));
    updateCountsFromInvoices(
        clientInvoices, startOfMonth, endOfMonth, toCurrency);
  }

  /// Weekly
  void currentWeekDetail({required String toCurrency}) {
    DateTime now = DateTime.now();
    DateTime startOfWeek = now.subtract(Duration(days: now.weekday - 1));
    DateTime endOfWeek = DateTime(
        now.year, now.month, now.day + (DateTime.daysPerWeek - now.weekday));
    updateCountsFromInvoices(
        clientInvoices, startOfWeek, endOfWeek, toCurrency);
  }

  /// yearly
  void currentYearDetail({required String toCurrency}) {
    DateTime now = DateTime.now();
    DateTime startOfYear = DateTime(now.year, 1, 1);
    DateTime endOfYear =
        DateTime(now.year + 1, 1, 1).subtract(const Duration(days: 1));
    updateCountsFromInvoices(
        clientInvoices, startOfYear, endOfYear, toCurrency);
  }
}

class Counts {
  int invoiceCount;
  double totalAmount;
  double paidAmount;
  double dueAmount;
  double overdueAmount;

  Counts(this.invoiceCount, this.totalAmount, this.paidAmount, this.dueAmount,
      this.overdueAmount);
}
