class ShopNoticeBoardModel{
  final String shopId;
  final String shopNoticeBoardId;
  final String title;
  final String description;

//<editor-fold desc="Data Methods">
  const ShopNoticeBoardModel({
    required this.shopId,
    required this.shopNoticeBoardId,
    required this.title,
    required this.description,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ShopNoticeBoardModel &&
          runtimeType == other.runtimeType &&
          shopId == other.shopId &&
          shopNoticeBoardId == other.shopNoticeBoardId &&
          title == other.title &&
          description == other.description);

  @override
  int get hashCode => shopId.hashCode ^shopNoticeBoardId.hashCode ^ title.hashCode ^ description.hashCode;

  @override
  String toString() {
    return 'ShopNoticeBoardModel{ shopId: $shopId, shopNoticeBoardId: $shopNoticeBoardId, title: $title, description: $description,}';
  }

  ShopNoticeBoardModel copyWith({
    String? shopId,
    String? shopNoticeBoardId,
    String? title,
    String? description,
  }) {
    return ShopNoticeBoardModel(
      shopId: shopId ?? this.shopId,
      shopNoticeBoardId: shopNoticeBoardId ?? this.shopNoticeBoardId,
      title: title ?? this.title,
      description: description ?? this.description,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'shopId': shopId,
      'shopNoticeBoardId': shopNoticeBoardId,
      'title': title,
      'description': description,
    };
  }

  factory ShopNoticeBoardModel.fromMap(Map<String, dynamic> map) {
    return ShopNoticeBoardModel(
      shopId: map['shopId'] as String,
      shopNoticeBoardId: map['shopNoticeBoardId'] as String,
      title: map['title'] as String,
      description: map['description'] as String,
    );
  }

//</editor-fold>
}