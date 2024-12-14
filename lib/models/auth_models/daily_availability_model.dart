class DailyAvailabilityModel {
  final String id;
  final String dayName;
  final bool isAvailable;
  final DateTime workStartTime;
  final DateTime workEndTime;
  final DateTime lunchStartTime;
  final DateTime lunchEndTime;

//<editor-fold desc="Data Methods">
  const DailyAvailabilityModel({
    required this.id,
    required this.dayName,
    required this.isAvailable,
    required this.workStartTime,
    required this.workEndTime,
    required this.lunchStartTime,
    required this.lunchEndTime,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DailyAvailabilityModel &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          dayName == other.dayName &&
          isAvailable == other.isAvailable &&
          workStartTime == other.workStartTime &&
          workEndTime == other.workEndTime &&
          lunchStartTime == other.lunchStartTime &&
          lunchEndTime == other.lunchEndTime);

  @override
  int get hashCode =>
      id.hashCode ^
      dayName.hashCode ^
      isAvailable.hashCode ^
      workStartTime.hashCode ^
      workEndTime.hashCode ^
      lunchStartTime.hashCode ^
      lunchEndTime.hashCode;

  @override
  String toString() {
    return 'DailyAvailabilityModel{ id: $id, dayName: $dayName, isAvailable: $isAvailable, workStartTime: $workStartTime, workEndTime: $workEndTime, lunchStartTime: $lunchStartTime, lunchEndTime: $lunchEndTime,}';
  }

  DailyAvailabilityModel copyWith({
    String? id,
    String? dayName,
    bool? isAvailable,
    DateTime? workStartTime,
    DateTime? workEndTime,
    DateTime? lunchStartTime,
    DateTime? lunchEndTime,
  }) {
    return DailyAvailabilityModel(
      id: id ?? this.id,
      dayName: dayName ?? this.dayName,
      isAvailable: isAvailable ?? this.isAvailable,
      workStartTime: workStartTime ?? this.workStartTime,
      workEndTime: workEndTime ?? this.workEndTime,
      lunchStartTime: lunchStartTime ?? this.lunchStartTime,
      lunchEndTime: lunchEndTime ?? this.lunchEndTime,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'dayName': dayName,
      'isAvailable': isAvailable,
      'workStartTime': workStartTime.millisecondsSinceEpoch,
      'workEndTime': workEndTime.millisecondsSinceEpoch,
      'lunchStartTime': lunchStartTime.millisecondsSinceEpoch,
      'lunchEndTime': lunchEndTime.millisecondsSinceEpoch,
    };
  }

  factory DailyAvailabilityModel.fromMap(Map<String, dynamic> map) {
    return DailyAvailabilityModel(
      id: map['id'] as String,
      dayName: map['dayName'] as String,
      isAvailable: map['isAvailable'] as bool,
      workStartTime: DateTime.fromMillisecondsSinceEpoch(map['workStartTime']),
      workEndTime: DateTime.fromMillisecondsSinceEpoch(map['workEndTime']),
      lunchStartTime: DateTime.fromMillisecondsSinceEpoch(map['lunchStartTime']),
      lunchEndTime: DateTime.fromMillisecondsSinceEpoch(map['lunchEndTime']),
    );
  }

//</editor-fold>
}