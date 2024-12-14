import 'dart:io';
import 'package:open_file/open_file.dart';
import 'package:pdf/widgets.dart';
import 'package:path_provider/path_provider.dart';

class PdfApi {
  static Future<File> saveDocument({
    required String name,
    required Document pdf,
  }) async {
    final bytes = await pdf.save();
    final dir = await getApplicationSupportDirectory();
    final file = File('${dir.path}/$name');
    await file.writeAsBytes(bytes);
    return file;
  }
}
