import 'dart:io';

import 'package:invoice_producer/utils/constants/assets_manager.dart';

import '../../../../../../commons/common_imports/common_libs.dart';


class EditProfileImageUploadWidget extends StatelessWidget {
  const EditProfileImageUploadWidget({
    super.key, required this.onTap, this.image, required this.imgUrl,
  });
  final VoidCallback onTap;
  final File? image;
  final String imgUrl;



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
                  height: 176.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: context.greenColor,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20.r),
                        bottomRight: Radius.circular(20.r),
                      )),
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
                    onTap: onTap,
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
                              image: image != null
                                  ? DecorationImage(
                                  image: FileImage(
                                    image!,
                                  ),
                                  fit: BoxFit.cover)
                                  : imgUrl!=null?DecorationImage(
                                  image: NetworkImage(
                                    imgUrl,
                                  ),
                                  fit: BoxFit.cover):null,
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
              Text('Upload your image',
                  style: getMediumStyle(
                      color: context.titleColor, fontSize: MyFonts.size14)),
            ],
          ),
        ),
      ],
    );
  }
}