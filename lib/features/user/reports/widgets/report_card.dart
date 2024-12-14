import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:invoice_producer/commons/common_imports/common_libs.dart';
import 'package:invoice_producer/commons/common_widgets/custom_search_fields.dart';
import 'package:invoice_producer/core/enums/account_type.dart';
import 'package:invoice_producer/features/user/dashboard/dashboard_extended/company/controller/comany_controller.dart';
import 'package:invoice_producer/features/user/dashboard/dashboard_extended/customers/controller/customer_controller.dart';
import 'package:invoice_producer/features/user/invoice/controller/invoice_upload_controller.dart';
import 'package:invoice_producer/features/user/products/controller/productController.dart';
import 'package:invoice_producer/features/user/reports/controller/invoice_report_count.dart';
import 'package:invoice_producer/features/user/reports/helper/line_graph_helper.dart';
import 'package:invoice_producer/features/user/reports/widgets/circle_chart.dart';
import 'package:invoice_producer/features/user/reports/widgets/custom_container.dart';
import 'package:invoice_producer/features/user/reports/widgets/report_custom_drop_down.dart';
import 'package:invoice_producer/features/user/reports/widgets/searched_user.dart';
import 'package:invoice_producer/utils/constants/app_constants.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../core/enums/date_filter_type.dart';
import '../../../../models/invoice_model/invoice_model.dart';
import '../controller/count_controller.dart';
import '../controller/date_filter_provider.dart';
import '../helper/count_widgets.dart';

class ReportCard extends ConsumerStatefulWidget {
  String header;
  CustomSearchField? search;
  bool lineGraph;
  List<CustomContainer> customContainers;
  void Function(String?)? onChanged;
  String? selectedValue;

  ReportCard(
      {super.key,
      required this.header,
      required this.customContainers,
      required this.lineGraph,
      this.onChanged,
      this.selectedValue,
      this.search});

  @override
  ConsumerState<ReportCard> createState() => _ReportCardState();
}

class _ReportCardState extends ConsumerState<ReportCard> {
  List<ChartData> chartData = [];
  LineChartBarData paidChartLineData = LineChartBarData();
  LineChartBarData dueChartLineData = LineChartBarData();
  LineChartBarData overdueChartLineData = LineChartBarData();
  String invoiceReportValue = 'This month';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      fetchDataForSelectedFilter(invoiceReportValue);
    });
  }

  // paidLindeData() async {
  //   paidChartLineData = await ref
  //       .read(invoiceCountsControllerProvider.notifier)
  //       .getLineChartBarDataForMonth(
  //         ref: ref,
  //         context: context,
  //         filterCondition: (invoice) => invoice.isPaid == true,
  //         countName: 'paid',
  //         barColor: MyColors.companyColor,
  //       );
  //   setState(() {});
  // }
  //
  // dueLindeData() async {
  //   dueChartLineData = await ref
  //       .read(invoiceCountsControllerProvider.notifier)
  //       .getLineChartBarDataForMonth(
  //         ref: ref,
  //         context: context,
  //         filterCondition: (invoice) => invoice.isPaid == false,
  //         countName: 'due',
  //         barColor: MyColors.productColor,
  //       );
  //   setState(() {});
  // }
  //
  // overdueLindeData() async {
  //   overdueChartLineData = await ref
  //       .read(invoiceCountsControllerProvider.notifier)
  //       .getLineChartBarDataForMonth(
  //         ref: ref,
  //         context: context,
  //         filterCondition: (invoice) =>
  //             invoice.isPaid == false &&
  //             invoice.dueDate.isBefore(DateTime.now()),
  //         countName: 'overDue',
  //         barColor: MyColors.overdueColor,
  //       );
  //   setState(() {});
  // }

  init() {
    chartData = [
      ChartData(
        '1925',
        ref.watch(countsControllerProvider).invoiceCount,
        '100%',
        MyColors.invoiceColor,
      ),
      ChartData(
        '1924',
        ref.watch(countsControllerProvider).productCount,
        '100%',
        MyColors.productColor,
      ),
      ChartData(
        '1926',
        ref.watch(countsControllerProvider).companyCount,
        '100%',
        MyColors.companyColor,
      ),
      ChartData(
        '1925',
        ref.watch(getAllInvoicesProvider).when(
              loading: () => 0,
              error: (error, stack) => 0,
              data: (invoices) {
                // Calculate the paid amount from invoices and convert it to a string
                double paidAmount = invoices
                    .where((invoice) => !invoice.isDraft!)
                    .fold(0.0, (sum, invoice) => sum + (invoice.paid ?? 0));
                return paidAmount.toInt();
              },
            ),
        //2,
        '100%',
        MyColors.estimateColor,
      ),
      ChartData('1924', ref.watch(countsControllerProvider).customerCount,
          '100%', MyColors.customerColor),
    ];
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    init();
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(
              width: 1.0, color: context.bodyTextColor.withOpacity(.3))),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    widget.header,
                    style: getBoldStyle(fontSize: 16, color: MyColors.black),
                  ),
                ),
                ReportCustomDropDown(
                  selectedValue: widget.selectedValue ?? invoiceReportValue,
                  itemValues: const ['This week', 'This month', 'This year'],
                  onChanged: widget.onChanged ??
                      (value) async {
                        _handleInvoiceDateFilterChange(value!);
                        fetchDataForSelectedFilter(value!);
                      },
                ),
              ],
            ),
            widget.lineGraph
                ? Column(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                            vertical: AppConstants.paddingVertical),
                        height: 250.h,
                        width: double.infinity,
                        child: LineChart(
                          LineChartData(
                            lineTouchData: LineGraphHelper().lineTouchData1,
                            gridData: LineGraphHelper().gridData,
                            titlesData: LineGraphHelper().titlesData1(ref: ref),
                            borderData: LineGraphHelper().borderData,
                            lineBarsData: [
                              paidChartLineData,
                              dueChartLineData,
                              overdueChartLineData
                            ],
                            minX: 0,
                            maxX: getMaxValue(
                                ref.watch(selectedInvoiceDateFilterProvider)),
                            maxY: 100,
                            minY: 0,
                          ),
                        ),
                      ),
                      GridView(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 3,
                                crossAxisSpacing: 14,
                                mainAxisSpacing: 12),
                        children: widget.customContainers,
                      )
                    ],
                  )
                : CircleChart(
                    chartData: chartData,
                    children: widget.customContainers,
                  )
          ],
        ),
      ),
    );
  }

  Future<void> fetchDataForSelectedFilter(String selectedFilter) async {
    invoiceReportValue = selectedFilter;

    switch (selectedFilter) {
      case 'This week':
        await fetchAndSetChartData(
          filterCondition: (invoice) => invoice.isPaid == false,
          countName: 'due',
          barColor: MyColors.productColor,
          dataGetter: (ref, context) => ref
              .watch(invoiceCountsControllerProvider.notifier)
              .getLineChartBarDataForCurrentWeek(
                ref: ref,
                context: context,
                filterCondition: (invoice) => invoice.isPaid == false,
                countName: 'due',
                barColor: MyColors.productColor,
              ),
        );
        await fetchAndSetChartData(
          filterCondition: (invoice) =>
              invoice.isPaid == false &&
              invoice.dueDate.isBefore(DateTime.now()),
          countName: 'overDue',
          barColor: MyColors.overdueColor,
          dataGetter: (ref, context) => ref
              .watch(invoiceCountsControllerProvider.notifier)
              .getLineChartBarDataForCurrentWeek(
                ref: ref,
                context: context,
                filterCondition: (invoice) =>
                    invoice.isPaid == false &&
                    invoice.dueDate.isBefore(DateTime.now()),
                countName: 'overDue',
                barColor: MyColors.overdueColor,
              ),
        );
        await fetchAndSetChartData(
          filterCondition: (invoice) => invoice.isPaid == true,
          countName: 'paid',
          barColor: MyColors.companyColor,
          dataGetter: (ref, context) => ref
              .watch(invoiceCountsControllerProvider.notifier)
              .getLineChartBarDataForCurrentWeek(
                ref: ref,
                context: context,
                filterCondition: (invoice) => invoice.isPaid == true,
                countName: 'paid',
                barColor: MyColors.companyColor,
              ),
        );
        break;
      case 'This month':
        await fetchAndSetChartData(
          filterCondition: (invoice) => invoice.isPaid == false,
          countName: 'due',
          barColor: MyColors.productColor,
          dataGetter: (ref, context) => ref
              .watch(invoiceCountsControllerProvider.notifier)
              .getLineChartBarDataForMonth(
                ref: ref,
                context: context,
                filterCondition: (invoice) => invoice.isPaid == false,
                countName: 'due',
                barColor: MyColors.productColor,
              ),
        );

        await fetchAndSetChartData(
          filterCondition: (invoice) =>
              invoice.isPaid == false &&
              invoice.dueDate.isBefore(DateTime.now()),
          countName: 'overDue',
          barColor: MyColors.overdueColor,
          dataGetter: (ref, context) => ref
              .watch(invoiceCountsControllerProvider.notifier)
              .getLineChartBarDataForMonth(
                ref: ref,
                context: context,
                filterCondition: (invoice) =>
                    invoice.isPaid == false &&
                    invoice.dueDate.isBefore(DateTime.now()),
                countName: 'overDue',
                barColor: MyColors.overdueColor,
              ),
        );

        await fetchAndSetChartData(
          filterCondition: (invoice) => invoice.isPaid == true,
          countName: 'paid',
          barColor: MyColors.companyColor,
          dataGetter: (ref, context) => ref
              .watch(invoiceCountsControllerProvider.notifier)
              .getLineChartBarDataForMonth(
                ref: ref,
                context: context,
                filterCondition: (invoice) => invoice.isPaid == true,
                countName: 'paid',
                barColor: MyColors.companyColor,
              ),
        );
        break;
      case 'This year':
        await fetchAndSetChartData(
          filterCondition: (invoice) => invoice.isPaid == false,
          countName: 'due',
          barColor: MyColors.productColor,
          dataGetter: (ref, context) => ref
              .watch(invoiceCountsControllerProvider.notifier)
              .getLineChartBarDataForCurrentYear(
                ref: ref,
                context: context,
                filterCondition: (invoice) => invoice.isPaid == false,
                countName: 'due',
                barColor: MyColors.productColor,
              ),
        );
        await fetchAndSetChartData(
          filterCondition: (invoice) =>
              invoice.isPaid == false &&
              invoice.dueDate.isBefore(DateTime.now()),
          countName: 'overDue',
          barColor: MyColors.overdueColor,
          dataGetter: (ref, context) => ref
              .watch(invoiceCountsControllerProvider.notifier)
              .getLineChartBarDataForCurrentYear(
                ref: ref,
                context: context,
                filterCondition: (invoice) =>
                    invoice.isPaid == false &&
                    invoice.dueDate.isBefore(DateTime.now()),
                countName: 'overDue',
                barColor: MyColors.overdueColor,
              ),
        );

        await fetchAndSetChartData(
          filterCondition: (invoice) => invoice.isPaid == true,
          countName: 'paid',
          barColor: MyColors.companyColor,
          dataGetter: (ref, context) => ref
              .watch(invoiceCountsControllerProvider.notifier)
              .getLineChartBarDataForCurrentYear(
                ref: ref,
                context: context,
                filterCondition: (invoice) => invoice.isPaid == true,
                countName: 'paid',
                barColor: MyColors.companyColor,
              ),
        );
        break;
      default:
        break;
    }
  }

  double getMaxValue(selectedFilter) {
    switch (selectedFilter) {
      case DateFilterType.weekly:
        return 6;
      case DateFilterType.yearly:
        return 11;
      default:
        return 33;
    }
  }

  Future<void> fetchAndSetChartData({
    required bool Function(InVoiceModel) filterCondition,
    required String countName,
    required Color barColor,
    required Future<LineChartBarData> Function(WidgetRef, BuildContext)
        dataGetter,
  }) async {
    final data = await dataGetter(ref, context);
    setState(() {
      if (countName == 'due') {
        dueChartLineData = data;
      } else if (countName == 'overDue') {
        overdueChartLineData = data;
      } else if (countName == 'paid') {
        paidChartLineData = data;
      }
    });
  }

  void _handleInvoiceDateFilterChange(String value) async {
    DateFilterType filterType;

    switch (value) {
      case 'This week':
        filterType = DateFilterType.weekly;
        break;
      case 'This month':
        filterType = DateFilterType.monthly;
        break;
      default:
        filterType = DateFilterType.yearly;
        break;
    }
    ref
        .watch(selectedInvoiceDateFilterProvider.notifier)
        .updateDateFilter(filterType);
  }
}
