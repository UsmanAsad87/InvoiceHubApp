import 'dart:io';

import 'package:invoice_producer/utils/constants/app_constants.dart';
import 'package:invoice_producer/utils/constants/assets_manager.dart';

import '../../../../commons/common_imports/common_libs.dart';

class ProductImageUploadWidget extends StatefulWidget {
  const ProductImageUploadWidget({
    super.key,
    required this.onTap,
    this.image,
  });
  final VoidCallback onTap;
  final File? image;

  @override
  State<ProductImageUploadWidget> createState() =>
      _ProductImageUploadWidgetState();
}

class _ProductImageUploadWidgetState extends State<ProductImageUploadWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150.h,
      padding: EdgeInsets.only(bottom: 18.w),
      width: double.infinity,
      decoration: BoxDecoration(
          color: context.greenColor,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20.r),
              bottomRight: Radius.circular(20.r))),
      child: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
              color: context.whiteColor,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20.r),
                  bottomRight: Radius.circular(20.r))),
          child: Padding(
            padding: EdgeInsets.only(bottom: 15.0.h),
            child: SizedBox(
              width: 115.w,
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
                              : DecorationImage(
                              image: NetworkImage(
                                productPlaceHolderUrl,
                              ),
                              fit: BoxFit.fill),
                        ),
                      ),
                    ),
                    // Image.asset(
                    //   AppAssets.uploadImage,
                    //   width: 52.w,
                    //   height: 52.w,
                    // )
                  ],
                ),
              ),
            ),
          )),
    );
  }
}

// Padding(
// padding: EdgeInsets.all(5.0.h),
// child: SizedBox(
// width: double.infinity,
// height: 115.h,
// child: InkWell(
// onTap: widget.onTap,
// child: Stack(
// alignment: Alignment.center,
// children: [
// AspectRatio(
// aspectRatio: 1,
// child: Container(
// width: 180.w,
// height: 180.h,
// decoration: BoxDecoration(
// color: context.containerColor,
// borderRadius: BorderRadius.circular(10.r),
// image: widget.image != null
// ? DecorationImage(
// image: FileImage(
// widget.image!,
// ),
// fit: BoxFit.fill)
//     : null,
// ),
// ),
// ),
// Image.asset(
// AppAssets.uploadImage,
// width: 52.w,
// height: 52.w,
// )
// ],
// ),
// ),
// ),
// ),
