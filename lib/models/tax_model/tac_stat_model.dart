class TaxStatModel{
  final bool isEnabled;

//<editor-fold desc="Data Methods">
  const TaxStatModel({
    required this.isEnabled,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TaxStatModel &&
          runtimeType == other.runtimeType &&
          isEnabled == other.isEnabled);

  @override
  int get hashCode => isEnabled.hashCode;

  @override
  String toString() {
    return 'TaxStatModel{' + ' isEnabled: $isEnabled,' + '}';
  }

  TaxStatModel copyWith({
    bool? isEnabled,
  }) {
    return TaxStatModel(
      isEnabled: isEnabled ?? this.isEnabled,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'isEnabled': this.isEnabled,
    };
  }

  factory TaxStatModel.fromMap(Map<String, dynamic> map) {
    return TaxStatModel(
      isEnabled: map['isEnabled'] as bool,
    );
  }

//</editor-fold>
}