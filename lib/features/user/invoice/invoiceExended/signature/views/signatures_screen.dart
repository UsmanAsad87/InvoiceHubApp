import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:invoice_producer/commons/common_widgets/custom_button.dart';
import 'package:invoice_producer/commons/common_widgets/custom_dialoge.dart';
import 'package:invoice_producer/commons/common_widgets/show_toast.dart';
import 'package:invoice_producer/features/user/invoice/controller/invoice_controller.dart';
import 'package:invoice_producer/features/user/invoice/invoiceExended/signature/controller/signature_controller.dart';
import 'package:invoice_producer/features/user/invoice/widgets/custom_arrow_button.dart';
import 'package:invoice_producer/models/signature_model/signature_model.dart';
import 'package:invoice_producer/routes/route_manager.dart';
import 'package:invoice_producer/utils/constants/app_constants.dart';
import '../../../../../../../commons/common_imports/common_libs.dart';
import '../../../../../../../commons/common_widgets/floatingActionButton.dart';
import '../../../../../../../utils/constants/assets_manager.dart';
import '../../../../../../commons/common_shimmers/list_item_shimmer.dart';
import '../../../../../../commons/common_widgets/image_picker_widget.dart';
import '../../../../../../utils/loading.dart';
import '../widgets/signature_container.dart';
import 'package:uuid/uuid.dart';

class SignatureScreen extends ConsumerStatefulWidget {
  const SignatureScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<SignatureScreen> createState() => _SignatureScreenState();
}

class _SignatureScreenState extends ConsumerState<SignatureScreen> {
  int selectedSignatureIndex = -1;
  File? image;
  SignatureModel? selectedSignature;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      selectedSignature = ref.read(invoiceDataProvider.notifier).signatureModel;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.scaffoldBackgroundColor,
      floatingActionButton: CustomFloatingActionButton(
        onTap: () {
          showDialog(
              context: context,
              builder: (context) {
                return CustomDialogeBox(
                    title: 'Choose option',
                    onCrossTap: () {
                      Navigator.of(context).pop();
                    },
                    buttonList: [
                      CustomArrowButton(
                          onTap: () {
                            selectImage();
                            ref
                                .read(signatureControllerProvider.notifier)
                                .addSignature(
                                  context: context,
                                  signatureModel: SignatureModel(
                                      signatureId: const Uuid().v4(),
                                      image: image!.path),
                                );
                            image == null;
                          },
                          buttonName: 'Open gallery',
                          height: 45.h,
                          margin: 0,
                          border: false),
                      CustomArrowButton(
                          onTap: () {
                            selectImageFromCamera();
                            ref.read(signatureControllerProvider.notifier)
                                .addSignature(
                                  context: context,
                                  signatureModel: SignatureModel(
                                      signatureId: const Uuid().v4(),
                                      image: image!.path),
                                );
                            image == null;
                          },
                          buttonName: 'Open camera',
                          height: 45.h,
                          margin: 0,
                          border: false),
                      CustomArrowButton(
                          onTap: () {
                            Navigator.of(context).pop();
                            Navigator.pushNamed(
                                context, AppRoutes.createSignatureScreen);
                          },
                          buttonName: 'Signature here',
                          height: 45.h,
                          margin: 0,
                          border: false),
                    ]);
              });
        },
      ),
      appBar: AppBar(
        backgroundColor: context.scaffoldBackgroundColor,
        leading: Consumer(builder: (context, ref, child) {
          return IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Image.asset(AppAssets.backArrowIcon,
                width: 20.w, height: 20.h, color: context.titleColor),
          );
        }),
        title: Text(
          'Signature',
          style: getLibreBaskervilleBoldStyle(
              color: context.titleColor, fontSize: MyFonts.size16),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(AppConstants.padding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  'Signature list',
                  style: getBoldStyle(
                      color: context.titleColor, fontSize: MyFonts.size18),
                ),
              ),
              ref.watch(getAllSignatureProvider(context)).when(
                data: (signatureList) {
                  if (selectedSignature != null) {
                    final index = signatureList.indexWhere(
                          (signature) => signature.signatureId == selectedSignature!.signatureId,
                    );
                        selectedSignatureIndex = index;
                  }
                  return signatureList.isEmpty
                      ? const Center(child: Text('No signature found'))
                      : ListView.builder(
                          shrinkWrap: true,
                          itemCount: signatureList.length,
                          itemBuilder: (context, index) {
                            final signature = signatureList[index];
                            return SignatureContainer(
                              index: index,
                              signature: signature,
                              onChange: (value) {
                                setState(() {
                                  selectedSignatureIndex = value;
                                  selectedSignature = signature;
                                });
                              },
                              selectedSignatureIndex: selectedSignatureIndex,
                            );
                          });
                },
                error: (error, st) {
                  debugPrintStack(stackTrace: st);
                  debugPrint(error.toString());
                  return ErrorWidget(error);
                },
                loading: () {
                  return  ListView.builder(
                      itemCount: 3,
                      shrinkWrap: true,
                      itemBuilder: (context, snapshot) {
                        return const ListItemShimmer();
                      }
                  );
                },
              ),
              CustomButton(
                  onPressed: () {
                    if (selectedSignature != null) {
                      ref
                          .read(invoiceDataProvider.notifier)
                          .setInSignatureData(signature: selectedSignature!);
                      showSnackBar(context, 'Signature selected.');
                      Navigator.of(context).pop();
                    } else {
                      showSnackBar(context, 'Select signature');
                    }
                  },
                  buttonText: 'Save')
            ],
          ),
        ),
      ),
    );
  }

  void selectImage() async {
    image = await pickImageFromGallery(context);
    setState(() {});
  }

  void selectImageFromCamera() async {
    image = await pickImageFromCamera(context);
    setState(() {});
  }
}
