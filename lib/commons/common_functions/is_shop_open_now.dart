import 'package:invoice_producer/models/shop_models/shop_daily_model.dart';
import 'package:intl/intl.dart';

bool isShopOpenNow(List<ShopDailyModel> shopDailyList) {
  // Get the current day name (e.g., "Monday", "Tuesday", etc.)
  DateTime currentTime = DateTime.now();
  String currentDayName = DateFormat('EEEE').format(currentTime);

  ShopDailyModel? currentShopModel = shopDailyList.firstWhere(
        (availability) => availability.dayName == currentDayName,
    orElse: () => ShopDailyModel(
      id: 'Default',
      dayName: currentDayName,
      isOn: false,
      startTime: DateTime(2023, 9, 1, 0, 0),
      endTime: DateTime(2023, 9, 1, 0, 0),
    ),
  );

  if (currentTime.isAfter(currentShopModel.startTime) &&
      currentTime.isBefore(currentShopModel.endTime)) {
    return true;
  }

  return false;
}
