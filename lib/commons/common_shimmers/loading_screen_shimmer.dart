import 'package:invoice_producer/commons/common_imports/common_libs.dart';
import 'package:shimmer/shimmer.dart';

class LoadingScreenShimmer extends StatelessWidget {
  final Duration duration;
  final Color? baseColor;
  final double width;
  final double height;
  final Color? highlightColor;

  const LoadingScreenShimmer({super.key, 
    this.duration = const Duration(milliseconds: 1500),
    this.baseColor,
    this.width = double.infinity,
    this.height = double.infinity,
    this.highlightColor,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListView.builder(
                shrinkWrap: true,
                itemCount: 7,
                itemBuilder: (BuildContext context, int index) {
                  return SizedBox(
                    width: 420.w,
                    height: 120.h,
                    child: Container(
                      margin: EdgeInsets.only(bottom: 20.w),
                      child: Shimmer.fromColors(
                        baseColor: baseColor ?? context.whiteColor.withOpacity(0.1),
                        highlightColor: highlightColor ?? context.containerColor.withOpacity(0.1),
                        period: duration,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),

              SizedBox(height: 30.h,),
            ],
          ),
        ),
      ),
    );
  }
}
