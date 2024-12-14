import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:invoice_producer/commons/common_functions/date_time_methods.dart';
import 'package:invoice_producer/features/user/invoice/api/pdf_api.dart';
import 'package:invoice_producer/models/invoice_model/invoice_model.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';
import '../../../../models/customer_model/customer_model.dart';

class PdfFileFormat2{

  static Future<File> generate(InVoiceModel invoice, PdfColor color, [String? imagePath]) async {
    final pdf = Document();

    Uint8List? imageData;

    if (imagePath != null) {
      final ByteData image = await rootBundle.load(imagePath ?? '');
      imageData = (image).buffer.asUint8List();
    }

    pdf.addPage(
        MultiPage(
          pageTheme: PageTheme(
            buildBackground: (context) => pw.FullPage(
              ignoreMargins: true,
              child: pw.Container(color: color),
            ),
          ),
          build: (context) => [
            buildHeader(invoice),
            SizedBox(height: 3 * PdfPageFormat.cm),
            buildInvoice(invoice),
            Divider(),
            buildTotal(invoice),
            buildTankYou(),

          ],
          footer: (context) => buildFooter(invoice,imageData),
        ));

    return PdfApi.saveDocument(name: 'my_invoice.pdf', pdf: pdf);
  }

  static Widget buildHeader(InVoiceModel invoice) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 1 * PdfPageFormat.cm),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Container(
          //   height: 50,
          //   width: 50,
          //   child:
          //   BarcodeWidget(
          //     barcode: Barcode.qrCode(),
          //     data: invoice.info.number,
          //   ),
          // ),
          Text('INVOICE', style: TextStyle(color: PdfColors.black,fontSize: 35,fontWeight: FontWeight.bold)),
        ],
      ),
      SizedBox(height: 1 * PdfPageFormat.cm),
      Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          buildInvoiceInfo(invoice),
          buildCustomerAddress(invoice.customer!),

        ],
      ),
    ],
  );

  static Widget buildCustomerAddress(CustomerModel customer) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(customer.name, style: TextStyle(fontWeight: FontWeight.bold)),
      Text(customer.billingAddress1),
    ],
  );

  static Widget buildInvoiceInfo(InVoiceModel info) {
    final paymentTerms = '${info.dueDate.difference(info.issueDate).inDays} days';
    final titles = <String>[
      'Invoice Number:',
      'Invoice Date:',
      'Payment Terms:',
      'Due Date:'
    ];
    final data = <String>[
      info.invoiceNo ?? '',
      formatDateTime(info.issueDate),
      paymentTerms,
      formatDateTime(info.dueDate),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(titles.length, (index) {
        final title = titles[index];
        final value = data[index];

        return buildText(title: title, value: value, width: 200);
      }),
    );
  }

  static Widget buildInvoice(InVoiceModel invoice) {
    final headers = [
      'Description',
      'Quantity',
      'Unit Price',
      'Total'
    ];
    final data = invoice.items?.map((item) {
      final total = item.finalRate * item.unit * (1 + item.rate);

      return [
        item.description,
        '${item.unit}',
        '\$ ${item.finalRate}',
        '\$ ${total.toStringAsFixed(2)}',
      ];
    }).toList();

    return TableHelper.fromTextArray(
      headers: headers,
      data: data!,
      border: TableBorder(
          horizontalInside: BorderSide(width: 1)
      ),
      headerStyle: TextStyle(fontWeight: FontWeight.bold),
      cellHeight: 30,
      cellAlignments: {
        0: Alignment.centerLeft,
        1: Alignment.centerRight,
        2: Alignment.centerRight,
        3: Alignment.centerRight,
        4: Alignment.centerRight,
        5: Alignment.centerRight,
      },
    );
  }

  static Widget buildTotal(InVoiceModel invoice) {
    final netTotal = invoice.items
        !.map((item) => item.finalRate * item.unit)
        .reduce((item1, item2) => item1 + item2);
    final vatPercent = invoice.items?.first.rate;
    final vat = netTotal * vatPercent!;
    final total = netTotal + vat;

    return Container(
      alignment: Alignment.centerRight,
      child: Row(
        children: [
          Spacer(flex: 6),
          Expanded(
            flex: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildText(
                  title: 'sub total',
                  value: formatPrice(netTotal),
                  unite: true,
                ),
                buildText(
                  title: 'tax ${vatPercent * 100} %',
                  value: formatPrice(vat),
                  unite: true,
                ),
                Divider(),
                buildText(
                  title: 'Total amount due',
                  titleStyle: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                  value: formatPrice(total),
                  unite: true,
                ),
                // SizedBox(height: 2 * PdfPageFormat.mm),
                //  Container(height: 1, color: PdfColors.grey400),
                //  SizedBox(height: 0.5 * PdfPageFormat.mm),
                //  Container(height: 1, color: PdfColors.grey400),
              ],
            ),
          ),
        ],
      ),
    );
  }


  static Widget buildFooter(InVoiceModel invoice, [Uint8List? imageData]) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Divider(),
        SizedBox(height: 2 * PdfPageFormat.mm),
        if (imageData != null)
          Container(
              width: 100.0,
              height: 100.0,
              child: pw.Image(pw.MemoryImage(imageData!))
          ),
        // buildSimpleText(title: 'Address', value: invoice.supplier.address),
        SizedBox(height: 1 * PdfPageFormat.mm),
        // buildSimpleText(title: 'Paypal', value: invoice.supplier.paymentInfo),
      ],
    );
  }

  static Widget buildTankYou() => Container(
      alignment : Alignment.centerLeft,
      child : Text('Thank you!',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22)));
  static buildSimpleText({
    required String title,
    required String value,
  }) {
    final style = TextStyle(fontWeight: FontWeight.bold);

    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: pw.CrossAxisAlignment.end,
      children: [
        Text(title, style: style),
        SizedBox(width: 2 * PdfPageFormat.mm),
        Text(value),
      ],
    );
  }

  static buildText({
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

  static formatPrice(double price) => '\$ ${price.toStringAsFixed(2)}';

}