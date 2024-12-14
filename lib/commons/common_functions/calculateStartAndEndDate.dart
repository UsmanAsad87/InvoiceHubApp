import '../../core/enums/date_filter_type.dart';

/// helper return start
DateTime calculateStartDate({ required DateFilterType filterType}) {
  final currentDate = DateTime.now();
  switch (filterType) {
    case DateFilterType.weekly:
      return currentDate.subtract(Duration(days: currentDate.weekday - 1));
    case DateFilterType.monthly:
      return DateTime(currentDate.year, currentDate.month, 1);
    case DateFilterType.yearly:
      return DateTime(currentDate.year);
    default:
      return currentDate.subtract(const Duration(days: 7));
  }
}

/// helper return end date
DateTime calculateEndDate({required DateFilterType filterType}) {
  final currentDate = DateTime.now();
  switch (filterType) {
    case DateFilterType.weekly:
      return DateTime(currentDate.year, currentDate.month,
          currentDate.day + (DateTime.daysPerWeek - currentDate.weekday));
    case DateFilterType.monthly:
      return DateTime(currentDate.year, currentDate.month,
          DateTime(currentDate.year, currentDate.month + 1, 0).day);
    case DateFilterType.yearly:
      return DateTime(currentDate.year + 1, 1, 0);
    default:
      return currentDate.subtract(const Duration(days: 7));
  }
}