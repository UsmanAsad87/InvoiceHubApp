class PromoCodeModel{
  final String id;
  final String promoCode;
  final DateTime createdtAt;
  final DateTime expirey;
  final double percentage;

//<editor-fold desc="Data Methods">
  const PromoCodeModel({
    required this.id,
    required this.promoCode,
    required this.createdtAt,
    required this.expirey,
    required this.percentage,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PromoCodeModel &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          promoCode == other.promoCode &&
          createdtAt == other.createdtAt &&
          expirey == other.expirey &&
          percentage == other.percentage);

  @override
  int get hashCode =>
      id.hashCode ^
      promoCode.hashCode ^
      createdtAt.hashCode ^
      expirey.hashCode ^
      percentage.hashCode;

  @override
  String toString() {
    return 'PromoCodeModel{' +
        ' id: $id,' +
        ' promoCode: $promoCode,' +
        ' createdtAt: $createdtAt,' +
        ' expirey: $expirey,' +
        ' percentage: $percentage,' +
        '}';
  }

  PromoCodeModel copyWith({
    String? id,
    String? promoCode,
    DateTime? createdtAt,
    DateTime? expirey,
    double? percentage,
  }) {
    return PromoCodeModel(
      id: id ?? this.id,
      promoCode: promoCode ?? this.promoCode,
      createdtAt: createdtAt ?? this.createdtAt,
      expirey: expirey ?? this.expirey,
      percentage: percentage ?? this.percentage,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'promoCode': this.promoCode,
      'createdtAt': this.createdtAt.millisecondsSinceEpoch,
      'expirey': this.expirey.millisecondsSinceEpoch,
      'percentage': this.percentage,
    };
  }

  factory PromoCodeModel.fromMap(Map<String, dynamic> map) {
    return PromoCodeModel(
      id: map['id'] as String,
      promoCode: map['promoCode'] as String,
      createdtAt: DateTime.fromMillisecondsSinceEpoch(map['createdtAt']),
      expirey: DateTime.fromMillisecondsSinceEpoch(map['expirey']),
      percentage: map['percentage'] as double,
    );
  }

//</editor-fold>
}