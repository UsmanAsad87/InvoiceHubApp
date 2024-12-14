import 'package:fl_chart/fl_chart.dart';
import 'package:invoice_producer/commons/common_functions/date_time_methods.dart';
import 'package:invoice_producer/commons/common_imports/apis_commons.dart';
import 'package:invoice_producer/commons/common_imports/common_libs.dart';

import '../../../../core/enums/date_filter_type.dart';
import '../controller/date_filter_provider.dart';

class LineGraphHelper {
  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    final currentDate = DateTime.now();
    final currentMonth = getMonthName(currentDate);
    final startDate = DateTime(currentDate.year, currentDate.month, 1);
    final lastDate = DateTime(currentDate.year, currentDate.month + 1, 1)
        .subtract(Duration(days: 1));
    int totalDaysInMonth = lastDate.day;
    List<int> positions = [
      1,
      (totalDaysInMonth / 3).round(),
      (totalDaysInMonth * 2 / 3).round(),
      totalDaysInMonth
    ];

    num day = startDate.day + value.toInt() - 1;

    final style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: MyFonts.size12,
    );
    if (day >= 1 && day <= lastDate.day && positions.contains(day.toInt())) {
      return SideTitleWidget(
        axisSide: meta.axisSide,
        child: Text('$day $currentMonth', style: style),
      );
    } else {
      return SideTitleWidget(
        axisSide: meta.axisSide,
        child: Text('', style: style),
      );
    }
  }

  /// week
  Widget bottomTitleWeeklyWidgets(double value, TitleMeta meta) {
    final now = DateTime.now();
    final startDate = now.subtract(Duration(days: now.weekday - 1));
    num day = startDate.day + value.toInt() - 1;
    final style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: MyFonts.size12,
    );
    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Text('$day', style: style),
    );
  }

  /// yearly
  Widget bottomTitleYearlyWidgets(double value, TitleMeta meta) {
    final currentDate = DateTime.now();
    final startYear = currentDate.year;
    final startDate = DateTime(startYear, 1, 1);

    // Display 12 months
    List<String> months = [
      'Jan',
      '',
      '',
      '',
      '',
      'Jun',
      '',
      '',
      '',
      '',
      '',
      'Dec'
    ];

    num monthIndex = startDate.month + value.toInt() - 1;

    final style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: MyFonts.size12,
    );

    // Get the month name based on the current value
    String getMonthNameFromValue(num value) {
      return months[value.toInt() % 12];
    }

    if (monthIndex >= 0 && monthIndex < 12) {
      return SideTitleWidget(
        axisSide: meta.axisSide,
        child: Text('${getMonthNameFromValue(monthIndex)}', style: style),
      );
    }
    else {
      return SideTitleWidget(
        axisSide: meta.axisSide,
        child: Text('', style: style),
      );
    }
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    final style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: MyFonts.size12,
    );
    String text;
    switch (value.toInt()) {
      case 0:
        text = '0';
        break;
      case 20:
        text = '20';
        break;
      case 40:
        text = '40';
        break;
      case 60:
        text = '60';
        break;
      case 80:
        text = '80';
        break;
      case 100:
        text = '100';
        break;
      default:
        return Container();
    }
    return Text(text, style: style, textAlign: TextAlign.left);
  }

  LineTouchData get lineTouchData1 => LineTouchData(
        handleBuiltInTouches: true,
        // touchTooltipData: LineTouchTooltipData(
        //   tooltipBgColor: Colors.blueGrey.withOpacity(0.8),
        // ),
      );

  FlTitlesData titlesData1({required WidgetRef ref}) => FlTitlesData(
        bottomTitles: AxisTitles(
          sideTitles: bottomTitles(ref: ref),
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        leftTitles: AxisTitles(
          sideTitles: leftTitles(),
        ),
      );

  List<LineChartBarData> get lineBarsData1 => [
        lineChartBarData1_1,
        lineChartBarData1_2,
        lineChartBarData1_3,
      ];

  SideTitles leftTitles() => SideTitles(
        getTitlesWidget: leftTitleWidgets,
        showTitles: true,
        interval: 20,
        reservedSize: 40,
      );

  SideTitles bottomTitles({required WidgetRef ref}) => SideTitles(
      showTitles: true,
      reservedSize: 32,
      interval: 1,
      getTitlesWidget: getTiles(ref.watch(selectedInvoiceDateFilterProvider))
      );

  getTiles(selectedFilter) {
    switch (selectedFilter) {
      case DateFilterType.weekly:
        return bottomTitleWeeklyWidgets;
      case DateFilterType.yearly:
        return bottomTitleYearlyWidgets;
      default:
        return bottomTitleWidgets;
    }
  }

  FlGridData get gridData => FlGridData(
        show: true,
        drawHorizontalLine: true,
        horizontalInterval: 20,
        drawVerticalLine: false,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: MyColors.black.withOpacity(.3),
            strokeWidth: 1,
          );
        },
      );

  FlBorderData get borderData => FlBorderData(
        show: true,
        border: Border(
          bottom: BorderSide(color: MyColors.black.withOpacity(.3), width: 1),
          left: const BorderSide(
            color: Colors.transparent,
          ),
          right: const BorderSide(color: Colors.transparent),
          top: BorderSide(color: MyColors.black.withOpacity(.3), width: 1),
        ),
      );

  LineChartBarData get lineChartBarData1_1 => LineChartBarData(
        isCurved: true,
        color: MyColors.companyColor,
        // AppColors.contentColorGreen,
        barWidth: 2,
        isStrokeCapRound: true,
        dotData: const FlDotData(show: false),
        belowBarData: BarAreaData(show: false),
        spots: const [
          FlSpot(1, 1),
          FlSpot(3, 1.5),
          FlSpot(5, 1.4),
          FlSpot(7, 3.4),
          FlSpot(10, 2),
          FlSpot(12, 2.2),
          FlSpot(13, 1.8),
        ],
      );

  LineChartBarData get lineChartBarData1_2 => LineChartBarData(
        isCurved: true,
        color: MyColors.productColor,
        barWidth: 2,
        isStrokeCapRound: true,
        dotData: const FlDotData(show: false),
        belowBarData: BarAreaData(
          show: false,
          color: MyColors.red, // AppColors.contentColorPink.withOpacity(0),
        ),
        spots: const [
          FlSpot(1, 1),
          FlSpot(3, 2.8),
          FlSpot(7, 1.2),
          FlSpot(10, 2.8),
          FlSpot(12, 2.6),
          FlSpot(13, 3.9),
        ],
      );

  LineChartBarData get lineChartBarData1_3 => LineChartBarData(
        isCurved: true,
        color: MyColors.overdueColor,
        // AppColors.contentColorCyan,
        barWidth: 2,
        isStrokeCapRound: true,
        dotData: const FlDotData(show: false),
        belowBarData: BarAreaData(show: false),
        spots: const [
          FlSpot(1, 2.8),
          FlSpot(3, 1.9),
          FlSpot(6, 3),
          FlSpot(10, 1.3),
          FlSpot(13, 2.5),
          FlSpot(17, 2.8),
          FlSpot(23, 1.9),
          FlSpot(34, 3),
          FlSpot(27, 1.3),
          FlSpot(18, 2.5),
        ],
      );
}
