import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:invoice_producer/utils/constants/app_constants.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

import '../../../../../../core/enums/currency_sign_enum.dart';
import '../../../../../../models/invoice_model/invoice_model.dart';
import '../../../common_functions/calculate_single_product_total.dart';

Widget buildInvoice(

    {required InVoiceModel invoice,
    required PdfColor color,
    EdgeInsetsGeometry? padding,
    PdfColor? headerTextCol}) {
  final currency = getCurrencySymbol(invoice.currency?.name);
  final headers = [
    'No',
    'Description',
    'Quantity',
    'Price',
    'discount',
    'Total'
  ];
  int i = 1;
  final data = invoice.items?.map((item) {
    final total = item.finalRate * item.unit * (1 + item.rate);
    return [
      i++,
      '${item.name}\n${item.description}',
      '${item.soldQuantity!.toInt()}',
      '$currency ${item.finalRate}',
      '',
    //  '${item.discountRate}%',
      '$currency${calculateSingleProductTotal(
          finalRate: item.finalRate,
       //   discount: item.discountRate,
        //  shippingCost: item.shippingCost!,
          soldQuantity: item.soldQuantity!)}'
          // '\$${((item.finalRate - item.discountRate) * item.soldQuantity!) + item.shippingCost!}', //\$ ${total.toStringAsFixed(2)}',
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

  const PdfColor rowColor1 = PdfColor.fromInt(0xFFEEEEEE);
  const PdfColor rowColor2 = PdfColor.fromInt(0xFFFFFFFF);

  return Padding(
    padding: padding ??
        EdgeInsets.only(
            top: AppConstants.padding,
            left: AppConstants.padding,
            right: AppConstants.padding),
    child: Table.fromTextArray(
      headers: headers,
      data: data!,
      cellDecoration: cellDecoration,
      border: TableBorder.all(width: 1, color: PdfColors.grey),
      headerStyle: TextStyle(
          fontWeight: FontWeight.bold, color: headerTextCol ?? PdfColors.white),
      headerCellDecoration: BoxDecoration(color: color),
      rowDecoration: const BoxDecoration(color: rowColor1),
      oddRowDecoration: const BoxDecoration(color: rowColor2),
      // evenCellStyle: TextStyle(background: rowColor2),
      cellHeight: 30.h,
      cellAlignments: {
        0: Alignment.center,
        1: Alignment.centerLeft,
        2: Alignment.center,
        3: Alignment.center,
        4: Alignment.center,
        5: Alignment.center,
        6: Alignment.center,
        7: Alignment.center,
      },
    ),
  );
}
