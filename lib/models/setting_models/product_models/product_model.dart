class ProductModel{
  final String id;
  final String productName;
  final DateTime createdAt;
  final String productImage;
  final double price;
  final Map<String, dynamic> searchTags;

//<editor-fold desc="Data Methods">
  const ProductModel({
    required this.id,
    required this.productName,
    required this.createdAt,
    required this.productImage,
    required this.price,
    required this.searchTags,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProductModel &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          searchTags == other.searchTags &&
          productName == other.productName &&
          createdAt == other.createdAt &&
          productImage == other.productImage &&
          price == other.price);

  @override
  int get hashCode =>
      id.hashCode ^
      productName.hashCode ^
      createdAt.hashCode ^
      productImage.hashCode ^
      searchTags.hashCode ^
      price.hashCode;

  @override
  String toString() {
    return 'ProductModel{' +
        ' id: $id,' +
        ' productName: $productName,' +
        ' createdAt: $createdAt,' +
        ' productImage: $productImage,' +
        ' searchTags: $searchTags,' +
        ' price: $price,' +
        '}';
  }

  ProductModel copyWith({
    String? id,
    String? productName,
    DateTime? createdAt,
    String? productImage,
    double? price,
    Map<String, dynamic>? searchTags,
  }) {
    return ProductModel(
      id: id ?? this.id,
      productName: productName ?? this.productName,
      createdAt: createdAt ?? this.createdAt,
      productImage: productImage ?? this.productImage,
      searchTags: searchTags ?? this.searchTags,
      price: price ?? this.price,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'productName': this.productName,
      'createdAt': this.createdAt.millisecondsSinceEpoch,
      'productImage': this.productImage,
      'searchTags': this.searchTags,
      'price': this.price,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id'] as String,
      productName: map['productName'] as String,
      createdAt: DateTime.fromMicrosecondsSinceEpoch(map['createdAt']),
      productImage: map['productImage'] as String,
      searchTags: map['searchTags'] as Map<String, dynamic>,
      price: map['price'] as double,
    );
  }

//</editor-fold>
}