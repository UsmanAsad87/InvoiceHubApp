class CategoryModel {
  final String catId;
  final String catName;
  final DateTime createdAt;

//<editor-fold desc="Data Methods">
  const CategoryModel({
    required this.catId,
    required this.catName,
    required this.createdAt,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CategoryModel &&
          runtimeType == other.runtimeType &&
          catId == other.catId &&
          catName == other.catName &&
          createdAt == other.createdAt);

  @override
  int get hashCode => catId.hashCode ^ catName.hashCode ^ createdAt.hashCode;

  @override
  String toString() {
    return 'CategoryModel{ catId: $catId, catName: $catName, createdAt: $createdAt,}';
  }

  CategoryModel copyWith({
    String? catId,
    String? catName,
    DateTime? createdAt,
  }) {
    return CategoryModel(
      catId: catId ?? this.catId,
      catName: catName ?? this.catName,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'catId': catId,
      'catName': catName,
      'createdAt': createdAt.millisecondsSinceEpoch,
    };
  }

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      catId: map['catId'] as String,
      catName: map['catName'] as String,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt']),
    );
  }

//</editor-fold>
}