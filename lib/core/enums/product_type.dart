enum ProductType{
  product('Product'),
  service('Service'),
  work('Work'),
  inspection('Inspection');

  const ProductType(this.mode);
  final String mode;
}

// Using an extension for conversion
extension ConvertItemTypeEnum on String {
  ProductType toProductType() {
    switch (this) {
      case 'Product':
        return ProductType.product;
      case 'Service':
        return ProductType.service;
      case 'Work':
        return ProductType.work;
      case 'Inspection':
        return ProductType.inspection;
      default:
        return ProductType.product;
    }
  }
}