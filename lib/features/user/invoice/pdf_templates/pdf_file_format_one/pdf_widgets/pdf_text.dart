import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';


pdfText({text, required color, fontSize, fontWeight}) => Text(
    text ?? '',
    style: TextStyle(
        color: color,
        fontSize: fontSize.toDouble() ?? 15,
        fontWeight: fontWeight ?? FontWeight.normal));
