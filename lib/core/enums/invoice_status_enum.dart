enum InvoiceStatusEnum{
  paid('paid'),
  draft('draft'),
  unpaid('unpaid');


  const InvoiceStatusEnum(this.type);
  final String type;
}

extension ConvertInvoiceStatus on String{
  InvoiceStatusEnum toInvoiceStatusEnum(){
    switch(this){
      case 'paid':
        return InvoiceStatusEnum.paid;
      case 'draft':
        return InvoiceStatusEnum.draft;
      case 'unpaid':
        return InvoiceStatusEnum.unpaid;
      default:
        return InvoiceStatusEnum.paid;
    }
  }
}
