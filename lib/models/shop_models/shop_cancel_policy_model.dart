class ShopCancelPoilcyModel {
  final String shopId;
  final String shopCancelationPolicyId;
  final int hoursBefore;

//<editor-fold desc="Data Methods">
  const ShopCancelPoilcyModel({
    required this.shopId,
    required this.shopCancelationPolicyId,
    required this.hoursBefore,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ShopCancelPoilcyModel &&
          runtimeType == other.runtimeType &&
          shopId == other.shopId &&
          shopCancelationPolicyId == other.shopCancelationPolicyId &&
          hoursBefore == other.hoursBefore);

  @override
  int get hashCode => shopId.hashCode ^ shopCancelationPolicyId.hashCode ^ hoursBefore.hashCode;

  @override
  String toString() {
    return 'ShopCancelPoilcyModel{ shopId: $shopId, shopCancelationPolicyId: $shopCancelationPolicyId, hoursBefore: $hoursBefore,}';
  }

  ShopCancelPoilcyModel copyWith({
    String? shopId,
    int? hoursBefore,
  }) {
    return ShopCancelPoilcyModel(
      shopId: shopId ?? this.shopId,
      shopCancelationPolicyId: shopCancelationPolicyId ?? shopCancelationPolicyId,
      hoursBefore: hoursBefore ?? this.hoursBefore,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'shopId': shopId,
      'shopCancelationPolicyId': shopCancelationPolicyId,
      'hoursBefore': hoursBefore,
    };
  }

  factory ShopCancelPoilcyModel.fromMap(Map<String, dynamic> map) {
    return ShopCancelPoilcyModel(
      shopId: map['shopId'] as String,
      shopCancelationPolicyId: map['shopCancelationPolicyId'] as String,
      hoursBefore: map['hoursBefore'] as int,
    );
  }

//</editor-fold>
}
