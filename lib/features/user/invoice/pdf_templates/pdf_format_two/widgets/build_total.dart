import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:invoice_producer/core/enums/currency_sign_enum.dart';
import 'package:invoice_producer/features/user/invoice/pdf_templates/pdf_constants/pdf_constants.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

import '../../../../../../models/invoice_model/invoice_model.dart';
import '../../../../../../utils/constants/app_constants.dart';

Widget buildTotal(InVoiceModel invoice) {
  List<List<dynamic>> data = [];
  final currency = getCurrencySymbol(invoice.currency?.name);
  final keyRow = [
    'Subtotal',
    'Total',
    'Paid',
    'Due Balance',
  ];

  final valueRow = [
    '$currency ${invoice.subTotal}',
    '$currency ${invoice.total}',
    '$currency ${(invoice.paid ?? 0)}',
    '$currency ${(invoice.dueBalance ?? 0)}',
  ];

  // data.add(keyRow);
  data.add(valueRow);

  const PdfColor rowColor1 = PdfColor.fromInt(0xFFEEEEEE);
  const PdfColor rowColor2 = PdfColor.fromInt(0xFFFFFFFF);

  return Table.fromTextArray(
    headers: keyRow,
    data: data,
    border: TableBorder.all(width: 1.w, color: PdfColors.grey),
    // headerStyle: TextStyle(fontWeight: FontWeight.bold),
    headerCellDecoration: const BoxDecoration(color: rowColor1),
    rowDecoration: const BoxDecoration(color: rowColor1),
    oddRowDecoration: const BoxDecoration(color: rowColor2),
    cellHeight: 30.h,
    cellDecoration: (rowIndex, columnIndex, row) {
      if (rowIndex == data[0].length - 1) {
        // Last column (index: data[0].length - 1)
        return const BoxDecoration(color: PdfConstants.pdfTwoCol);
      }
      return const BoxDecoration(color: rowColor1);
      // return null;
    },
    cellAlignments: {
      0: Alignment.center,
      1: Alignment.center,
      2: Alignment.center,
      3: Alignment.center,
    },
  );
}

buildText({
  required String title,
  required String value,
  double width = double.infinity,
  TextStyle? titleStyle,
  bool unite = false,
}) {
  final style = titleStyle ?? TextStyle(fontWeight: FontWeight.bold);

  return Container(
    width: width,
    child: Row(
      children: [
        Expanded(child: Text(title, style: style)),
        Text(value, style: unite ? style : null),
      ],
    ),
  );
}

formatPrice(double price) => '\$ ${price.toStringAsFixed(2)}';
