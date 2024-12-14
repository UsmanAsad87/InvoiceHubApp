import 'package:image_picker/image_picker.dart';
import 'package:invoice_producer/commons/common_functions/currency_converter.dart';
import 'package:invoice_producer/models/invoice_model/invoice_model.dart';
import 'package:invoice_producer/models/payment_account_model/payment_account_model.dart';
import '../../../../commons/common_imports/apis_commons.dart';
import '../../../../commons/common_imports/common_libs.dart';
import '../../../../core/enums/addreess_type.dart';
import '../../../../core/enums/currency_sign_enum.dart';
import '../../../../models/customer_model/customer_model.dart';
import '../../../../models/product_model/item_model.dart';
import '../../../../models/signature_model/signature_model.dart';

final invoiceDataProvider =
    ChangeNotifierProvider.autoDispose((ref) => InvoiceController());

class InvoiceController extends ChangeNotifier {
  CustomerModel? _customerModel;
  InVoiceModel? _inVoiceModel;
  SignatureModel? _signatureModel;
  PaymentAccountModel? _paymentModel;
  List<ItemModel>? _productList = <ItemModel>[];
  List<XFile>? _workSamples;
  double _dueAmount = 0;
  double _paidAmount = 0;
  double _discount = 0;
  double _shipping = 0;
  double _deposit = 0;
  double _subTotal = 0;
  double _totalTax = 0;
  CurrencySignEnum? _selectedCurrency;
  AddressTypeEnum? _selectedAddressType;
  bool _sameAsBilling = false;
  final addressLine2Controller = TextEditingController();
  final addressLine1Controller = TextEditingController();

  CustomerModel? get customerModel => _customerModel;

  InVoiceModel? get invoiceModel => _inVoiceModel;

  SignatureModel? get signatureModel => _signatureModel;

  PaymentAccountModel? get paymentModel => _paymentModel;

  List<ItemModel>? get productList => _productList;

  List<XFile>? get workSamples => _workSamples;

  double get dueAmount => (_dueAmount) + _deposit;

  double get paidAmount => (_paidAmount) + _deposit;

  double get subTotal => _subTotal;

  double get shippingCost => _shipping;

  double get discount => _discount;

  double get total => ((_subTotal + _totalTax) - getDisCount) + (_shipping);

  double get totalTax => _totalTax;

  AddressTypeEnum? get selectAddressType => _selectedAddressType;

  bool get sameAsBilling => _sameAsBilling;

  double get getDisCount =>
      _discount == 0 ? 0 : ((_subTotal * _discount) / 100);

  CurrencySignEnum? get selectedCurrency => _selectedCurrency;

  clear() {
    _customerModel = null;
    _inVoiceModel = null;
    _signatureModel = null;
    _paymentModel = null;
    _productList = null;
    _workSamples = null;
    _dueAmount = 0;
    _paidAmount = 0;
    _discount = 0;
    _shipping = 0;
    _deposit = 0;
    _subTotal = 0;
    _totalTax = 0;
    _selectedCurrency = null;
    _sameAsBilling = false;
    _selectedAddressType = null;
    addressLine1Controller.dispose();
    addressLine2Controller.dispose();
    notifyListeners();
  }

  setValues({required InVoiceModel inVoiceModel}) {
    _dueAmount = inVoiceModel.dueBalance ?? 0;
    _paidAmount = inVoiceModel.paid ?? 0;
    _discount = inVoiceModel.discount ?? 0;
    _shipping = inVoiceModel.shippingCost ?? 0;
    _subTotal = inVoiceModel.subTotal ?? 0;
    _customerModel = inVoiceModel.customer;
    _inVoiceModel = inVoiceModel;
    _signatureModel = inVoiceModel.signature;
    _paymentModel = inVoiceModel.paymentAccount;
    _productList = inVoiceModel.items;
    _selectedCurrency = inVoiceModel.currency;
    _selectedAddressType = inVoiceModel.addressType;
    addressLine1Controller.text = inVoiceModel.addressLine1 ?? '';
    addressLine2Controller.text = inVoiceModel.addressLine2 ?? '';
    notifyListeners();
  }

  setAddressType({AddressTypeEnum? addressType}) {
    _selectedAddressType = addressType;
    notifyListeners();
  }

  setAddressAsBilling(bool sameAsBilling) {
    _sameAsBilling = sameAsBilling;
    notifyListeners();
  }

  setBillToData({CustomerModel? customer}) {
    _customerModel = customer;
    notifyListeners();
  }

  setInVoiceInFoData({InVoiceModel? invoice}) {
    _inVoiceModel = invoice;
    notifyListeners();
  }

  setInSignatureData({SignatureModel? signature}) {
    _signatureModel = signature;
    notifyListeners();
  }

  setPaymentAccountData({PaymentAccountModel? paymentAcc}) {
    _paymentModel = paymentAcc;
    notifyListeners();
  }

  setProductData({required ItemModel model}) async {
    _productList ??= <ItemModel>[];
    _productList!.add(model);
    await calculateTotal();
    // notifyListeners();
  }

  updateProductData({required ItemModel model}) async {
    _productList ??= <ItemModel>[];
    _productList![_productList!
        .indexWhere((item) => item.itemId == model.itemId)] = model;
    await calculateTotal();
    // notifyListeners();
  }

  addDiscount({required double discount}) {
    _discount = discount;
    notifyListeners();
  }

  addShippingCost({required double shippingCost}) {
    _shipping = shippingCost;
    notifyListeners();
  }

  addDeposit({
    required double newDeposit,
  }) {
    _deposit = newDeposit;
    notifyListeners();
  }

  calculateTotal() async {
    double subTotal = 0;
    double tax = 0;
    for (ItemModel item in _productList!) {
      final double itemRate = item.currency == selectedCurrency
          ? item.rate
          : await CurrencyConverter().convertCurrency(
              fromCurrency: item.currency.name,
              toCurrency: selectedCurrency?.name ?? CurrencySignEnum.USD.name,
              amount: item.rate);
      subTotal += itemRate * item.soldQuantity!;
      tax += (item.tax * item.soldQuantity!) / item.rate * 100;
    }
    _subTotal = subTotal;
    _totalTax = tax;
    notifyListeners();
  }

  setWorkSamples({required List<XFile> workSamples}) {
    _workSamples = workSamples;
    notifyListeners();
  }

  setCurrency({required CurrencySignEnum currency}) {
    _selectedCurrency = currency;
    notifyListeners();
  }
}
