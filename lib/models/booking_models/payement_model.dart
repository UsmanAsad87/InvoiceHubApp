import 'package:invoice_producer/core/enums/paymentMode.dart';

class PaymentModel{
  final String id;
  final PaymentModeEnum paymentMode;
  final double depositAmount;

//<editor-fold desc="Data Methods">
  const PaymentModel({
    required this.id,
    required this.paymentMode,
    required this.depositAmount,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PaymentModel &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          paymentMode == other.paymentMode &&
          depositAmount == other.depositAmount);

  @override
  int get hashCode =>
      id.hashCode ^ paymentMode.hashCode ^ depositAmount.hashCode;

  @override
  String toString() {
    return 'PaymentModel{ id: $id, paymentMode: $paymentMode, depositAmount: $depositAmount,}';
  }

  PaymentModel copyWith({
    String? id,
    PaymentModeEnum? paymentMode,
    double? depositAmount,
  }) {
    return PaymentModel(
      id: id ?? this.id,
      paymentMode: paymentMode ?? this.paymentMode,
      depositAmount: depositAmount ?? this.depositAmount,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'paymentMode': this.paymentMode.mode,
      'depositAmount': this.depositAmount,
    };
  }

  factory PaymentModel.fromMap(Map<String, dynamic> map) {
    return PaymentModel(
      id: map['id'] as String,
      paymentMode:  (map['paymentMode'] as String).toPaymentModeEnum(),
      depositAmount: map['depositAmount'] as double,
    );
  }

//</editor-fold>
}