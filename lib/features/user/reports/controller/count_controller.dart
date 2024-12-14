import '../../../../commons/common_imports/apis_commons.dart';

class CountsController extends StateNotifier<Counts> {
  CountsController() : super(Counts(0, 0, 0, 0));

  void updateCounts(
      {int invoiceCount = 0,
      int productCount = 0,
      int customerCount = 0,
      int companyCount = 0}) {
    state = Counts(
      state.invoiceCount = invoiceCount,
      state.productCount = productCount,
      state.customerCount = customerCount,
      state.companyCount = companyCount,
    );
  }
}

class Counts {
  int invoiceCount;
  int productCount;
  int customerCount;
  int companyCount;

  Counts(this.invoiceCount, this.productCount, this.customerCount,
      this.companyCount);
}

final countsControllerProvider =
    StateNotifierProvider<CountsController, Counts>((ref) {
  return CountsController();
});