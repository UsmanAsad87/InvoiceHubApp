import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:invoice_producer/features/user/invoice/invoiceExended/select_template/controller/pdf_image_noti_ctr.dart';
import 'package:invoice_producer/features/user/invoice/invoiceExended/select_template/views/add_water_mark.dart';
import 'package:invoice_producer/features/user/invoice/invoiceExended/select_template/views/select_Image.dart';
import 'package:invoice_producer/features/user/invoice/invoiceExended/select_template/views/select_color.dart';
import 'package:invoice_producer/features/user/invoice/invoiceExended/select_template/widget/download_option_button.dart';
import 'package:invoice_producer/models/invoice_model/invoice_model.dart';
import 'package:invoice_producer/routes/route_manager.dart';
import 'package:invoice_producer/utils/constants/app_constants.dart';
import 'package:open_file/open_file.dart';
import '../../../../../../commons/common_imports/common_libs.dart';
import '../../../../../../commons/common_widgets/custom_button.dart';
import '../controller/pdf_state.dart';

class SelectTemplate extends ConsumerStatefulWidget {
  final InVoiceModel invoice;

  const SelectTemplate({super.key, required this.invoice});

  @override
  ConsumerState<SelectTemplate> createState() => _SelectTemplateState();
}

class _SelectTemplateState extends ConsumerState<SelectTemplate>
    with SingleTickerProviderStateMixin {
  String? selectedOption;
  List<String> itemValues = ['export as pdf'];
  late TabController _tabController;
  late final invoice;
  List<Icon> icons = [
    const Icon(Icons.print),
    const Icon(Icons.copy),
    const Icon(Icons.picture_as_pdf)
  ];

  Future<void> handleExistingPdf(File file) async {
    try {
      await OpenFile.open(file.path);
    } catch (e) {
      debugPrint('Error opening PDF: $e');
    }
  }

  @override
  void initState() {
    _tabController = TabController(
      length: 3,
      vsync: this,
    );
    init();
    super.initState();
  }

  init() {
    invoice = widget.invoice;
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (bool val) {
        WidgetsBinding.instance.addPostFrameCallback((timmeStamp) {
          final pdfImgCtr = ref.watch(pdfImgNotiController);
          pdfImgCtr.setPdfImage(null);
          Navigator.pop(context);
        });
      },
      child: Scaffold(
        backgroundColor: context.scaffoldBackgroundColor,
        appBar: AppBar(
          backgroundColor: context.scaffoldBackgroundColor,
          title: Text(
            'Select template',
            style: getLibreBaskervilleBoldStyle(
                color: context.titleColor, fontSize: MyFonts.size16),
          ),
          centerTitle: true,
          leading: Consumer(
            builder: (BuildContext context, WidgetRef ref, Widget? child) {
              final pdfImgCtr = ref.watch(pdfImgNotiController);
              return IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: MyColors.black,
                ),
                onPressed: () {
                  WidgetsBinding.instance.addPostFrameCallback((time) {
                    pdfImgCtr.setPdfImage(null);
                    Navigator.pop(context);
                  });
                },
              );
            },
          ),
          actions: [
            Consumer(
              builder: (BuildContext context, WidgetRef ref, Widget? child) {
                return DownloadOptionButton(
                  itemIcons: icons,
                  icon: const Icon(Icons.sim_card_download_outlined),
                  itemValues: itemValues,
                  onSelect: (val) async {
                    await handleExistingPdf(
                        ref.watch(pdfProvider).generatedFile!);
                  },
                );
              },
            )
          ],
          bottom: TabBar(
            indicatorColor: context.greenColor.withOpacity(.6),
            indicatorSize: TabBarIndicatorSize.tab,
            controller: _tabController,
            labelColor: context.greenColor,
            unselectedLabelColor: context.titleColor,
            tabs: const [
              Tab(
                text: 'Color',
              ),
              Tab(text: 'Image'),
              Tab(
                text: 'WaterMark',
              ),
            ],
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  SelectColor(invoice: invoice),
                  SelectImage(invoice: invoice),
                  AddWaterMark(invoice: invoice),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: AppConstants.paddingHorizontal),
              child: CustomButton(
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.congratsScreen);
                },
                buttonText: 'Send',
              ),
            )
          ],
        ),
      ),
    );
  }
}
