import 'package:invoice_producer/models/auth_models/daily_availability_model.dart';

String getTodayWorkTime(List<DailyAvailabilityModel> availabilityList) {
  // Get the current day of the week (1 for Monday, 7 for Sunday)
  int currentDay = DateTime.now().weekday;

  // Find the DailyAvailabilityModel for the current day
  DailyAvailabilityModel todayAvailability = availabilityList[currentDay - 1];

  // Check if today is marked as available
  if (todayAvailability.isAvailable) {
    // Format the work start and end times
    String workStartTime = formatTime(todayAvailability.workStartTime);
    String workEndTime = formatTime(todayAvailability.workEndTime);

    return '$workStartTime - $workEndTime';
  } else {
    return 'Day off';
  }
}

String formatTime(DateTime dateTime) {
  String period = dateTime.hour < 12 ? 'AM' : 'PM';
  int hour = dateTime.hour % 12 == 0 ? 12 : dateTime.hour % 12;
  int minute = dateTime.minute;

  return '$hour:${minute.toString().padLeft(2, '0')} $period';
}







