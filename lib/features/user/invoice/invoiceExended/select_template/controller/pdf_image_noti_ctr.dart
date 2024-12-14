import 'dart:io';
import 'package:invoice_producer/commons/common_imports/common_libs.dart';

import '../../../../../../commons/common_imports/apis_commons.dart';

final pdfImgNotiController = ChangeNotifierProvider((ref) => PdfImageNotiController());

class PdfImageNotiController extends ChangeNotifier {

  File? _image ;
  File? get image => _image;
  setPdfImage(File? img) {
    _image = img;
    notifyListeners();
  }
}
