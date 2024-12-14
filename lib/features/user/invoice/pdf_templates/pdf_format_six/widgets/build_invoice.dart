import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:invoice_producer/features/user/invoice/common_functions/calculate_single_product_total.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

import '../../../../../../core/enums/currency_sign_enum.dart';
import '../../../../../../models/invoice_model/invoice_model.dart';
import '../../../../dashboard/controller/dashboard_notifiar_ctr.dart';

Widget buildInvoice(
    {required InVoiceModel invoice,
      required WidgetRef ref,
      required PdfColor color,
    EdgeInsetsGeometry? padding,
    PdfColor? headerTextCol}) {
  // final dashBoardCtr = ref.watch(dashBoardNotifierCtr);
  final currency = getCurrencySymbol(invoice.currency?.name);
  final headers = [
    'ITEM DESCRIPTION',
    'UNIT PRICE',
    'QUANTITY',
    'DISCOUNT',
    'TOTAL:'
  ];

  int i = 1;
  final data = invoice.items?.map((item) {
    final total = item.finalRate * item.unit * (1 + item.rate);
    return [
      '${item.name}\n${item.description}',
      '$currency ${item.finalRate}',
      '${item.soldQuantity?.toInt()}',
      '',
    //  '${item.discountRate}%',
      '$currency ${calculateSingleProductTotal(
          finalRate: item.finalRate,
       //   discount: item.discountRate,
     //     shippingCost: item.shippingCost!,
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

  return Padding(
    padding: padding ?? EdgeInsets.symmetric(horizontal: 30.w, vertical: 12.h),
    child: Table.fromTextArray(
      headers: headers,
      data: data!,

      cellDecoration: cellDecoration,
      border: const TableBorder(
        horizontalInside: BorderSide(width: 1),
        top: BorderSide.none,
        bottom: BorderSide.none,
        right: BorderSide.none,
        left: BorderSide.none,
      ),
      headerStyle: TextStyle(
          fontWeight: FontWeight.bold, color: headerTextCol ?? PdfColors.red),
      // headerCellDecoration: BoxDecoration(color: color),
      // rowDecoration: const BoxDecoration(color: rowColor1),
      // oddRowDecoration: const BoxDecoration(color: rowColor2),
      // evenCellStyle: TextStyle(background: rowColor2),
      cellHeight: 40.h,
      cellAlignments: {
        0: Alignment.centerLeft,
        1: Alignment.centerLeft,
        2: Alignment.center,
        3: Alignment.centerLeft,
        4: Alignment.centerLeft,
        5: Alignment.centerLeft,
        6: Alignment.center,
        7: Alignment.center,
      },
    ),
  );
}
