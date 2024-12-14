import 'dart:io';

import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:invoice_producer/commons/common_functions/padding.dart';
import 'package:invoice_producer/features/user/invoice/invoiceExended/select_template/controller/pdf_image_noti_ctr.dart';
import 'package:invoice_producer/features/user/invoice/invoiceExended/select_template/widget/empty_container.dart';
import 'package:invoice_producer/features/user/invoice/invoiceExended/select_template/widget/pdf_container.dart';
import 'package:invoice_producer/utils/loading.dart';
import 'package:pdf/pdf.dart';

import '../../../../../../commons/common_imports/apis_commons.dart';
import '../../../../../../commons/common_imports/common_libs.dart';
import '../../../../../../commons/common_widgets/image_picker_widget.dart';
import '../../../pdf_templates/pdf_file_format_one/pdf_file_format_one.dart';
import '../controller/pdf_generator.dart';
import '../controller/pdf_state.dart';
import '../controller/select_color_notifier.dart';
import '../templete_constants/templete_constants.dart';

class SelectImage extends ConsumerStatefulWidget {
  final invoice;

  const SelectImage({Key? key, required this.invoice}) : super(key: key);

  @override
  ConsumerState<SelectImage> createState() => _SelectImageState();
}

class _SelectImageState extends ConsumerState<SelectImage> {
  File? file;
  File? file2;
  File? file3;

  int selectedFile = 0;

  late final invoice;
  late final SelectedColorNotifier selectedColorNotifier;

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

  @override
  Widget build(BuildContext context) {
    final pdfPro = ref.watch(pdfProvider);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            file == null
                ? Expanded(
                    child: Center(
                        child: LoadingWidget(
                    color: context.greenColor,
                    size: 50.r,
                  )))
                : Expanded(
                    child: CarouselSlider(
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
                        enlargeStrategy: CenterPageEnlargeStrategy.zoom,
                        enlargeCenterPage: true,
                        aspectRatio: 50,
                        scrollDirection: Axis.horizontal,
                        onPageChanged: (index, reason) async {
                          selectedFile = index;
                          final generatedFile = await PdfGenerator.generatePdf(
                            index: index,
                            ref: ref,
                            invoice: invoice,
                             color:  PdfColor.fromInt(TemConstants.lisOfColor[
                              selectedColorNotifier.selectedColorIndex]));
                          ref.watch(pdfProvider.notifier).updatePdf(index, generatedFile);
                        },
                      ),
                    ),
                  ),
            Consumer(
              builder: (BuildContext context, WidgetRef ref, Widget? child) {
                final pdgImgCtr = ref.watch(pdfImgNotiController);
                return SizedBox(
                  width: double.infinity,
                  height: 56.h,
                  child: OutlinedButton.icon(
                    onPressed: () async{
                      File? image = await pickImageFromGallery(context);
                      pdgImgCtr.setPdfImage(image);
                    },
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                    ),
                    icon: const Icon(Icons.cloud_upload_outlined),
                    label: Text(pdgImgCtr.image == null?'Upload image': 'Image Selected',
                        style: getSemiBoldStyle(
                            color: context.titleColor, fontSize: MyFonts.size16)),
                  ),
                );
              },

            ),
            padding32,
          ],
        ),
      ),
    );
  }

}
