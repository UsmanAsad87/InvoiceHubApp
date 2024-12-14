import 'package:invoice_producer/commons/common_imports/common_libs.dart';
import 'package:invoice_producer/features/user/dashboard/views/dashboard_screen.dart';
import 'package:invoice_producer/features/user/invoice/views/invoices_screen.dart';
import 'package:invoice_producer/features/user/products/views/products_screen.dart';
import 'package:invoice_producer/features/user/profile/views/profile_screen.dart';
import 'package:invoice_producer/features/user/reports/views/reports_screen.dart';

import '../../../../commons/common_imports/apis_commons.dart';

final mainMenuProvider = ChangeNotifierProvider((ref) => MainMenuController());

class MainMenuController extends ChangeNotifier {
  List<Widget> screens = [
    const DashboardScreen(),
    const ProductsScreen(),
    const InvoicesScreen(),
    const ReportsScreen(),
    const ProfileScreen()
  ];

  int _index = 0;
  int get index => _index;
  setIndex(int id) {
    _index = id;
    notifyListeners();
  }
}
