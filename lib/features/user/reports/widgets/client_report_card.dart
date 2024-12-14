import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:invoice_producer/commons/common_imports/common_libs.dart';
import 'package:invoice_producer/features/user/reports/controller/client_report_controller.dart';
import 'package:invoice_producer/features/user/reports/controller/customer_controller.dart';
import 'package:invoice_producer/features/user/reports/widgets/circle_chart.dart';
import 'package:invoice_producer/features/user/reports/widgets/custom_container.dart';
import 'package:invoice_producer/features/user/reports/widgets/report_custom_drop_down.dart';
import 'package:invoice_producer/features/user/reports/widgets/searched_user.dart';
import 'package:invoice_producer/models/customer_model/customer_model.dart';
import '../../../../commons/common_widgets/cached_retangular_network_image.dart';
import '../../dashboard/controller/dashboard_notifiar_ctr.dart';
import '../helper/count_widgets.dart';

class ClientReportCard extends ConsumerStatefulWidget {
  final String header;
  final bool lineGraph;

  const ClientReportCard({
    super.key,
    required this.header,
    required this.lineGraph,
  });

  @override
  ConsumerState<ClientReportCard> createState() => _ReportCardState();
}

class _ReportCardState extends ConsumerState<ClientReportCard> {
  List<ChartData> chartData = [];
  TextEditingController searchController = TextEditingController();
  String selectedDateFilter = 'This month';

  @override
  void initState() {
    super.initState();
    searchController.addListener(() {
      setState(() {});
    });
  }

  @override
  dispose() {
    searchController.dispose();
    super.dispose();
  }

  init() {
    chartData = [
      ChartData(
        '100',
        ref.watch(clientReportCountsControllerProvider).invoiceCount,
        '100%',
        MyColors.invoiceColor,
      ),
      ChartData(
        '100',
        ref.watch(clientReportCountsControllerProvider).totalAmount.toInt(),
        '100%',
        MyColors.productColor,
      ),
      ChartData(
        '100',
        ref.watch(clientReportCountsControllerProvider).paidAmount.toInt(),
        '100%',
        MyColors.companyColor,
      ),
      ChartData(
        '100',
        ref.watch(clientReportCountsControllerProvider).dueAmount.toInt(),
        '100%',
        MyColors.estimateColor,
      ),
      ChartData('1924',
          ref.watch(clientReportCountsControllerProvider).overdueAmount.toInt(),
          '100%', MyColors.customerColor),
    ];
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    final dashBoardCtr = ref.watch(dashBoardNotifierCtr);
    CustomerModel? selectedCustomer =
        ref.watch(customerNotifierCtr).customerModel;
    init();
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(
              width: 1.w, color: context.bodyTextColor.withOpacity(.3))),
      child: Padding(
        padding: EdgeInsets.all(8.r),
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
                  selectedValue: selectedDateFilter,
                  itemValues: const ['This week', 'This month', 'This year'],
                  onChanged: (value){
                    setState(() {
                      selectedDateFilter = value!;
                    });
                    final currency = ref.read(dashBoardNotifierCtr).currencyTypeEnum?.name ?? 'USD';
                    if (value == 'This week') {
                      ref.read(clientReportCountsControllerProvider
                          .notifier)
                          .currentWeekDetail(toCurrency: currency);
                    }  else  if (value == 'This month') {
                      ref.read(clientReportCountsControllerProvider
                          .notifier)
                          .currentMonthDetail(toCurrency: currency);
                    }  else  if (value == 'This year') {
                      ref.read(clientReportCountsControllerProvider
                          .notifier)
                          .currentYearDetail(toCurrency: currency);
                    }
                  },
                ),
              ],
            ),
            SearchedUser(
              searchController: searchController,
            ),
            if (selectedCustomer != null)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CachedRectangularNetworkImageWidget(
                          image: selectedCustomer.image, width: 36, height: 36),
                      SizedBox(
                        width: 10.w,
                      ),
                      Text(
                        selectedCustomer.name,
                        overflow: TextOverflow.ellipsis,
                        style: getSemiBoldStyle(
                            fontSize: MyFonts.size14,
                            color: context.titleColor),
                      ),
                    ],
                  ),
                  IconButton(
                      onPressed: () {
                        final customerNotifierProvider =
                            ref.read(customerNotifierCtr.notifier);
                        customerNotifierProvider.setCustomerModelData(null);
                      },
                      icon: Icon(Icons.close_rounded))
                ],
              ),
            CircleChart(
                chartData: chartData,
                children: [
              CustomContainer(
                color: MyColors.invoiceColor,
                text: 'Total invoice',
                value: ref.watch(clientReportCountsControllerProvider).invoiceCount.toString(),
              ),
              CustomContainer(
                color: MyColors.productColor,
                text: 'Total amount',
                value: '${dashBoardCtr.currencyTypeEnum?.type}${ref.watch(clientReportCountsControllerProvider).totalAmount.toStringAsFixed(2)}',
              ),
              CustomContainer(
                color: MyColors.companyColor,
                text: 'Paid',
                value: '${dashBoardCtr.currencyTypeEnum?.type}${ref.watch(clientReportCountsControllerProvider).paidAmount.toStringAsFixed(2)}',
              ),
              CustomContainer(
                color: MyColors.estimateColor,
                text: 'Due',
                value: '${dashBoardCtr.currencyTypeEnum?.type}${ref.watch(clientReportCountsControllerProvider).dueAmount.toStringAsFixed(2)}',
              ),
              CustomContainer(
                color: MyColors.customerColor,
                text: 'Overdue',
                value: '${ref.watch(clientReportCountsControllerProvider).overdueAmount.toInt()}',
              ),
            ])
          ],
        ),
      ),
    );
  }
}
