class TaxModel{
  final String taxId;
  final String name;
  final double percentage;

  TaxModel({
    required this.taxId,
    required this.name,
    required this.percentage,
  });

  factory TaxModel.fromMap(Map<String, dynamic> map) {
    return TaxModel(
      taxId: map['taxId'] ?? '',
      name: map['name'] ?? '',
      percentage: (map['amount'] ?? 0.0).toDouble(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'taxId': taxId,
      'name': name,
      'amount': percentage,
    };
  }

  TaxModel copyWith({
    String? taxId,
    String? name,
    double? amount,
  }) {
    return TaxModel(
      taxId: taxId ?? this.taxId,
      name: name ?? this.name,
      percentage: amount ?? this.percentage,
    );
  }
}