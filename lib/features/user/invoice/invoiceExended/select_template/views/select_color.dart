import 'package:carousel_slider/carousel_slider.dart';
import 'package:invoice_producer/features/user/invoice/invoiceExended/select_template/templete_constants/templete_constants.dart';
import 'package:invoice_producer/features/user/invoice/invoiceExended/select_template/widget/empty_container.dart';
import 'package:invoice_producer/features/user/invoice/invoiceExended/select_template/widget/pdf_container.dart';
import 'package:invoice_producer/utils/loading.dart';
import 'package:pdf/pdf.dart';
import '../../../../../../commons/common_imports/apis_commons.dart';
import '../../../../../../commons/common_imports/common_libs.dart';
import '../controller/pdf_generator.dart';
import '../controller/pdf_state.dart';
import '../controller/select_color_notifier.dart';
import '../widget/color_container.dart';

class SelectColor extends ConsumerStatefulWidget {
  final invoice;

  const SelectColor({super.key, required this.invoice});

  @override
  ConsumerState<SelectColor> createState() => _SelectColorState();
}

class _SelectColorState extends ConsumerState<SelectColor> {
  bool loading = false;
  int selectedFile = 0;

  late final invoice;
  late final SelectedColorNotifier selectedColorNotifier;

  List<int> listColor = TemConstants.lisOfColor;


  @override
  void initState() {
    super.initState();
    invoice = widget.invoice;
    selectedColorNotifier = ref.read(selectedColorProvider);
    onClicked();
  }

  @override
  Widget build(BuildContext context) {
    final pdfPro = ref.watch(pdfProvider);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
                    child: Stack(
                      children: [
                        CarouselSlider(
                          items: [
                            for (int i = 0; i < 6; i++)
                              pdfPro.selectedFileIndex == i &&
                                  pdfPro.generatedFile != null
                                  ? PdfContainer(file: pdfPro.generatedFile!)
                                  :  EmptyContainer(color: TemConstants.lisOfColor[
                              selectedColorNotifier.selectedColorIndex]),
                          ],
                          options: CarouselOptions(
                            height: double.infinity,
                            initialPage: 0,
                            enlargeCenterPage: true,
                            enlargeFactor: 0.3,
                            scrollDirection: Axis.horizontal,
                            onPageChanged: (index, reason) async {
                              selectedFile = index;
                              final generatedFile = await PdfGenerator.generatePdf(
                                ref: ref,
                                index: index,
                                invoice: invoice,
                                color: PdfColor.fromInt(
                                  listColor[ref.watch(selectedColorProvider).selectedColorIndex],
                                ),
                              );
                              ref.watch(pdfProvider.notifier).updatePdf(index, generatedFile);
                            },
                          ),
                        ),
                        if (loading)
                          Center(
                              child: LoadingWidget(
                            size: 50.r,
                            color: context.greenColor,
                          ))
                      ],
                    ),
                  ),
            SizedBox(
              height: 110.h,
              width: double.infinity,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: listColor.length,
                itemBuilder: (context, index) {
                  return ColorContainer(
                    color: Color(listColor[index]),
                    isSelected:
                        selectedColorNotifier.selectedColorIndex == index,
                    onTap: () async {
                      setState(() {
                        loading = true;
                      });
                      final selectedFileIndex = selectedFile;
                      final generatedFile = await PdfGenerator.generatePdf(
                        ref: ref,
                        index: selectedFileIndex,
                        invoice: invoice,
                        color: PdfColor.fromInt(listColor[index]),
                      );
                      setState(() {
                        loading = false;
                        selectedColorNotifier.selectedColorIndex = index;
                      });
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  onClicked() async {

    final generatedFile = await PdfGenerator.generatePdf(
      ref: ref,
      index: 0,
      invoice: invoice,
      color: PdfColor.fromInt(listColor[0]),
    );
    ref.watch(pdfProvider.notifier).updatePdf(0, generatedFile);

  }
}