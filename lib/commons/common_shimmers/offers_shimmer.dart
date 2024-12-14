import 'package:invoice_producer/commons/common_imports/common_libs.dart';
import 'package:shimmer/shimmer.dart';

class LoadingOffersShimmer extends StatelessWidget {
  final Duration duration;
  final Color? baseColor;
  final double width;
  final double height;
  final Color? highlightColor;

  const LoadingOffersShimmer({super.key, 
    this.duration = const Duration(milliseconds: 1500),
    this.baseColor,
    this.width = double.infinity,
    this.height = double.infinity,
    this.highlightColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20.h,),
          SizedBox(
            width: 420.w,
            height: 120.h,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemCount: 7,
              itemBuilder: (BuildContext context,  int index) {

                return Container(
                  margin: EdgeInsets.only(right: 20.w),
                  child: Shimmer.fromColors(
                    baseColor: baseColor ?? MyColors.white.withOpacity(0.1),
                    highlightColor: highlightColor ?? MyColors.white.withOpacity(0.1),
                    period: duration,
                    child: Container(
                      width: 70.w,
                      height: 105.h,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 30.h,),
          SizedBox(
            width: 420.w,
            height: 454.h,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemCount: 3,
              itemBuilder: (BuildContext context,  int index) {

                return Container(
                  margin: EdgeInsets.only(right: 30.w),
                  child: Shimmer.fromColors(
                    baseColor: baseColor ?? MyColors.white.withOpacity(0.1),
                    highlightColor: highlightColor ??  MyColors.white.withOpacity(0.1),
                    period: duration,
                    child: Container(
                      width: 283.w,
                      height: 454.h,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
