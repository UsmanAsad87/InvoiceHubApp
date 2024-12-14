import 'package:invoice_producer/commons/common_functions/padding.dart';
import 'package:invoice_producer/commons/common_imports/common_libs.dart';
import 'package:invoice_producer/features/user/dashboard/dashboard_extended/customers/customer_extended/customer_detail/views/customer_information.dart';
import 'package:invoice_producer/features/user/dashboard/dashboard_extended/customers/customer_extended/customer_detail/views/invoive_history.dart';
import 'package:invoice_producer/features/user/dashboard/dashboard_extended/customers/customer_extended/customer_detail/widgets/tab_button_widget.dart';
import '../../../../../../../../commons/common_imports/apis_commons.dart';
import '../../../../../../../../models/customer_model/customer_model.dart';
import '../../../../../../../../utils/constants/app_constants.dart';
import '../../../../../../../../utils/constants/assets_manager.dart';
import '../../../../mail/widgets/profile_image.dart';

class CustomerDetailScreen extends ConsumerStatefulWidget {
  final CustomerModel customer;
  const CustomerDetailScreen({Key? key, required this.customer}) : super(key: key);

  @override
  ConsumerState<CustomerDetailScreen> createState() =>
      _CustomerDetailScreenState();
}

class _CustomerDetailScreenState extends ConsumerState<CustomerDetailScreen> {

  String selected = 'info';
  late final CustomerModel customer;
  @override
  void initState() {
    customer = widget.customer;
    super.initState();
  }
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
            'Details',
            style: getLibreBaskervilleExtraBoldStyle(
                color: context.titleColor, fontSize: MyFonts.size16),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(children: [
               ProfileImage(
                imgUrl: customer.image,
                name: customer.name,
              ),
              Padding(
                padding: EdgeInsets.all(AppConstants.padding),
                child: Row(
                  children: [
                    TabButtonWidget(
                        isSelected: selected == 'info' ? true : false,
                        buttonText: 'Customer information',
                        onTap: () {
                          setState(() {
                            selected = 'info';
                          });
                        }),
                    TabButtonWidget(
                        isSelected: selected != 'info' ? true : false,
                        buttonText: 'Invoice history',
                        onTap: () {
                          setState(() {
                            selected = 'history';
                          });
                        }),
                    padding8,
                  ],
                ),
              ),
              selected == 'info' ? CustomerInformation(customer : customer) : InvoiceHistory(
                customerId: customer.customerId,
              )
            ])));
  }
}
