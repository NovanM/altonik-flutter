import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ChartData {
  ChartData(this.x, this.y);
  final int x;
  var y;
}

Widget grafik(var arr) {
  final List<ChartData> chartData = [
    ChartData(1, arr[0]),
    ChartData(12, arr[1]),
    ChartData(24, arr[2]),
    ChartData(36, arr[3]),
    ChartData(48, arr[4]),
  ];
  final List<ChartData> dataCounter = [
    ChartData(1, 12),
    ChartData(2, 12),
  ];

  return SfCartesianChart(
    series: <ChartSeries>[
      // Renders line chart
      FastLineSeries<ChartData, int>(
        dataSource: chartData ?? dataCounter,
        xValueMapper: (ChartData data, _) => data.x,
        yValueMapper: (ChartData data, _) => data.y,
      )
    ],
    enableSideBySideSeriesPlacement: false,
  );
}
