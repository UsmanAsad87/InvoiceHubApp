import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import '../../../../commons/common_imports/apis_commons.dart';
import '../../../../models/invoice_model/invoice_model.dart';
import '../../../../utils/themes/my_colors.dart';
import '../../invoice/controller/invoice_upload_controller.dart';

final invoiceCountsControllerProvider =
    StateNotifierProvider<InvoiceReportCountsController, InvoiceReportCounts>(
        (ref) {
  return InvoiceReportCountsController();
});

class InvoiceReportCountsController extends StateNotifier<InvoiceReportCounts> {
  InvoiceReportCountsController()
      : super(InvoiceReportCounts(
          0,
          0,
          0,
        ));

  void updateInvoiceCounts({
    int? paidCount,
    int? dueCount,
    int? overdueCount,
  }) {
    state = InvoiceReportCounts(
      state.paidCount = paidCount ?? state.paidCount,
      state.dueCount = dueCount ?? state.dueCount,
      state.overdueCount = overdueCount ?? state.overdueCount,
    );
  }

  /// Monthly
  Future<Map<int, int>> getDailyInvoiceCountForCurrentMonth(
    WidgetRef ref,
    BuildContext context,
    bool Function(InVoiceModel) filterCondition,
  ) async {
    List<InVoiceModel> invoices =
        await ref.read(getAllInvoicesProvider.future);
    DateTime now = DateTime.now();
    int currentMonth = now.month;
    int currentYear = now.year;
    Map<int, int> dailyInvoiceCount = {};
    for (InVoiceModel invoice in invoices) {
      DateTime issueDate = invoice.issueDate;
      if (filterCondition(invoice) &&
          issueDate.month == currentMonth &&
          issueDate.year == currentYear) {
        int day = issueDate.day;
        dailyInvoiceCount[day] = (dailyInvoiceCount[day] ?? 0) + 1;
      }
    }
    return dailyInvoiceCount;
  }

  Future<LineChartBarData> getLineChartBarDataForMonth(
      {required WidgetRef ref,
      required BuildContext context,
      required bool Function(InVoiceModel) filterCondition,
      required Color barColor,
      required String countName}) async {
    Map<int, int> dailyInvoiceCount = await getDailyInvoiceCountForCurrentMonth(
      ref,
      context,
      filterCondition,
    );
    int totalCount =
        dailyInvoiceCount.values.fold(0, (sum, count) => sum + count);
    if (countName == 'paid') {
      updateInvoiceCounts(paidCount: totalCount);
    } else if (countName == 'due') {
      updateInvoiceCounts(dueCount: totalCount);
    } else {
      updateInvoiceCounts(overdueCount: totalCount);
    }

    List<FlSpot> spots = dailyInvoiceCount.entries.map((entry) {
      return FlSpot(entry.key.toDouble(), entry.value.toDouble());
    }).toList();

    return LineChartBarData(
      isCurved: true,
      color: barColor,
      barWidth: 2,
      isStrokeCapRound: true,
      dotData: const FlDotData(show: false),
      belowBarData: BarAreaData(show: false),
      spots: spots,
    );
  }

  /// get weekly
  Future<Map<int, int>> getDailyInvoiceCountForCurrentWeek(
      WidgetRef ref,
      BuildContext context,
      bool Function(InVoiceModel) filterCondition,
      ) async {
    List<InVoiceModel> invoices =
    await ref.read(getAllInvoicesProvider.future);
    DateTime now = DateTime.now();
    DateTime startOfWeek = now.subtract(Duration(days: now.weekday - 1));
    DateTime endOfWeek = DateTime(now.year, now.month, now.day + (DateTime.daysPerWeek - now.weekday));

    Map<int, int> dailyInvoiceCount = {};
    for (InVoiceModel invoice in invoices) {
      DateTime issueDate = invoice.issueDate;
      if (filterCondition(invoice) &&
          issueDate.isAfter(startOfWeek) &&
          issueDate.isBefore(endOfWeek)) {
        int day = issueDate.weekday;
        dailyInvoiceCount[day] = (dailyInvoiceCount[day] ?? 0) + 1;
      }
    }
    return dailyInvoiceCount;
  }

  Future<LineChartBarData> getLineChartBarDataForCurrentWeek({
    required WidgetRef ref,
    required BuildContext context,
    required bool Function(InVoiceModel) filterCondition,
    required Color barColor,
    required String countName,
  }) async {
    Map<int, int> dailyInvoiceCount = await getDailyInvoiceCountForCurrentWeek(
      ref,
      context,
      filterCondition,
    );

    int totalCount =
    dailyInvoiceCount.values.fold(0, (sum, count) => sum + count);
    if (countName == 'paid') {
      updateInvoiceCounts(paidCount: totalCount);
    } else if (countName == 'due') {
      updateInvoiceCounts(dueCount: totalCount);
    } else {
      updateInvoiceCounts(overdueCount: totalCount);
    }

    List<FlSpot> spots = dailyInvoiceCount.entries.map((entry) {
      return FlSpot(entry.key.toDouble(), entry.value.toDouble());
    }).toList();

    return LineChartBarData(
      isCurved: true,
      color: barColor,
      barWidth: 2,
      isStrokeCapRound: true,
      dotData: const FlDotData(show: false),
      belowBarData: BarAreaData(show: false),
      spots: spots,
    );
  }

  /// yearly
  Future<Map<int, int>> getDailyInvoiceCountForCurrentYear(
      WidgetRef ref,
      BuildContext context,
      bool Function(InVoiceModel) filterCondition,
      ) async {
    List<InVoiceModel> invoices = await ref.read(getAllInvoicesProvider.future);
    DateTime now = DateTime.now();
    DateTime startOfYear = DateTime(now.year, 1, 1);
    DateTime endOfYear = DateTime(now.year, 12, 31);

    Map<int, int> dailyInvoiceCount = {};
    for (InVoiceModel invoice in invoices) {
      DateTime issueDate = invoice.issueDate;
      if (filterCondition(invoice) &&
          issueDate.isAfter(startOfYear) &&
          issueDate.isBefore(endOfYear)) {
        int day = issueDate.month - 1;
        dailyInvoiceCount[day] = (dailyInvoiceCount[day] ?? 0) + 1;
      }
    }
    return dailyInvoiceCount;
  }

  Future<LineChartBarData> getLineChartBarDataForCurrentYear({
    required WidgetRef ref,
    required BuildContext context,
    required bool Function(InVoiceModel) filterCondition,
    required Color barColor,
    required String countName,
  }) async {
    Map<int, int> dailyInvoiceCount = await getDailyInvoiceCountForCurrentYear(
      ref,
      context,
      filterCondition,
    );

    int totalCount = dailyInvoiceCount.values.fold(0, (sum, count) => sum + count);

    if (countName == 'paid') {
      updateInvoiceCounts(paidCount: totalCount);
    } else if (countName == 'due') {
      updateInvoiceCounts(dueCount: totalCount);
    } else {
      updateInvoiceCounts(overdueCount: totalCount);
    }

    List<FlSpot> spots = dailyInvoiceCount.entries.map((entry) {
      return FlSpot(entry.key.toDouble(), entry.value.toDouble());
    }).toList();

    return LineChartBarData(
      isCurved: true,
      color: barColor,
      barWidth: 2,
      isStrokeCapRound: true,
      dotData: const FlDotData(show: false),
      belowBarData: BarAreaData(show: false),
      spots: spots,
    );
  }
}

class InvoiceReportCounts {
  int paidCount;
  int dueCount;
  int overdueCount;

  InvoiceReportCounts(
    this.paidCount,
    this.dueCount,
    this.overdueCount,
  );
}
