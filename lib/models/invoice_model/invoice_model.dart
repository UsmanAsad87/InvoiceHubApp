import 'package:invoice_producer/core/enums/addreess_type.dart';
import 'package:invoice_producer/core/enums/currency_sign_enum.dart';
import 'package:invoice_producer/core/enums/invoice_status_enum.dart';
import 'package:invoice_producer/models/company_models/company_model.dart';
import 'package:invoice_producer/models/payment_account_model/payment_account_model.dart';
import 'package:invoice_producer/models/signature_model/signature_model.dart';

import '../customer_model/customer_model.dart';
import '../product_model/item_model.dart';

class InVoiceModel {
  final String? logo;
  final String? invoiceNo;
  final DateTime issueDate;
  final DateTime dueDate;
  final String termsAndCond;
  final List<ItemModel>? items;
  final CustomerModel? customer;
  final CompanyModel? company;
  final SignatureModel? signature;
  final PaymentAccountModel? paymentAccount;
  final List<String>? workSamples;
  final String? image;
  final double? subTotal;
  final double? shippingCost;
  final double? discount;
  final double? tax;
  final double? total;
  final double? paid;
  final double? dueBalance;
  final bool? isDraft;
  final bool? isPaid;
  final double? depositAmount;
  final String? notes;
  // final String? jobAddress;
  final CurrencySignEnum? currency;
  final Map<String, dynamic>? searchTags;
  final InvoiceStatusEnum? invoiceStatusEnum;
  final AddressTypeEnum? addressType;
  final String? addressLine1;
  final String? addressLine2;

  InVoiceModel(
      {this.invoiceNo,
      required this.issueDate,
      required this.dueDate,
      required this.termsAndCond,
      this.logo,
      this.items,
      this.customer,
      this.company,
      this.signature,
      this.paymentAccount,
      this.workSamples,
      this.image,
      this.subTotal,
      this.shippingCost,
      this.discount,
      this.tax,
      this.total,
      this.paid,
      this.dueBalance,
      this.isDraft,
      this.depositAmount,
      this.notes,
      // this.jobAddress,
      this.invoiceStatusEnum,
      this.currency,
      this.isPaid,
      this.searchTags,
       this.addressType,
      this.addressLine1,
      this.addressLine2});

  // Named constructor to create an instance from a map
  factory InVoiceModel.fromMap(Map<String, dynamic> map) {
    return InVoiceModel(
      invoiceNo: map['invoiceNo'] ?? '',
      depositAmount: map['depositAmount'] ?? 0.0,
      notes: map['notes'] ?? '',
      // jobAddress: map['jobAddress'] ?? '',
      invoiceStatusEnum: map['invoiceStatusEnum'] != null
          ? (map['invoiceStatusEnum'] as String).toInvoiceStatusEnum()
          : InvoiceStatusEnum.unpaid,
      issueDate: map['issueDate'].toDate(),
      dueDate: map['dueDate'].toDate(),
      termsAndCond: map['termsAndCond'] ?? '',
      items: map['items'] != null
          ? List<ItemModel>.from(map['items']?.map((x) => ItemModel.fromMap(x)))
          : null,
      customer: map['customer'] != null
          ? CustomerModel.fromMap(map['customer'])
          : null,
      company:
          map['company'] != null ? CompanyModel.fromMap(map['company']) : null,
      signature: map['signature'] != null
          ? SignatureModel.fromMap(map['signature'])
          : null,
      paymentAccount: map['paymentAccount'] != null
          ? PaymentAccountModel.fromMap(map['paymentAccount'])
          : null,
      workSamples: map['workSamples'] != null
          ? List<String>.from(map['workSamples'] ?? [])
          : null,
      image: map['image'] ?? '',
      subTotal: map['subTotal']?.toDouble(),
      shippingCost: map['shippingCost']?.toDouble(),
      discount: map['discount']?.toDouble(),
      tax: map['tax']?.toDouble(),
      total: map['total']?.toDouble(),
      paid: map['paid']?.toDouble(),
      dueBalance: map['dueBalance']?.toDouble(),
      isDraft: map['isDraft'],
      currency: map['currency'] == null
          ? CurrencySignEnum.USD
          : getCurrencySign(map['currency']),
      searchTags: map['searchTags'],
      isPaid: map['isPaid'],
      addressType: map['addressType'] == null ? null : (map['addressType'] as String?)?.toAddressTypeEnum(),
      addressLine1: map['addressLine1'],
      addressLine2: map['addressLine2'],
    );
  }

  // Method to convert an instance to a map
  Map<String, dynamic> toMap() {
    return {
      'invoiceNo': invoiceNo,
      'issueDate': issueDate,
      'dueDate': dueDate,
      'depositAmount': depositAmount,
      'notes': notes,
      // 'jobAddress': jobAddress,
      'invoiceStatusEnum': invoiceStatusEnum?.name,
      'termsAndCond': termsAndCond,
      'items': items?.map((x) => x.toMap()).toList(),
      'customer': customer?.toMap(),
      'company': company?.toMap(),
      'signature': signature?.toMap(),
      'paymentAccount': paymentAccount?.toMap(),
      'workSamples': workSamples,
      'image': image,
      'subTotal': subTotal,
      'shippingCost': shippingCost,
      'discount': discount,
      'tax': tax,
      'total': total,
      'paid': paid,
      'dueBalance': dueBalance,
      'isDraft': isDraft,
      'currency': currency?.name,
      'isPaid': isPaid,
      'searchTags': searchTags,
      'addressType': addressType?.type,
      'addressLine1': addressLine1,
      'addressLine2': addressLine2,
    };
  }

  // CopyWith method for easy modification of an instance
  InVoiceModel copyWith({
    String? invoiceNo,
    DateTime? issueDate,
    DateTime? dueDate,
    String? termsAndCond,
    List<ItemModel>? items,
    CustomerModel? customer,
    CompanyModel? company,
    SignatureModel? signature,
    PaymentAccountModel? paymentAccount,
    List<String>? workSamples,
    String? image,
    double? subTotal,
    double? shippingCost,
    double? discount,
    double? tax,
    double? total,
    double? paid,
    double? dueBalance,
    bool? isDraft,
    bool? isPaid,
    double? depositAmount,
    String? notes,
    // String? jobAddress,
    CurrencySignEnum? currency,
    InvoiceStatusEnum? invoiceStatusEnum,
    Map<String, dynamic>? searchTags,
    AddressTypeEnum? addressType,
    String? addressLine1,
    String? addressLine2,
  }) {
    return InVoiceModel(
      invoiceNo: invoiceNo ?? this.invoiceNo,
      issueDate: issueDate ?? this.issueDate,
      dueDate: dueDate ?? this.dueDate,
      termsAndCond: termsAndCond ?? this.termsAndCond,
      items: items ?? this.items,
      customer: customer ?? this.customer,
      company: company ?? this.company,
      signature: signature ?? this.signature,
      paymentAccount: paymentAccount ?? this.paymentAccount,
      workSamples: workSamples ?? this.workSamples,
      image: image ?? this.image,
      subTotal: subTotal ?? this.subTotal,
      shippingCost: shippingCost ?? this.shippingCost,
      discount: discount ?? this.discount,
      tax: tax ?? this.tax,
      total: total ?? this.total,
      paid: paid ?? this.paid,
      dueBalance: dueBalance ?? this.dueBalance,
      isDraft: isDraft ?? this.isDraft,
      isPaid: isPaid ?? this.isPaid,
      depositAmount: depositAmount ?? this.depositAmount,
      notes: notes ?? this.notes,
      // jobAddress: jobAddress ?? this.jobAddress,
      currency: currency ?? this.currency,
      invoiceStatusEnum: invoiceStatusEnum ?? this.invoiceStatusEnum,
      searchTags: searchTags ?? this.searchTags,
      addressType: addressType ?? this.addressType,
      addressLine1: addressLine1 ?? this.addressLine1,
      addressLine2: addressLine2 ?? this.addressLine2,
    );
  }
}
