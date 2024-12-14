  enum AccountTypeEnum{
    bank('bank'),
    masterCard('masterCard'),
    visa('visa'),
    stripe('stripe'),
    paypal('paypal');


  const AccountTypeEnum(this.type);
  final String type;
}

// using an extension
// enhanced enums
extension ConvertAccountType on String{
  AccountTypeEnum toAccountTypeEnum(){
    switch(this){
      case 'bank':
        return AccountTypeEnum.bank;
      case 'masterCard':
        return AccountTypeEnum.masterCard;
      case 'paypal':
        return AccountTypeEnum.paypal;
      case 'visa':
        return AccountTypeEnum.visa;
      case 'stripe':
        return AccountTypeEnum.stripe;
      default:
        return AccountTypeEnum.bank;
    }
  }
}




// enum AccountTypeEnum{
//   owner('owner'),
//   barber('barber'),
//   user('user');
//
//
//   const AccountTypeEnum(this.type);
//   final String type;
// }
//
// // using an extension
// // enhanced enums
// extension ConvertAccountType on String{
//   AccountTypeEnum toAccountTypeEnum(){
//     switch(this){
//       case 'owner':
//         return AccountTypeEnum.owner;
//       case 'barber':
//         return AccountTypeEnum.barber;
//       case 'user':
//         return AccountTypeEnum.user;
//       default:
//         return AccountTypeEnum.user;
//     }
//   }
// }