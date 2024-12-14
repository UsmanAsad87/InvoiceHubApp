class ServiceModel{
  final String serviceId;
  final String serviceName;
  final String catId;
  final String catName;
  final DateTime createdAt;
  final double price;
  final double serviceTime;

//<editor-fold desc="Data Methods">
  const ServiceModel({
    required this.serviceId,
    required this.serviceName,
    required this.catId,
    required this.catName,
    required this.createdAt,
    required this.price,
    required this.serviceTime,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ServiceModel &&
          runtimeType == other.runtimeType &&
          serviceId == other.serviceId &&
          serviceName == other.serviceName &&
          catId == other.catId &&
          catName == other.catName &&
          createdAt == other.createdAt &&
          price == other.price &&
          serviceTime == other.serviceTime);

  @override
  int get hashCode =>
      serviceId.hashCode ^
      serviceName.hashCode ^
      catId.hashCode ^
      catName.hashCode ^
      createdAt.hashCode ^
      price.hashCode ^
      serviceTime.hashCode;

  @override
  String toString() {
    return 'ServiceModel{ serviceId: $serviceId, serviceName: $serviceName, catId: $catId, catName: $catName, createdAt: $createdAt, price: $price, serviceTime: $serviceTime,}';
  }

  ServiceModel copyWith({
    String? serviceId,
    String? serviceName,
    String? catId,
    String? catName,
    DateTime? createdAt,
    double? price,
    double? serviceTime,
  }) {
    return ServiceModel(
      serviceId: serviceId ?? this.serviceId,
      serviceName: serviceName ?? this.serviceName,
      catId: catId ?? this.catId,
      catName: catName ?? this.catName,
      createdAt: createdAt ?? this.createdAt,
      price: price ?? this.price,
      serviceTime: serviceTime ?? this.serviceTime,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'serviceId': serviceId,
      'serviceName': serviceName,
      'catId': catId,
      'catName': catName,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'price': price,
      'serviceTime': serviceTime,
    };
  }

  factory ServiceModel.fromMap(Map<String, dynamic> map) {
    return ServiceModel(
      serviceId: map['serviceId'] as String,
      serviceName: map['serviceName'] as String,
      catId: map['catId'] as String,
      catName: map['catName'] as String,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt']),
      price: map['price'] as double,
      serviceTime: map['serviceTime'] as double ,
    );
  }

//</editor-fold>
}