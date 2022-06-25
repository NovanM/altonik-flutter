import 'package:flutter/cupertino.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ChartData {
  ChartData(this.x, this.y);
  final int x;
  final double y;
}

Widget grafik() {
  final List<ChartData> chartData = [
    ChartData(1, 12),
    ChartData(12, 20),
    ChartData(24, 30),
    ChartData(36, 20),
    ChartData(48, 40),
    ChartData(60, 70),
  ];

  return SfCartesianChart(
    series: <ChartSeries>[
      // Renders line chart
      FastLineSeries<ChartData, int>(
          dataSource: chartData,
          xValueMapper: (ChartData data, _) => data.x,
          yValueMapper: (ChartData data, _) => data.y)
    ],
    enableSideBySideSeriesPlacement: false,
  );
}
