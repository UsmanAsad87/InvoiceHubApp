import 'dart:io';

import 'package:invoice_producer/utils/constants/assets_manager.dart';

import '../../../commons/common_imports/common_libs.dart';


class CompanyImageUploadWidget extends StatefulWidget {
  const CompanyImageUploadWidget({
    super.key, required this.onTap, this.image, this.isFullColor=false,
  });
  final VoidCallback onTap;
  final File? image;
  final bool isFullColor;

  @override
  State<CompanyImageUploadWidget> createState() => _CompanyImageUploadWidgetState();
}

class _CompanyImageUploadWidgetState extends State<CompanyImageUploadWidget> {


  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 178.h,
          width: double.infinity,
          decoration: BoxDecoration(
              color: context.whiteColor,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20.r),
                  bottomRight: Radius.circular(20.r))),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  height: 178.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: context.greenColor,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20.r),
                      )),
                ),
              ),
              Expanded(
                child: Container(
                  height: 178.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: widget.isFullColor? context.greenColor: context.greenColor.withOpacity(0.5),
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(20.r))),
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 160.h,
          width: double.infinity,
          decoration: BoxDecoration(
              color: context.whiteColor,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20.r),
                  bottomRight: Radius.circular(20.r))),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(5.0.h),
                child: SizedBox(
                  width: double.infinity,
                  height: 115.h,
                  child: InkWell(
                    onTap: widget.onTap,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        AspectRatio(
                          aspectRatio: 1,
                          child: Container(
                            width: 180.w,
                            height: 180.h,
                            decoration: BoxDecoration(
                              color: context.containerColor,
                              borderRadius: BorderRadius.circular(10.r),
                              image: widget.image != null
                                  ? DecorationImage(
                                  image: FileImage(
                                    widget.image!,
                                  ),
                                  fit: BoxFit.fill)
                                  : null,
                            ),
                          ),
                        ),
                        Image.asset(
                          AppAssets.uploadImage,
                          width: 52.w,
                          height: 52.w,
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Text('Upload your company logo',
                  style: getMediumStyle(
                      color: context.bodyTextColor, fontSize: MyFonts.size14)),
            ],
          ),
        ),
      ],
    );
  }
}