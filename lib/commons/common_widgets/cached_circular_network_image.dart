import 'package:invoice_producer/commons/common_imports/common_libs.dart';
import 'package:invoice_producer/commons/common_shimmers/loading_images_shimmer.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_initicon/flutter_initicon.dart';

class CachedCircularNetworkImageWidget extends StatelessWidget {
  const CachedCircularNetworkImageWidget({
    super.key,
    required this.image,
    required this.size, this.name = 'UnKnown',
  });

  final String image;
  final int size;
  final String name;

  @override
  Widget build(BuildContext context) {
    return image==''?
    Initicon(
      text: name,
      backgroundColor: context.greenColor.withOpacity(0.7),
      borderRadius: BorderRadius.circular(100),
      size: size.h,
    ):
      SizedBox(
      width: size.w,
      height: size.h,
      child: CachedNetworkImage(
        imageUrl: image,
        imageBuilder: (context, imageProvider) => Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
          ),
        ),
        placeholder: (context, url) => Center(
          child: ShimmerWidget(
            border: 100.r,
          ),
        ),
        errorWidget: (context, url, error) => Center(
            child: Initicon(
              text: name,
              backgroundColor: context.greenColor.withOpacity(0.7),
              borderRadius: BorderRadius.circular(100),
              size: size.h,
            ),),
      ),
    );
  }
}
