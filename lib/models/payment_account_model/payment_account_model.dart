import 'package:invoice_producer/core/enums/account_type.dart';
class PaymentAccountModel {
  final String paymentId;
  final String holderName;
  final AccountTypeEnum accountType;
  final String cardNo;
  final String expireDate;
  final bool isDefault;
  final String cvv;
  final String bankName;
  final String accountNo;
  // final String branchName;
  final String branchAddress;
  final String email;
  final String accountName; // Added field
  final String sortCode;   // Added field

  PaymentAccountModel({
    required this.paymentId,
    required this.holderName,
    required this.accountType,
    required this.cardNo,
    required this.expireDate,
    required this.isDefault,
    required this.cvv,
    required this.bankName,
    required this.accountNo,
    // required this.branchName,
    required this.branchAddress,
    required this.email,
    required this.accountName,
    required this.sortCode,
  });

  factory PaymentAccountModel.fromMap(Map<String, dynamic> map) {
    return PaymentAccountModel(
      paymentId: map['paymentId'],
      holderName: map['holderName'],
      accountType: (map['accountType'] as String).toAccountTypeEnum(),
      cardNo: map['cardNo'],
      expireDate: map['expiryDate'],
      isDefault: map['isDefault'],
      cvv: map['cvv'],
      bankName: map['bankName'],
      accountNo: map['accountNo'],
      // branchName: map['branchName'],
      branchAddress: map['branchAddress'],
      email: map['email'],
      accountName: map['accountName'],
      sortCode: map['sortCode'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'paymentId': paymentId,
      'holderName': holderName,
      'accountType': accountType.type,
      'cardNo': cardNo,
      'expiryDate': expireDate,
      'isDefault': isDefault,
      'cvv': cvv,
      'bankName': bankName,
      'accountNo': accountNo,
      // 'branchName': branchName,
      'branchAddress': branchAddress,
      'email': email,
      'accountName': accountName,
      'sortCode': sortCode,
    };
  }

  PaymentAccountModel copyWith({
    String? paymentId,
    String? holderName,
    AccountTypeEnum? accountType,
    String? cardNo,
    String? expiryDate,
    bool? isDefault,
    String? cvv,
    String? bankName,
    String? accountNo,
    String? branchName,
    String? branchAddress,
    String? email,
    String? accountName,
    String? sortCode,
  }) {
    return PaymentAccountModel(
      paymentId: paymentId ?? this.paymentId,
      holderName: holderName ?? this.holderName,
      accountType: accountType ?? this.accountType,
      cardNo: cardNo ?? this.cardNo,
      expireDate: expiryDate ?? this.expireDate,
      isDefault: isDefault ?? this.isDefault,
      cvv: cvv ?? this.cvv,
      bankName: bankName ?? this.bankName,
      accountNo: accountNo ?? this.accountNo,
      // branchName: branchName ?? this.branchName,
      branchAddress: branchAddress ?? this.branchAddress,
      email: email ?? this.email,
      accountName: accountName ?? this.accountName,
      sortCode: sortCode ?? this.sortCode,
    );
  }
}




//
// class PaymentAccountModel {
//   final String paymentId;
//   final holderName;
//   final AccountTypeEnum accountType;
//   final String cardNo;
//   final String expireDate;
//   final bool isDefault;
//   final String cvv;
//   final String bankName;
//   final String accountNo;
//   final String branchName;
//   final String branchAddress;
//   final String email;
//
//   PaymentAccountModel({
//     required this.paymentId,
//     required this.holderName,
//     required this.accountType,
//     required this.cardNo,
//     required this.expireDate,
//     required this.isDefault,
//     required this.cvv,
//     required this.bankName,
//     required this.accountNo,
//     required this.branchName,
//     required this.branchAddress,
//     required this.email,
//   });
//
//   factory PaymentAccountModel.fromMap(Map<String, dynamic> map) {
//     return PaymentAccountModel(
//       paymentId: map['paymentId'],
//       holderName: map['holderName'],
//       accountType: (map['accountType'] as String).toAccountTypeEnum(),
//       cardNo: map['cardNo'],
//       expireDate: map['expiryDate'],
//       isDefault: map['isDefault'],
//       cvv: map['cvv'],
//       bankName: map['bankName'],
//       accountNo: map['accountNo'],
//       branchName: map['branchName'],
//       branchAddress: map['branchAddress'],
//       email: map['email'],
//     );
//   }
//
//   Map<String, dynamic> toMap() {
//     return {
//       'paymentId': paymentId,
//       'holderName': holderName,
//       'accountType': accountType.type,
//       'cardNo': cardNo,
//       'expiryDate': expireDate,
//       'isDefault': isDefault,
//       'cvv': cvv,
//       'bankName': bankName,
//       'accountNo': accountNo,
//       'branchName': branchName,
//       'branchAddress': branchAddress,
//       'email': email,
//     };
//   }
//
//   PaymentAccountModel copyWith({
//     String? paymentId,
//     String? holderName,
//     AccountTypeEnum? accountType,
//     String? cardNo,
//     String? expiryDate,
//     bool? isDefault,
//     String? cvv,
//     String? bankName,
//     String? accountNo,
//     String? branchName,
//     String? branchAddress,
//     String? email,
//   }) {
//     return PaymentAccountModel(
//       paymentId: paymentId ?? this.paymentId,
//       holderName: holderName ?? this.holderName,
//       accountType: accountType ?? this.accountType,
//       cardNo: cardNo ?? this.cardNo,
//       expireDate: expiryDate ?? this.expireDate,
//       isDefault: isDefault ?? this.isDefault,
//       cvv: cvv ?? this.cvv,
//       bankName: bankName ?? this.bankName,
//       accountNo: accountNo ?? this.accountNo,
//       branchName: branchName ?? this.branchName,
//       branchAddress: branchAddress ?? this.branchAddress,
//       email: email ?? this.email,
//     );
//   }
// }
