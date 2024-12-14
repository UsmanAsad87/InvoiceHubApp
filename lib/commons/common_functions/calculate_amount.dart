calculateAmount(double amount) {
  final calculatedAmout = (amount * 100).toInt();
  return calculatedAmout.toString();
}

double calculatePercentage({required double percentage,required  double amount}) {
  if (percentage < 0 || percentage > 100) {
    return 0;
  }
  if(percentage ==0.0){
    return 0;
  }
  double result = (percentage / 100) * amount;
  return result;
}
