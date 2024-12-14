import 'package:invoice_producer/commons/common_imports/common_libs.dart';
import 'package:invoice_producer/commons/common_widgets/common_dropdown.dart';
import 'package:invoice_producer/commons/common_widgets/custom_button.dart';
import 'package:invoice_producer/commons/common_widgets/show_toast.dart';
import 'package:invoice_producer/features/user/dashboard/dashboard_extended/customers/controller/customer_controller.dart';
import 'package:invoice_producer/features/user/invoice/controller/invoice_controller.dart';
import 'package:invoice_producer/utils/constants/app_constants.dart';
import '../../../../../../utils/constants/assets_manager.dart';
import '../../../../../commons/common_imports/apis_commons.dart';
import '../../../../../models/customer_model/customer_model.dart';

class BillToScreen extends ConsumerStatefulWidget {
  const BillToScreen({super.key});

  @override
  ConsumerState<BillToScreen> createState() => _BillToScreenState();
}

class _BillToScreenState extends ConsumerState<BillToScreen> {
  CustomerModel? selectedCustomer;
  String? selectedCustomerName;
  List<String>? customerNames;
  List<CustomerModel>? yourCustomers;

  @override
  void initState() {
    initializeCustomers();
    super.initState();
  }

  initializeCustomers() async {
    final invoiceCtr = ref.read(invoiceDataProvider.notifier);
    yourCustomers = await ref
        .read(customerControllerProvider.notifier)
        .getAllCustomers(context: context)
        .first;
    customerNames = yourCustomers
        ?.map((customer) =>
            (customer.name.isEmpty ? customer.phoneNo : customer.name))
        .toList();
    selectedCustomer = invoiceCtr.invoiceModel?.customer;
    selectedCustomerName = selectedCustomer?.name;
    setState(() {});
  }

  // String? selectedCustomer;
  // List<String> customerList = ['Arlene McCoy', 'Ronald Richards', 'Floyd Miles'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: context.scaffoldBackgroundColor,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Image.asset(AppAssets.backArrowIcon,
              width: 20.w, height: 20.h, color: context.titleColor),
        ),
        title: Text(
          'Bill to',
          style: getLibreBaskervilleExtraBoldStyle(
              color: context.titleColor, fontSize: MyFonts.size16),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(AppConstants.padding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Customer information',
              style: getBoldStyle(color: Colors.black, fontSize: 18),
            ),
            Consumer(
              builder: (BuildContext context, WidgetRef ref, Widget? child) {
                final invoiceCtr = ref.read(invoiceDataProvider.notifier);
                return CommonDropDown(
                    hintText: '',
                    label: 'Customer name',
                    value:
                        invoiceCtr.customerModel?.name ?? selectedCustomerName,
                    valueItems: customerNames ?? [],
                    onChanged: (value) {
                      setState(() {
                        selectedCustomerName = value;
                        selectedCustomer = yourCustomers?.firstWhere(
                          (customer) => customer.name == selectedCustomerName,
                        );
                      });
                    });
              },
            ),
            CustomButton(
                onPressed: () {
                  if (selectedCustomer != null) {
                    ref
                        .read(invoiceDataProvider.notifier)
                        .setBillToData(customer: selectedCustomer!);
                    showSnackBar(
                        context, '${selectedCustomer!.name} is selected');
                  }
                  Navigator.of(context).pop();
                },
                buttonText: "Save")
          ],
        ),
      ),
    );
  }
}
