class ShopDailyModel{
  final String id;
  final String dayName;
  final bool isOn;
  final DateTime startTime;
  final DateTime endTime;

//<editor-fold desc="Data Methods">
  const ShopDailyModel({
    required this.id,
    required this.dayName,
    required this.isOn,
    required this.startTime,
    required this.endTime,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ShopDailyModel &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          dayName == other.dayName &&
          isOn == other.isOn &&
          startTime == other.startTime &&
          endTime == other.endTime);

  @override
  int get hashCode =>
      id.hashCode ^
      dayName.hashCode ^
      isOn.hashCode ^
      startTime.hashCode ^
      endTime.hashCode;

  @override
  String toString() {
    return 'ShopDailyModel{ id: $id, dayName: $dayName, isOn: $isOn, startTime: $startTime, endTime: $endTime,}';
  }

  ShopDailyModel copyWith({
    String? id,
    String? dayName,
    bool? isOn,
    DateTime? startTime,
    DateTime? endTime,
  }) {
    return ShopDailyModel(
      id: id ?? this.id,
      dayName: dayName ?? this.dayName,
      isOn: isOn ?? this.isOn,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'dayName': dayName,
      'isOn': isOn,
      'startTime': startTime.millisecondsSinceEpoch,
      'endTime': endTime.millisecondsSinceEpoch,
    };
  }

  factory ShopDailyModel.fromMap(Map<String, dynamic> map) {
    return ShopDailyModel(
      id: map['id'] as String,
      dayName: map['dayName'] as String,
      isOn: map['isOn'] as bool,
      startTime: DateTime.fromMillisecondsSinceEpoch(map['startTime']),
      endTime: DateTime.fromMillisecondsSinceEpoch(map['endTime']) ,
    );
  }

//</editor-fold>
}