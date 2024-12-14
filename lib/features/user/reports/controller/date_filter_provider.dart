import '../../../../commons/common_imports/apis_commons.dart';
import '../../../../core/enums/date_filter_type.dart';

final selectedDateFilterProvider = StateNotifierProvider<DateFilterController, DateFilterType>((ref) {
  return DateFilterController();
});


class DateFilterController extends StateNotifier<DateFilterType> {
  DateFilterController() : super(DateFilterType.monthly);

  void updateDateFilter(DateFilterType newFilter) {
    state = newFilter;
  }
}

final selectedInvoiceDateFilterProvider = StateNotifierProvider<InvoiceDateFilterController, DateFilterType>((ref) {
  return InvoiceDateFilterController();
});


class InvoiceDateFilterController extends StateNotifier<DateFilterType> {
  InvoiceDateFilterController() : super(DateFilterType.monthly);

  void updateDateFilter(DateFilterType newFilter) {
    state = newFilter;
  }
}