import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:invoice_producer/core/enums/date_filter_type.dart';
import 'package:invoice_producer/features/user/invoice/controller/invoice_upload_controller.dart';
import 'package:invoice_producer/features/user/reports/widgets/custom_menu_button.dart';
import 'package:invoice_producer/features/user/reports/widgets/report_card.dart';
import 'package:invoice_producer/utils/constants/app_constants.dart';
import '../../../../commons/common_imports/common_libs.dart';
import '../../../../utils/constants/assets_manager.dart';
import '../../dashboard/controller/dashboard_notifiar_ctr.dart';
import '../../dashboard/controller/states_controller.dart';
import '../../dashboard/dashboard_extended/company/controller/comany_controller.dart';
import '../../dashboard/dashboard_extended/customers/controller/customer_controller.dart';
import '../../main_menu/controller/main_menu_controller.dart';
import '../../products/controller/productController.dart';
import '../controller/count_controller.dart';
import '../controller/date_filter_provider.dart';
import '../controller/invoice_report_count.dart';
import '../widgets/client_report_card.dart';
import '../widgets/custom_container.dart';

class ReportsScreen extends ConsumerStatefulWidget {
  const ReportsScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends ConsumerState<ReportsScreen> {
  String? selectedReport;
  List<String> itemValues = ['PDF', 'CSV'];
  String? basicReportValue;
  var countsController;

  @override
  void initState() {
    init();
    super.initState();
  }

  init() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      countsController = ref.watch(countsControllerProvider.notifier);
      final int? invoiceCount = await ref.watch(
          getSpecificInvoicesCountProvider(DateFilterType.monthly).future);
      final int? productCount = await ref
          .watch(getFilterProductCountProvider(DateFilterType.monthly).future);
      final int? companyCount = await ref
          .watch(getFilterCompanyCountProvider(DateFilterType.monthly).future);
      final int? customerCount = await ref
          .watch(getFilterCustomerCountProvider(DateFilterType.monthly).future);

      if (invoiceCount != null ||
          productCount != null ||
          companyCount != null ||
          customerCount != null) {
        countsController.updateCounts(
            invoiceCount: invoiceCount,
            productCount: productCount,
            companyCount: companyCount,
            customerCount: customerCount);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final dashBoardCtr = ref.watch(dashBoardNotifierCtr);

    return WillPopScope(
      onWillPop: () async {
        final mainMenuCtr = ref.watch(mainMenuProvider);
        mainMenuCtr.setIndex(0);
        return false;
      },
      child: Scaffold(
        backgroundColor: context.scaffoldBackgroundColor,
        appBar: AppBar(
          backgroundColor: context.scaffoldBackgroundColor,
          leading: Consumer(builder: (context, ref, child) {
            final mainMenuCtr = ref.watch(mainMenuProvider);
            return IconButton(
              onPressed: () {
                mainMenuCtr.setIndex(0);
              },
              icon: Image.asset(AppAssets.backArrowIcon,
                  width: 20.w, height: 20.h, color: context.titleColor),
            );
          }),
          title: Text(
            'Reports',
            style: getLibreBaskervilleBoldStyle(
                color: context.titleColor, fontSize: MyFonts.size16),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(AppConstants.padding),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CustomMenuButton(
                      text: 'Download report',
                      itemValues: itemValues,
                      selectedReport: selectedReport,
                    ),
                  ],
                ),
                ReportCard(
                  header: 'Basic report',
                  lineGraph: false,
                  selectedValue: basicReportValue,
                  onChanged: (value) async {
                    setState(() {
                      basicReportValue = value;
                    });
                    _handleDateFilterChange(basicReportValue!);
                  },
                  customContainers: [
                    CustomContainer(
                      color: MyColors.invoiceColor,
                      text: 'Invoice',
                      value: ref
                          .watch(countsControllerProvider)
                          .invoiceCount
                          .toString(),
                    ),
                    CustomContainer(
                      color: MyColors.productColor,
                      text: 'products',
                      value: ref
                          .watch(countsControllerProvider)
                          .productCount
                          .toString(),
                      // value: '30',
                    ),
                    CustomContainer(
                      color: MyColors.companyColor,
                      text: 'Company',
                      value: ref
                          .watch(countsControllerProvider)
                          .companyCount
                          .toString(),
                    ),
                    CustomContainer(
                      color: MyColors.estimateColor,
                      text: 'Estimate',
                      value: ref
                          .watch(getAllInvoiceAmountProvider(
                              getFilterType(basicReportValue)))
                          .when(
                              data: (totalAmount) =>
                                  '${dashBoardCtr.currencyTypeEnum?.type} ${totalAmount.toStringAsFixed(2)}',
                              error: (e, s) => '',
                              loading: () => ''),
                      // ref.watch(getAllInvoicesProvider).when(
                      //       loading: () => '0',
                      //       error: (error, stack) => '0',
                      //       data: (invoices) {
                      //         double paidAmount = invoices
                      //             .where((invoice) => !invoice.isDraft!)
                      //             .fold(0.0, (sum, invoice) =>
                      //                     sum + (invoice.paid ?? 0));
                      //
                      //         return '${dashBoardCtr.currencyTypeEnum?.type}$paidAmount';
                      //       },
                      //     ),
                    ),
                    CustomContainer(
                      color: MyColors.customerColor,
                      text: 'Customers',
                      value: ref
                          .watch(countsControllerProvider)
                          .customerCount
                          .toString(),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.h,
                ),
                ReportCard(
                  header: 'Invoice report',
                  lineGraph: true,
                  customContainers: [
                    CustomContainer(
                      color: MyColors.companyColor,
                      text: 'paid',
                      value: ref
                          .watch(invoiceCountsControllerProvider)
                          .paidCount
                          .toStringAsFixed(2),

                      // value: '10'
                    ),
                    CustomContainer(
                      color: MyColors.productColor,
                      text: 'Due',
                      value: ref
                          .watch(invoiceCountsControllerProvider)
                          .dueCount
                          .toStringAsFixed(2),
                    ),
                    CustomContainer(
                      color: MyColors.overdueColor,
                      text: 'Overdue',
                      value: ref
                          .watch(invoiceCountsControllerProvider)
                          .overdueCount
                          .toStringAsFixed(0),
                      // value: '10'
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.h,
                ),
                const ClientReportCard(
                  header: 'Client report',
                  lineGraph: false,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _handleDateFilterChange(String value) async {
    DateFilterType filterType = getFilterType(value);

    ref.watch(selectedDateFilterProvider.notifier).updateDateFilter(filterType);
    final int? invoiceCount =
        await ref.watch(getSpecificInvoicesCountProvider(filterType).future);
    final int? productCount =
        await ref.watch(getFilterProductCountProvider(filterType).future);
    final int? companyCount =
        await ref.watch(getFilterCompanyCountProvider(filterType).future);
    final int? customerCount = await ref
        .watch(getFilterCustomerCountProvider(DateFilterType.monthly).future);

    if (invoiceCount != null ||
        productCount != null ||
        companyCount != null ||
        customerCount != null) {
      countsController.updateCounts(
          invoiceCount: invoiceCount,
          productCount: productCount,
          companyCount: companyCount,
          customerCount: customerCount);
    }
    ref.invalidate(getAllInvoiceAmountProvider(filterType));
  }

  getFilterType(value) {
    switch (value) {
      case 'This week':
        return DateFilterType.weekly;
      case 'This month':
        return DateFilterType.monthly;
      default:
        return DateFilterType.yearly;
    }
  }
}
