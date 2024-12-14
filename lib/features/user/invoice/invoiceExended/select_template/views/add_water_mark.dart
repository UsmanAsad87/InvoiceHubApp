import 'dart:io';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:invoice_producer/features/user/invoice/invoiceExended/select_template/widget/empty_container.dart';
import 'package:invoice_producer/features/user/invoice/invoiceExended/select_template/widget/pdf_container.dart';
import 'package:invoice_producer/features/user/invoice/invoiceExended/select_template/widget/watermark_container.dart';
import 'package:invoice_producer/utils/constants/assets_manager.dart';
import 'package:pdf/pdf.dart';
import '../../../../../../commons/common_imports/apis_commons.dart';
import '../../../../../../utils/loading.dart';
import '../../../pdf_templates/pdf_file_format_one/pdf_file_format_one.dart';
import '../../../../../../commons/common_imports/common_libs.dart';
import '../controller/pdf_generator.dart';
import '../controller/pdf_state.dart';
import '../controller/select_color_notifier.dart';
import '../templete_constants/templete_constants.dart';

class AddWaterMark extends ConsumerStatefulWidget {
  final invoice;

  const AddWaterMark({Key? key, required this.invoice}) : super(key: key);

  @override
  ConsumerState<AddWaterMark> createState() => _AddWaterMarkState();
}

class _AddWaterMarkState extends ConsumerState<AddWaterMark> {
  File? file;
  File? file2;
  File? file3;
  int selectedFile = 0;

  late final invoice;
  late final SelectedColorNotifier selectedColorNotifier;
  bool loading = false;

  @override
  void initState() {
    super.initState();
    invoice = widget.invoice;
    selectedColorNotifier = ref.read(selectedColorProvider);
    onClicked();
  }

  onClicked() async {
    file = await PdfFileFormatOne.generate(
      ref: ref,
      invoice: invoice,
      color: PdfColor.fromInt(
          TemConstants.lisOfColor[selectedColorNotifier.selectedColorIndex]),
    );
    ref.watch(pdfProvider.notifier).updatePdf(0, file);
  }

  List<String?> icons = [
    null,
    AppAssets.watermarkIcon1,
    AppAssets.watermarkIcon2,
    AppAssets.watermarkIcon3,
    AppAssets.watermarkIcon4,
  ];

  List<String?> iconsLight = [
    null,
    AppAssets.watermarkIcon5,
    AppAssets.watermarkIcon6,
    AppAssets.watermarkIcon7,
    AppAssets.watermarkIcon8,
  ];

  int selectedIndex = 1;

  @override
  Widget build(BuildContext context) {
    final pdfPro = ref.watch(pdfProvider);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          file == null
              ? Expanded(
                  child: Center(
                      child: LoadingWidget(
                  size: 60.r,
                  color: context.greenColor,
                )))
              : Expanded(
                  child: Stack(
                    children: [
                      CarouselSlider(
                        items: [
                          for (int i = 0; i < 6; i++)
                            pdfPro.selectedFileIndex == i &&
                                    pdfPro.generatedFile != null
                                ? PdfContainer(file: pdfPro.generatedFile!)
                                : EmptyContainer(
                                    color: TemConstants.lisOfColor[
                                        selectedColorNotifier
                                            .selectedColorIndex]),
                        ],
                        options: CarouselOptions(
                          height: double.infinity,
                          initialPage: 0,
                          enlargeCenterPage: true,
                          enlargeFactor: 0.3,
                          scrollDirection: Axis.horizontal,
                          onPageChanged: (index, reason) async {
                            selectedFile = index;
                            final generatedFile =
                                await PdfGenerator.generatePdf(
                                  ref: ref,
                              index: index,
                              invoice: invoice,
                              color: PdfColor.fromInt(
                                TemConstants.lisOfColor[ref
                                    .watch(selectedColorProvider)
                                    .selectedColorIndex],
                              ),
                            );
                            ref
                                .watch(pdfProvider.notifier)
                                .updatePdf(index, generatedFile);
                          },
                        ),
                      ),
                      if (loading)
                        Center(
                            child: LoadingWidget(
                          size: 50,
                          color: context.greenColor,
                        ))
                    ],
                  ),
                ),
          SizedBox(
            height: 120,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: icons.length,
                itemBuilder: (context, index) {
                  return index == 0
                      ? InkWell(
                          onTap: () async {
                            setState(() {
                              loading = true;
                            });
                            final selectedFileIndex = selectedFile;
                                await PdfGenerator.generatePdf(
                                  ref: ref,
                                    index: selectedFileIndex,
                                    invoice: invoice,
                                    color: PdfColor.fromInt(
                                      TemConstants.lisOfColor[
                                          selectedColorNotifier
                                              .selectedColorIndex],
                                    ),
                                    watermark: iconsLight[index]);
                            setState(() {
                              loading = false;
                              selectedIndex = index;
                            });
                          },
                          child: Container(
                            margin: EdgeInsets.all(5.r),
                            padding: EdgeInsets.all(10.r),
                            width: 100,
                            height: selectedIndex == 0 ? 25 : 20,
                            decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(4),
                                border: Border.all(
                                    width: 1,
                                    color: selectedIndex == 0
                                        ? Colors.blue
                                        : Colors.grey.withOpacity(.5))),
                          ),
                        )
                      : WatermarkContainer(
                          icon: icons[index],
                          isSelected: selectedIndex == index,
                          onTap: () async {
                            setState(() {
                              loading = true;
                            });
                            final selectedFileIndex = selectedFile;
                            final generatedFile =
                                await PdfGenerator.generatePdf(
                                    ref: ref,
                                    index: selectedFileIndex,
                                    invoice: invoice,
                                    color: PdfColor.fromInt(
                                      TemConstants.lisOfColor[
                                          selectedColorNotifier
                                              .selectedColorIndex],
                                    ),
                                    watermark: iconsLight[index]);
                            setState(() {
                              loading = false;
                              selectedIndex = index;
                            });
                          },
                        );
                }),
          ),
        ],
      ),
    );
  }
}
