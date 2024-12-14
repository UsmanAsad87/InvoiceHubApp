import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:invoice_producer/core/enums/currency_sign_enum.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' ;
import '../../../../../../models/invoice_model/invoice_model.dart';
import '../../../../../../utils/constants/app_constants.dart';
import '../../../../dashboard/controller/dashboard_notifiar_ctr.dart';

Widget buildTotal({required InVoiceModel invoice, required WidgetRef ref}) {
  List<List<dynamic>> data = [];
  final currency = getCurrencySymbol(invoice.currency?.name);
  final subTotalRow = [
    'Subtotal',
    '$currency ${invoice.subTotal}',
  ];
  final totalRow = [
    'Total',
    '$currency ${invoice.total}',
  ];
  final paidRow = [
    'Paid',
    '$currency ${invoice.paid ?? 0}',
  ];
  final dueRow = [
    'Due Balance',
    '$currency ${invoice.dueBalance ?? 0}',
  ];

  data.add(subTotalRow);
  data.add(totalRow);
  data.add(paidRow);
  data.add(dueRow);

  const PdfColor headerColor = PdfColor.fromInt(0xFF023e6d);
  const PdfColor rowColor1 = PdfColor.fromInt(0xFFEEEEEE);
  const PdfColor rowColor2 = PdfColor.fromInt(0xFFFFFFFF);

  return Expanded(
    flex: 1,
      child: Container(
      alignment: Alignment.centerRight,
      child:
    Padding(
    padding: EdgeInsets.only(
        bottom: AppConstants.padding,
        left: AppConstants.padding,
        right: AppConstants.padding),
    child: Table.fromTextArray(
      data: data,
      tableWidth: TableWidth.min,
      border: TableBorder.all(width: 1.w, color: PdfColors.grey),
      headerCellDecoration: const BoxDecoration(color: rowColor1),
      rowDecoration: const BoxDecoration(color: rowColor1),
      oddRowDecoration: const BoxDecoration(color: rowColor2),
      cellHeight: 30.h,
      cellAlignments: {
        0: Alignment.center,
        1: Alignment.center,
      },
    ),
  )));
}

// buildText({
//   required String title,
//   required String value,
//   double width = double.infinity,
//   TextStyle? titleStyle,
//   bool unite = false,
// }) {
//   final style = titleStyle ?? TextStyle(fontWeight: FontWeight.bold);
//
//   return Container(
//     width: width,
//     child: Row(
//       children: [
//         Expanded(child: Text(title, style: style)),
//         Text(value, style: unite ? style : null),
//       ],
//     ),
//   );
// }

// formatPrice(double price) => '${dashBoardCtr.currencyTypeEnum?.type} ${price.toStringAsFixed(2)}';
