String calculateSingleProductTotal({
  required double finalRate,
  required double soldQuantity,
}) {
  double discountRate = 0;
  return (((finalRate - discountRate) * soldQuantity))
      .toStringAsFixed(1);
}
