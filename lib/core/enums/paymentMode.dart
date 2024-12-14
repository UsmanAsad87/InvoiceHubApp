enum PaymentModeEnum{
  FullPayment('FullPayment'),
  Deposit('Deposit');


  const PaymentModeEnum(this.mode);
  final String mode;
}

// using an extension
// enhanced enums
extension ConvertPaymentModeEnum on String{
  PaymentModeEnum toPaymentModeEnum(){
    switch(this){
      case 'FullPayment':
        return PaymentModeEnum.FullPayment;
      case 'Deposit':
        return PaymentModeEnum.Deposit;
      default:
        return PaymentModeEnum.FullPayment;
    }
  }
}