import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../../commons/common_imports/common_libs.dart';


class PdfNotifier extends ChangeNotifier {
  int _selectedFileIndex = 0;
  File? _generatedFile;

  int get selectedFileIndex => _selectedFileIndex;
  File? get generatedFile => _generatedFile;

  void updatePdf(int selectedFileIndex, File? generatedFile) {
    _selectedFileIndex = selectedFileIndex;
    _generatedFile = generatedFile;
    notifyListeners();
  }
}

final pdfProvider = ChangeNotifierProvider<PdfNotifier>((ref) => PdfNotifier());
