import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:invoice_producer/commons/common_imports/common_libs.dart';
import 'package:invoice_producer/commons/common_widgets/cached_circular_network_image.dart';
import 'package:invoice_producer/core/enums/invoice_status_enum.dart';
import 'package:invoice_producer/models/invoice_model/invoice_model.dart';
import 'package:invoice_producer/routes/route_manager.dart';
import 'package:invoice_producer/utils/constants/app_constants.dart';
import 'package:invoice_producer/utils/constants/assets_manager.dart';
import 'package:open_file/open_file.dart';
import 'package:pdf/pdf.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../commons/common_functions/date_time_methods.dart';
import '../../../../commons/common_widgets/cached_retangular_network_image.dart';
import '../../invoice/invoiceExended/select_template/controller/pdf_generator.dart';
import '../controller/dashboard_notifiar_ctr.dart';

class InvoiceCard extends StatelessWidget {
  InvoiceCard({super.key, this.isDue, this.invoice});

  bool? isDue;
  InVoiceModel? invoice;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (invoice!.invoiceStatusEnum?.name == InvoiceStatusEnum.draft.name) {
          Navigator.pushNamed(context, AppRoutes.singDraftleInvoiceScreen,
              arguments: {'invoice': invoice});
        } else {
          Navigator.pushNamed(context, AppRoutes.singleInvoiceScreen,
              arguments: {'invoice': invoice});
        }
      },
      child: Container(
        width: double.infinity,
        height: 95.h,
        margin: EdgeInsets.only(bottom: 10.h),
        padding: EdgeInsets.all(8.h),
        decoration: BoxDecoration(
            color: context.whiteColor,
            // color: context.scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(color: context.containerColor, width: 1.w)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                invoice?.customer?.image.isNotEmpty ?? false
                    ? CachedRectangularNetworkImageWidget(
                        image: invoice!.customer?.image ?? '',
                        width: 76,
                        height: 76)
                    : Container(
                        width: 76.w,
                        height: 76.h,
                        padding: EdgeInsets.all(8.h),
                        decoration: BoxDecoration(
                            color: context.greenColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8.r),
                            border: Border.all(
                                color: context.containerColor, width: 1.w)),
                        child: Image.asset(
                          AppAssets.profileIcon,
                          color: context.greenColor,
                        ),
                      ),
                SizedBox(
                  width: 10.w,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      invoice?.customer?.name ?? '',
                      style: getSemiBoldStyle(
                          fontSize: MyFonts.size14, color: context.titleColor),
                    ),
                    Row(
                      children: [
                        CachedCircularNetworkImageWidget(
                            image: invoice?.company?.logo ?? '', size: 20),
                        SizedBox(
                          width: 5.w,
                        ),
                        Text(
                          invoice?.company?.name ?? '',
                          style: getRegularStyle(
                              fontSize: MyFonts.size14,
                              color: context.titleColor),
                        ),
                      ],
                    ),
                    Consumer(
                      builder:
                          (BuildContext context, WidgetRef ref, Widget? child) {
                        final dashBoardCtr = ref.watch(dashBoardNotifierCtr);

                        return Text(
                          '${invoice?.currency?.type}${(invoice?.total ?? 0)}',
                          // '${dashBoardCtr.currencyTypeEnum?.type}${(invoice?.total ?? 0)}',
                          style: getRegularStyle(
                              fontSize: MyFonts.size12,
                              color: context.bodyTextColor),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (!(invoice?.isDraft ?? true))
                  Consumer(builder: (context, ref, child) {
                    return PopupMenuButton<String>(
                      onSelected: (value) async {
                        final generatedFile = await PdfGenerator.generatePdf(
                          ref: ref,
                          index: 1,
                          invoice: invoice!,
                          color: const PdfColor.fromInt(0xFFC1DCEF),
                        );
                        if (value == 'Share') {
                          await Share.shareXFiles(
                            [
                              XFile(generatedFile.path),
                            ],
                            text: '${invoice?.paymentAccount?.accountType}'
                                ' \n ${invoice?.paymentAccount?.accountNo}',
                          );
                        } else {
                          await OpenFile.open(generatedFile.path);
                        }
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                      elevation: 2,
                      itemBuilder: (BuildContext context) =>
                          <PopupMenuEntry<String>>[
                        PopupMenuItem<String>(
                          value: 'Share',
                          height: 30.h,
                          padding: EdgeInsets.only(left: 15.w, right: 30.w),
                          child: Row(
                            children: [
                              Image.asset(AppAssets.editProductIcon,
                                  width: 16.w, height: 16.h),
                              SizedBox(width: 8.w),
                              Text(
                                'Share',
                                style: getMediumStyle(
                                    color: context.titleColor,
                                    fontSize: MyFonts.size14),
                              ),
                            ],
                          ),
                        ),
                        PopupMenuItem<String>(
                          value: 'Download',
                          height: 30.h,
                          padding: EdgeInsets.only(left: 15.w, right: 40.w),
                          child: Row(
                            children: [
                              Icon(
                                Icons.download_outlined,
                                size: 24.r,
                              ),
                              SizedBox(width: 8.w),
                              Text(
                                'Download',
                                style: getMediumStyle(
                                    color: context.titleColor,
                                    fontSize: MyFonts.size14),
                              ),
                            ],
                          ),
                        ),
                      ],
                      child: Container(
                        color: context.scaffoldBackgroundColor,
                        padding: EdgeInsets.symmetric(
                            horizontal: 0.w, vertical: 10.h),
                        child: Image.asset(AppAssets.moreVertIcon,
                            width: 18.w,
                            height: 18.h,
                            color: context.titleColor),
                      ),
                    );
                  }),
                if (isDue != null)
                  Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 0.h, horizontal: 8.w),
                    decoration: BoxDecoration(
                      color: !isDue! ? MyColors.orange : MyColors.green,
                      borderRadius: BorderRadius.circular(6.r),
                    ),
                    child: Text(
                      !isDue! ? "Due" : 'Paid',
                      style: getLightStyle(
                          fontSize: MyFonts.size10, color: context.whiteColor),
                    ),
                  ),
                if (isDue != null)
                  Text(
                    formatDayMonthYear(invoice!.issueDate),
                    style: getLightStyle(
                        fontSize: MyFonts.size14, color: context.bodyTextColor),
                  ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
