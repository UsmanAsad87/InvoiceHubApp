import 'package:invoice_producer/models/auth_models/daily_availability_model.dart';
import 'package:invoice_producer/models/shop_models/shop_daily_model.dart';
import 'package:intl/intl.dart';

bool isAvailableNow(List<DailyAvailabilityModel> availabilityList) {
  // Get the current day name (e.g., "Monday", "Tuesday", etc.)
  DateTime currentTime = DateTime.now();
  String currentDayName = DateFormat('EEEE').format(currentTime);

  // Find the DailyAvailabilityModel for the current day
  DailyAvailabilityModel? currentAvailability = availabilityList.firstWhere(
    (availability) => availability.dayName == currentDayName,
    orElse: () => DailyAvailabilityModel(
      id: 'Default',
      dayName: currentDayName,
      isAvailable: false,
      workStartTime: DateTime(2023, 9, 1, 0, 0),
      workEndTime: DateTime(2023, 9, 1, 0, 0),
      lunchStartTime: DateTime(2023, 9, 1, 0, 0),
      lunchEndTime: DateTime(2023, 9, 1, 0, 0),
    ),
  );

  if (currentTime.isAfter(currentAvailability.workStartTime) &&
      currentTime.isBefore(currentAvailability.workEndTime) &&
      (currentTime.isBefore(currentAvailability.lunchStartTime) ||
          currentTime.isAfter(currentAvailability.lunchEndTime))) {
    return true;
  }

  return false;
}

