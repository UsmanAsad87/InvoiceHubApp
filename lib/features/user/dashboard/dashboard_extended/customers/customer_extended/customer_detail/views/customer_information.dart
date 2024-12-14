import 'package:invoice_producer/features/user/dashboard/dashboard_extended/customers/customer_extended/customer_detail/widgets/information_card.dart';
import 'package:invoice_producer/utils/constants/app_constants.dart';
import '../../../../../../../../commons/common_imports/common_libs.dart';
import '../../../../../../../../models/customer_model/customer_model.dart';

class CustomerInformation extends StatelessWidget {
  final CustomerModel customer;
  const CustomerInformation({Key? key, required this.customer}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(AppConstants.padding),
      decoration: BoxDecoration(
          color: context.whiteColor,
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(color: context.containerColor, width: 1.w)),
      child:  Padding(
        padding: EdgeInsets.symmetric(vertical: 8.0,horizontal: 12),
        child: Column(
          children: [
            InformationCard(title: 'Company name', subTitle:customer.companyName),
            InformationCard(title: 'Email', subTitle: customer.email),
            InformationCard(title: 'Contact number', subTitle: customer.phoneNo),
            InformationCard(title: 'Billing address', subTitle: customer.billingAddress1),
            // InformationCard(title: 'work address', subTitle: customer.workingAddress1),
            InformationCard(title: 'Note', subTitle: customer.note),
          ],
        ),
      ),
    );
  }
}
