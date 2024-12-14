import 'package:pdf/widgets.dart';

import '../../pdf_constants/pdf_constants.dart';

Widget buildFooter() => Column(
    children: [
      Container(
        decoration: const BoxDecoration(
            color: PdfConstants.pdfFiveCol
        ),
        height: 8,
      ),
      Container(
        decoration: const BoxDecoration(
            color: PdfConstants.pdfFiveTextCol
        ),
        height: 16,
      ),
    ]
);