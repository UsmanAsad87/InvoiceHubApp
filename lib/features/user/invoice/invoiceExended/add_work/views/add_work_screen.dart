import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:invoice_producer/commons/common_widgets/cached_retangular_network_image.dart';
import 'package:invoice_producer/commons/common_widgets/custom_button.dart';
import 'package:invoice_producer/commons/common_widgets/show_toast.dart';
import 'package:invoice_producer/features/user/invoice/controller/invoice_controller.dart';
import 'package:invoice_producer/utils/constants/app_constants.dart';

import '../../../../../../commons/common_imports/common_libs.dart';
import '../../../../../../commons/common_widgets/floatingActionButton.dart';
import '../../../../../../utils/constants/assets_manager.dart';

class AddWorkScreen extends ConsumerStatefulWidget {
  const AddWorkScreen({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<AddWorkScreen> createState() => _AddWorkScreenState();
}

class _AddWorkScreenState extends ConsumerState<AddWorkScreen> {
  List<XFile> selectedImages = [];
  List<String>? firebaseImages = [];
  final picker = ImagePicker();
  List<dynamic> combinedList = [];

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      firebaseImages =
          ref.read(invoiceDataProvider.notifier).invoiceModel?.workSamples;
      combinedList.addAll(firebaseImages as Iterable);
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: context.scaffoldBackgroundColor,
          floatingActionButton: Padding(
            padding: EdgeInsets.only(bottom: 60.h),
            child: CustomFloatingActionButton(
              onTap: () {
                getImages();
              },
            ),
          ),
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
              'Add work sample',
              style: getLibreBaskervilleBoldStyle(
                  color: context.titleColor, fontSize: MyFonts.size16),
            ),
            centerTitle: true,
          ),
          body: SizedBox(
            width: double.infinity,
            child: combinedList!.isEmpty
                ? const Center(child: Text('Select multiple images.'))
                : Padding(
                    padding: EdgeInsets.all(15.h),
                    child: GridView.builder(
                      itemCount: combinedList.length ,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 8.0,
                        mainAxisSpacing: 8.0,
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        final item = combinedList![index];
                        return Center(
                            child: Stack(
                          children: [
                            Container(
                                width: 200.w,
                                height: 200.h,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.r)),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8.r),
                                  child: item is XFile
                                      ? Image.file(
                                          File(combinedList[index].path),
                                          fit: BoxFit.cover,
                                        ) // : Container(),
                                      : CachedRectangularNetworkImageWidget(
                                          image: item, width: 50, height: 50),
                                )),
                            Align(
                              alignment: Alignment.topRight,
                              child: Container(
                                margin: EdgeInsets.all(8.r),
                                padding: EdgeInsets.all(4.r),
                                decoration: BoxDecoration(
                                  color: context.whiteColor,
                                  borderRadius: BorderRadius.circular(4.r),
                                ),
                                child: InkWell(
                                    onTap: () {
                                      // Look for delete image issue
                                      combinedList.removeAt(index);
                                      setState(() {});
                                    },
                                    child: const Icon(Icons.close_rounded)),
                              ),
                            ),
                          ],
                        ));
                      },
                    ),
                  ),
          ),
        ),
        Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: AppConstants.paddingHorizontal),
              child: CustomButton(
                  onPressed: () {
                    ref
                        .read(invoiceDataProvider.notifier)
                        .setWorkSamples(workSamples: selectedImages);
                    showSnackBar(
                        context, '${selectedImages.length} image selected.');
                    Navigator.of(context).pop();
                  },
                  buttonText: 'Save'),
            )),
        SizedBox(
          height: 30.h,
        ),
      ],
    );
  }

  Future getImages() async {
    final pickedFile = await picker.pickMultiImage(
        imageQuality: 100, maxHeight: 1000, maxWidth: 1000);
    List<XFile> xfilePick = pickedFile;

    if (xfilePick.isNotEmpty) {
      for (var i = 0; i < xfilePick.length; i++) {
        selectedImages.add(xfilePick[i]);
        combinedList.add(xfilePick[i]);
      }
      setState(
        () {},
      );
    } else {
      showSnackBar(context, 'Nothing is selected');
    }
  }
}
