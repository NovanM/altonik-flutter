part of 'widget.dart';

class ChartData {
  ChartData(this.x, this.y, [this.color]);
  final String x;
  final double y;
  final Color color;
}

Widget doughnatChart(String name, double width, double height, int value) {
  double dataVol = 100;
  double currentDataVol = value.toDouble();

  print(currentDataVol);
  dataVol -= currentDataVol;
  if (dataVol < 0) {
    dataVol = 0;
  }
  List<ChartData> chartData = [
    ChartData('isFull', dataVol, volumeColor),
    ChartData('currentstate', currentDataVol, mainColor),
  ];

  return Column(
    children: [
      Container(
        width: width,
        height: height,
        child: SfCircularChart(annotations: <CircularChartAnnotation>[
          CircularChartAnnotation(
              widget: Container(
                  child: PhysicalModel(
                      child: Container(),
                      shape: BoxShape.circle,
                      elevation: 10,
                      shadowColor: Colors.black,
                      color: const Color.fromRGBO(230, 230, 230, 1)))),
          CircularChartAnnotation(
            widget: Container(
              child: Text(
                currentDataVol.toInt().toString() + "%",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              ),
            ),
          )
        ], series: <CircularSeries>[
          DoughnutSeries<ChartData, String>(
              dataSource: chartData,
              xValueMapper: (ChartData data, _) => data.x,
              yValueMapper: (ChartData data, _) => data.y,
              pointColorMapper: (ChartData data, _) => data.color,
              // Radius of doughnut
              radius: "100%")
        ]),
      ),
      Text(
        "Volume $name",
        style: TextStyle(color: Colors.black, fontSize: 24),
      ),
    ],
  );
}
