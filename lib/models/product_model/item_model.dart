import 'package:invoice_producer/core/enums/currency_sign_enum.dart';
import 'package:invoice_producer/core/enums/product_type.dart';

class ItemModel {
  final String itemId;
  final ProductType itemType;
  final String name;
  final String description;
  final double unit;
  final double rate;
  final CurrencySignEnum currency;
  // final double discountRate;
  final double tax;
  final double finalRate;
  final String image;
  final String stockQuantity;
  final String productAvailability;
  final bool availability;
  double? soldQuantity;

  // double? shippingCost;
  DateTime? date;
  final Map<String, dynamic> searchTag;

  ItemModel({
    required this.itemId,
    required this.itemType,
    required this.name,
    required this.description,
    required this.unit,
    required this.rate,
    required this.currency,
    // required this.discountRate,
    required this.tax,
    required this.finalRate,
    required this.image,
    required this.stockQuantity,
    required this.availability,
    required this.productAvailability,
    required this.searchTag,
    this.soldQuantity,
    // this.shippingCost,
    this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      'itemId': itemId,
      'itemType': itemType.mode,
      'name': name,
      'description': description,
      'unit': unit,
      'rate': rate,
      'currency': currency.name,
      // 'discountRate': discountRate,
      'tax': tax,
      'finalRate': finalRate,
      'image': image,
      'stockQuantity': stockQuantity,
      'availability': availability,
      'productAvailability': productAvailability,
      'searchTag': searchTag,
      'soldQuantity': soldQuantity,
      //   'shippingCost' : shippingCost,
      'date': DateTime.now(),
    };
  }

  factory ItemModel.fromMap(Map<String, dynamic> map) {
    return ItemModel(
      itemId: map['itemId'],
      itemType: (map['itemType'] as String).toProductType(),
      name: map['name'],
      description: map['description'],
      unit: map['unit'] ?? 0.0,
      rate: map['rate'] ?? 0.0,
      currency: map['currency'] == null
          ? CurrencySignEnum.USD
          :  getCurrencySign((map['currency'] as String)),
      //   discountRate: map['discountRate'] ?? 0.0,
      tax: map['tax'],
      finalRate: map['finalRate'] ?? 0.0,
      image: map['image'],
      stockQuantity: map['stockQuantity'],
      availability: map['availability'] ?? false,
      productAvailability: map['productAvailability'] ?? '',
      searchTag: map['searchTag'] ?? {},
      soldQuantity: map['soldQuantity'],
      //  shippingCost: map['shippingCost']
    );
  }

  ItemModel copyWith({
    String? itemId,
    ProductType? itemType,
    String? name,
    String? description,
    double? unit,
    double? rate,
    CurrencySignEnum? currency,
    double? discountRate,
    double? tax,
    double? finalRate,
    String? image,
    String? stockQuantity,
    String? productAvailability,
    bool? availability,
    double? soldQuantity,
    //  double? shippingCost,
    Map<String, dynamic>? searchTag,
  }) {
    return ItemModel(
      itemId: itemId ?? this.itemId,
      itemType: itemType ?? this.itemType,
      name: name ?? this.name,
      description: description ?? this.description,
      unit: unit ?? this.unit,
      rate: rate ?? this.rate,
      currency: currency ?? this.currency,
      //  discountRate: discountRate ?? this.discountRate,
      tax: tax ?? this.tax,
      finalRate: finalRate ?? this.finalRate,
      image: image ?? this.image,
      stockQuantity: stockQuantity ?? this.stockQuantity,
      availability: availability ?? this.availability,
      productAvailability: productAvailability ?? this.productAvailability,
      soldQuantity: soldQuantity ?? this.soldQuantity,
      //  shippingCost: shippingCost ?? this.shippingCost,
      searchTag: searchTag ?? this.searchTag,
    );
  }
}
