import 'package:invoice_producer/models/shop_models/shop_daily_model.dart';

class ShopConfigureModel{
  final String shopConfigId;
  final String shopId;
  final String shopName;
  final String shopLocation;
  final List<ShopDailyModel> shopAvailability;

//<editor-fold desc="Data Methods">
  const ShopConfigureModel({
    required this.shopId,
    required this.shopConfigId,
    required this.shopName,
    required this.shopLocation,
    required this.shopAvailability,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ShopConfigureModel &&
          runtimeType == other.runtimeType &&
          shopId == other.shopId &&
          shopConfigId == other.shopConfigId &&
          shopName == other.shopName &&
          shopLocation == other.shopLocation &&
          shopAvailability == other.shopAvailability);

  @override
  int get hashCode =>
      shopId.hashCode ^
      shopConfigId.hashCode ^
      shopName.hashCode ^
      shopLocation.hashCode ^
      shopAvailability.hashCode;

  @override
  String toString() {
    return 'ShopConfigureModel{ shopId: $shopId, shopConfigId: $shopConfigId, shopName: $shopName, shopLocation: $shopLocation, shopAvailability: $shopAvailability,}';
  }

  ShopConfigureModel copyWith({
    String? shopId,
    String? shopConfigId,
    String? shopName,
    String? shopLocation,
    List<ShopDailyModel>? shopAvailability,
  }) {
    return ShopConfigureModel(
      shopId: shopId ?? this.shopId,
      shopConfigId: shopId ?? this.shopConfigId,
      shopName: shopName ?? this.shopName,
      shopLocation: shopLocation ?? this.shopLocation,
      shopAvailability: shopAvailability ?? this.shopAvailability,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'shopId': shopId,
      'shopConfigId': shopConfigId,
      'shopName': shopName,
      'shopLocation': shopLocation,
      'shopAvailability': shopAvailability.map((e) => e.toMap()).toList(),
    };
  }

  factory ShopConfigureModel.fromMap(Map<String, dynamic> map) {
    return ShopConfigureModel(
      shopId: map['shopId'] as String,
      shopConfigId: map['shopConfigId'] as String,
      shopName: map['shopName'] as String,
      shopLocation: map['shopLocation'] as String,
      shopAvailability: (map['shopAvailability'] as List<dynamic>)
      .map((model)=> ShopDailyModel.fromMap(model)).toList(),
    );
  }

//</editor-fold>
}