import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:invoice_producer/features/user/invoice/invoiceExended/signature/controller/signature_controller.dart';
import 'package:invoice_producer/models/signature_model/signature_model.dart';
import 'package:invoice_producer/commons/common_widgets/custom_button.dart';
import 'package:invoice_producer/commons/common_widgets/custom_outline_button.dart';
import 'package:invoice_producer/utils/constants/app_constants.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';
import '../../../../../../commons/common_imports/apis_commons.dart';
import '../../../../../../commons/common_imports/common_libs.dart';
import '../../../../../../utils/constants/assets_manager.dart';
import 'package:uuid/uuid.dart';

class CreateSignatureScreen extends ConsumerStatefulWidget {
  const CreateSignatureScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<CreateSignatureScreen> createState() =>
      _CreateSignatureScreenState();
}

class _CreateSignatureScreenState extends ConsumerState<CreateSignatureScreen> {
  final GlobalKey<SfSignaturePadState> _signaturePadKey = GlobalKey();

  File? signImage;
  Uint8List? pngBytes;

  @override
  void dispose() {
    _signaturePadKey.currentState?.dispose();
    signImage = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: context.scaffoldBackgroundColor,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Image.asset(AppAssets.backArrowIcon,
              width: 20.w, height: 20.h, color: context.titleColor),
        ),
        title: Text(
          'Signature',
          style: getLibreBaskervilleBoldStyle(
              color: context.titleColor, fontSize: MyFonts.size16),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: SfSignaturePad(
              key: _signaturePadKey,
              backgroundColor: Colors.transparent,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomOutlineButton(
                    onPressed: () {
                      _signaturePadKey.currentState?.clear();
                      signImage = null;
                      setState(() {});
                    },
                    buttonText: 'Reset',
                    padding: AppConstants.padding,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomButton(
                    isLoading: ref.watch(signatureControllerProvider),
                    onPressed: () async {
                      ui.Image image =
                      await _signaturePadKey.currentState!.toImage();
                      final ByteData? byteData = await image!
                          .toByteData(format: ui.ImageByteFormat.png);
                      pngBytes = byteData!.buffer.asUint8List();
                      ref.read(signatureControllerProvider.notifier)
                          .addSignature(context: context,
                          signatureModel: SignatureModel(
                              signatureId: Uuid().v4(), image: pngBytes.toString()),imageByes: pngBytes!);
                    },
                    buttonText: 'Save',
                    padding: AppConstants.padding,
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

}
