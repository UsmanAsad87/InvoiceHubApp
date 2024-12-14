  enum AddressTypeEnum{
    workAddress('Work Address'),
    inspectionAddress('Inspection Address'),
    shippingAddress('Shipping Address'),
    serviceAddress('Service Address');

  const AddressTypeEnum(this.type);
  final String type;
}

extension ConvertAddressType on String {
  AddressTypeEnum toAddressTypeEnum(){
    switch(this){
      case 'Work Address':
        return AddressTypeEnum.workAddress;
      case 'Inspection Address':
        return AddressTypeEnum.inspectionAddress;
      case 'Shipping Address':
        return AddressTypeEnum.shippingAddress;
      case 'Service Address':
        return AddressTypeEnum.serviceAddress;
      default:
        return AddressTypeEnum.workAddress;
    }
  }
}