import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:invoice_producer/models/invoice_model/invoice_model.dart';
import 'package:invoice_producer/utils/constants/app_constants.dart';
import 'package:invoice_producer/utils/themes/styles_manager.dart';

import '../../../../../../../../commons/common_imports/common_libs.dart';
import '../../../../../../../../commons/common_shimmers/list_item_shimmer.dart';
import '../../../../../../invoice/controller/invoice_upload_controller.dart';
import '../../../../../widgets/invoice_card.dart';

class InvoiceHistory extends StatelessWidget {
  final String customerId;

  const InvoiceHistory({Key? key, required this.customerId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List isPaid = [true, true, false, true];
    return Padding(
      padding: EdgeInsets.all(AppConstants.padding),
      child: Consumer(
        builder: (BuildContext context, WidgetRef ref, Widget? child) {
          return ref.watch(getCustomerInvoices(customerId)).when(
            data: (list) {
              return list.isEmpty
                  ? Center(
                      child: Text(
                        'No Invoice found',
                        style: getMediumStyle(color: context.bodyTextColor),
                      ),
                    )
                  : ListView.builder(
                      itemCount: list.length,
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        InVoiceModel model = list[index];
                        return InvoiceCard(
                          isDue: isPaid[index],
                          invoice: model,
                        );
                      });
            },
            error: (error, st) {
              debugPrintStack(stackTrace: st);
              debugPrint(error.toString());
              return ErrorWidget(error);
            },
            loading: () {
              return ListView.builder(
                  itemCount: 3,
                  shrinkWrap: true,
                  itemBuilder: (context, snapshot) {
                    return const ListItemShimmer();
                  });
            },
          );
        },
      ),
    );
  }
}
