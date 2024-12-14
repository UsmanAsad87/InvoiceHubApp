import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:invoice_producer/commons/common_imports/common_libs.dart';

import '../../../../../../../commons/common_shimmers/loading_images_shimmer.dart';

class AddItemProfileImage extends StatelessWidget {
  final String imgUrl;
  const AddItemProfileImage({Key? key, required this.imgUrl}) : super(key: key);

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
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      AspectRatio(
                        aspectRatio: 1,
                        child: CachedNetworkImage(
                          imageUrl: imgUrl,
                          imageBuilder: (context, imageProvider) => Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(5.r),
                              image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
                            ),
                          ),
                          placeholder: (context, url) => const Center(child: ShimmerWidget()),
                          errorWidget: (context, url, error) => Center(
                              child: SizedBox(
                                  width: 20.w, height: 20.h, child: const Icon(Icons.error))),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
