import 'package:flutter/material.dart';
import 'package:invoice_producer/commons/common_imports/common_libs.dart';
import 'package:shimmer/shimmer.dart';

class CommonShimmerWidget extends StatelessWidget {
  final Duration duration;
  final Color? baseColor;
  final double width;
  final double height;
  final Color? highlightColor;

  const CommonShimmerWidget({super.key,
    this.duration = const Duration(milliseconds: 1500),
    this.baseColor,
    this.width = double.infinity,
    this.height = double.infinity,
    this.highlightColor,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: baseColor??context.greenColor.withOpacity(0.1),
      highlightColor: highlightColor??context.greenColor.withOpacity(0.2),
      period: duration,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color:  highlightColor??context.greenColor.withOpacity(0.3),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
