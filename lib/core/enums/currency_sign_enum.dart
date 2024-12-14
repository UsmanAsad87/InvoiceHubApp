enum CurrencySignEnum {
  USD('\$'),
  EUR('€'),
  GBP('£'),
  INR('₹'),
  BDT('৳'),
  ZAR('R'),
  JPY('¥');

  const CurrencySignEnum(this.type);

  final String type;
}

extension ConvertCurrencySign on String {
  CurrencySignEnum toCurrencySignEnum() {
    switch (this) {
      case '\$':
        return CurrencySignEnum.USD;
      case '€':
        return CurrencySignEnum.EUR;
      case '£':
        return CurrencySignEnum.GBP;
      case '¥':
        return CurrencySignEnum.JPY;
      case '₹':
        return CurrencySignEnum.INR;
      case 'R':
        return CurrencySignEnum.ZAR;
      case '৳':
        return CurrencySignEnum.BDT;
      default:
        return CurrencySignEnum.USD;
    }
  }
}

CurrencySignEnum getCurrencySign(String? val) {
  switch (val) {
    case 'USD':
      return CurrencySignEnum.USD;
    case 'EUR':
      return CurrencySignEnum.EUR;
    case 'GBP':
      return CurrencySignEnum.GBP;
    case 'JPY':
      return CurrencySignEnum.JPY;
    case 'INR':
      return CurrencySignEnum.INR;
    case 'ZAR':
      return CurrencySignEnum.ZAR;
    case 'BDT':
      return CurrencySignEnum.BDT;
    default:
      return CurrencySignEnum.USD;
  }
}

String getCurrencySymbol(String? currency) {
  switch (currency) {
    case 'USD':
      return String.fromCharCode(36); // $
    case 'EUR':
      return String.fromCharCode(128); // €
    case 'GBP':
      return String.fromCharCode(163); // £
    case 'JPY':
      return String.fromCharCode(165); // ¥
    case 'INR':
      return  '\u20B9'; // ₹
    case 'BDT':
      return '\u09F3'; // ৳
    case 'ZAR':
      return 'R'; // R ( south africa)
    default:
      return String.fromCharCode(36); // $
  }
}
