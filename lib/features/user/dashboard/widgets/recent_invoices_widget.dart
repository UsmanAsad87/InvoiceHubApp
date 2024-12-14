import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:invoice_producer/commons/common_shimmers/common_shimmer.dart';
import 'package:invoice_producer/commons/common_shimmers/loading_screen_shimmer.dart';
import 'package:invoice_producer/commons/common_shimmers/offers_shimmer.dart';
import 'package:invoice_producer/commons/common_widgets/cached_retangular_network_image.dart';
import 'package:invoice_producer/features/user/dashboard/widgets/invoice_card.dart';
import 'package:invoice_producer/routes/route_manager.dart';
import 'package:invoice_producer/utils/constants/app_constants.dart';

import '../../../../commons/common_imports/common_libs.dart';
import '../../../../commons/common_shimmers/list_item_shimmer.dart';
import '../../../../models/invoice_model/invoice_model.dart';
import '../../../../utils/loading.dart';
import '../../invoice/controller/invoice_upload_controller.dart';

class RecentInvoicesWidget extends ConsumerWidget {
  const RecentInvoicesWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Recent Invoices',
                style: getSemiBoldStyle(
                    color: context.titleColor, fontSize: MyFonts.size16)),
            TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.recentInvoicesSeeMoreScreen);
                },
                child: Text(
                  'See more',
                  style: getRegularStyle(
                      color: context.greenColor, fontSize: MyFonts.size16),
                )),
          ],
        ),
        ref.watch(getAllInvoicesProvider).when(
          data: (invoiceList) {
            return invoiceList.isEmpty
                ? Center(
                    child: Text(
                      'No invoice found',
                      style: getMediumStyle(
                        color: context.titleColor,
                        fontSize: MyFonts.size15,
                      ),
                    ),
                  )
                : ListView.builder(
                    itemCount: invoiceList.length,
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      InVoiceModel invoice = invoiceList[index];
                      return InvoiceCard(
                        isDue: invoice.isPaid ?? false,
                        invoice: invoice,
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
        ),
      ],
    );
  }
}
