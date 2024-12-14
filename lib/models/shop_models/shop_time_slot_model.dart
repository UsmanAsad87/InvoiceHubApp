class ShopTimeSlotModel{
  final String shopId;
  final String shopTimeslotId;
  final int timeSlot;

//<editor-fold desc="Data Methods">
  const ShopTimeSlotModel({
    required this.shopId,
    required this.shopTimeslotId,
    required this.timeSlot,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ShopTimeSlotModel &&
          runtimeType == other.runtimeType &&
          shopId == other.shopId &&
          shopTimeslotId == other.shopTimeslotId &&
          timeSlot == other.timeSlot);

  @override
  int get hashCode => shopId.hashCode ^  shopTimeslotId.hashCode ^ timeSlot.hashCode;

  @override
  String toString() {
    return 'ShopTimeSlotModel{ shopId: $shopId, shopTimeslotId: $shopTimeslotId, timeSlot: $timeSlot,}';
  }

  ShopTimeSlotModel copyWith({
    String? shopId,
    String? shopTimeslotId,
    int? timeSlot,
  }) {
    return ShopTimeSlotModel(
      shopId: shopId ?? this.shopId,
      shopTimeslotId: shopTimeslotId ?? this.shopTimeslotId,
      timeSlot: timeSlot ?? this.timeSlot,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'shopId': shopId,
      'shopTimeslotId': shopTimeslotId,
      'timeSlot': timeSlot,
    };
  }

  factory ShopTimeSlotModel.fromMap(Map<String, dynamic> map) {
    return ShopTimeSlotModel(
      shopId: map['shopId'] as String,
      shopTimeslotId: map['shopTimeslotId'] as String,
      timeSlot: map['timeSlot'] as int,
    );
  }

//</editor-fold>
}