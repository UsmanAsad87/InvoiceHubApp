import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class CircleChart extends StatelessWidget {
  final List<Widget> children;
  final List<ChartData> chartData;

  const CircleChart({Key? key, required this.children, required this.chartData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: double.infinity,
          height: 400.h,
        ),
        SizedBox(
          width: double.infinity,
          height: 300.h,
          child: ClipRect(
           clipper: HalfClipper(),
            child: Transform.rotate(
              angle: -3.14159265359 / 2,
              // Rotate by 180 degrees (in radians)
              child: SfCircularChart(
                series: <CircularSeries>[
                  // Renders radial bar chart
                  RadialBarSeries<ChartData, String>(
                    radius: '100%',
                    gap: '6',
                    strokeWidth: 600.w,
                    useSeriesColor: true,
                    trackOpacity: 0.3,
                    cornerStyle: CornerStyle.bothCurve,
                    dataSource: chartData,
                    pointRadiusMapper: (ChartData data, _) => data.text,
                    pointColorMapper: (ChartData data, _) => data.color,
                    xValueMapper: (ChartData sales, _) => sales.x,
                    yValueMapper: (ChartData sales, _) => sales.y,
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          top: 200.h,
          child: SizedBox(
            width: 0.87.sw,
            child: GridView(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 3.r,
                    crossAxisSpacing: 14.w,
                    mainAxisSpacing: 12.h),
                children: children),
          ),
        )
      ],
    );
  }
}

class ChartData {
  ChartData(this.x, this.y, this.text, this.color);

  final String x;
  final int y;
  final String text;
  final Color color;
}

class HalfClipper extends CustomClipper<Rect> {
  @override
  Rect getClip(Size size) {
    return Rect.fromLTWH(0, 0, size.width, size.height / 2);
  }

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) {
    return false;
  }
}
