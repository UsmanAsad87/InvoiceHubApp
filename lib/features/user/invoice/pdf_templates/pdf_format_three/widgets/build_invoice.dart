import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:invoice_producer/core/enums/currency_sign_enum.dart';
import 'package:invoice_producer/features/user/invoice/common_functions/calculate_single_product_total.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import '../../../../../../models/invoice_model/invoice_model.dart';
import '../../../../dashboard/controller/dashboard_notifiar_ctr.dart';

Widget buildInvoice({
  required InVoiceModel invoice,
  required WidgetRef ref,
}) {
  // final dashBoardCtr = ref.watch(dashBoardNotifierCtr);
  final headers = [
    // 'No',
    'Description',
    'Quantity',
    'Price',
    'discount',
    'Total'
  ];
  // int i = 1;
  final data = invoice.items?.map((item) {
    final currency = getCurrencySymbol(invoice.currency?.name);
    return [
      '${item.name}\n${item.description}',
      '${item.soldQuantity!.toInt()}',
      '$currency ${item.finalRate}',
      '',
   //   '${item.discountRate}%',
      '$currency ${calculateSingleProductTotal(
          finalRate: item.finalRate,
      //    discount: item.discountRate,
      //    shippingCost: item.shippingCost!,
          soldQuantity: item.soldQuantity!)}',
    ];
  }).toList();

  // Function to conditionally set cell decoration
  cellDecoration(int rowIndex, dynamic cellValue, int colIndex) {
    if (cellValue == '') {
      return BoxDecoration(
        color: const PdfColor.fromInt(0x00FFFFFF),
        border: Border.all(
          width: 0,
        ),
      );
    }
    return const BoxDecoration();
  }

  return Table.fromTextArray(
    headers: headers,
    data: data!,
    cellDecoration: cellDecoration,
    border: const TableBorder(
      top: BorderSide.none,
      bottom: BorderSide.none,
      right: BorderSide.none,
      left: BorderSide.none,
    ),
    headerDecoration: const BoxDecoration(
        border: Border(bottom: BorderSide(width: 1, color: PdfColors.black))),
    headerStyle: TextStyle(letterSpacing: 3.w),
    cellHeight: 30,
    cellAlignments: {
      0: Alignment.centerLeft,
      1: Alignment.center,
      2: Alignment.center,
      3: Alignment.center,
      4: Alignment.center,
      5: Alignment.center,
      6: Alignment.center,
      // 7: Alignment.center,
    },
  );
}
