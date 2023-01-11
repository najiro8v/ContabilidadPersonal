import 'package:contabilidad/controllers/controller.dart';
import 'package:flutter/material.dart';

//import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

class DataScreen extends StatefulWidget {
  const DataScreen({super.key});

  @override
  State<DataScreen> createState() => _DataScreenState();
}

class _DataScreenState extends State<DataScreen> {
  Map<int, WeekValue> week = {
    1: WeekValue("L", 0),
    2: WeekValue("M", 0),
    3: WeekValue("K", 0),
    4: WeekValue("J", 0),
    5: WeekValue("V", 0),
    6: WeekValue("S", 0),
    7: WeekValue("D", 0),
  };
  List<GDPData> data = <GDPData>[];
  getValuesEntry() async {
    var a = await ValueEntryController.get();

    for (var element in a) {
      final dateInt =
          DateTime.fromMillisecondsSinceEpoch(element.date! * 1000, isUtc: true)
              .weekday;
      week[dateInt]!.value += 1; // element.value!;
    }
    data =
        week.entries.map((e) => GDPData(e.value.name, e.value.value)).toList();
    setState(() {});
    return;
  }

  @override
  void initState() {
    super.initState();
    getValuesEntry();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        _LastEntries(),
        _Filters(),
        _Chart(),
        _LastEntries(),
      ],
    ));
  }
}

class _Chart extends StatelessWidget {
  Map<int, String> week = {
    1: "L",
    2: "M",
    3: "K",
    4: "J",
    5: "V",
    6: "S",
    7: "D",
  };
  List<SalesDaa> chartData = [
    SalesDaa(xValue: 1, yValue: 1.0),
    SalesDaa(xValue: 2, yValue: 2),
    SalesDaa(xValue: 3, yValue: 3),
    SalesDaa(xValue: 4, yValue: 4),
    SalesDaa(xValue: 5, yValue: 5),
    SalesDaa(xValue: 6, yValue: 6),
    SalesDaa(xValue: 7, yValue: 7),
  ];
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
            child: SfSparkBarChart.custom(
                yValueMapper: (e) => chartData[e].yValue,
                xValueMapper: (e) => chartData[e].xValue * 10,
                dataCount: chartData.length,
                axisCrossesAt: 0,
                trackball: SparkChartTrackball(
                    hideDelay: 1,
                    tooltipFormatter: ((details) {
                      return week[(details.x / 10)]!.toString();
                      //data[details.y].toString();
                    }),
                    activationMode: SparkChartActivationMode.tap),
                labelDisplayMode: SparkChartLabelDisplayMode.all)));
  }
}

class SalesDaa {
  double yValue;
  int xValue;
  SalesDaa({required this.yValue, required this.xValue});
}

class SalesData {
  final double yValue;
  SalesData({required this.yValue});
}

class _Filters extends StatelessWidget {
  const _Filters({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
              flex: 1,
              child: TextFormField(
                  decoration: InputDecoration(label: Text("Fecha1")))),
          const SizedBox(width: 10),
          Expanded(
              flex: 1,
              child: TextFormField(
                  decoration: InputDecoration(label: Text("Fecha1")))),
          const SizedBox(width: 10),
          Expanded(
              flex: 1,
              child: TextFormField(
                  decoration: InputDecoration(label: Text("Fecha1")))),
        ],
      ),
    );
  }
}

class _LastEntries extends StatelessWidget {
  const _LastEntries({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [Text("Last")],
            ),
            Column(
              children: [Text("Last")],
            ),
          ],
          /* child: SfSparkBarChart(
            data: data.entries.map((e) => e.key).toList(),
            axisCrossesAt: 0,
            trackball: SparkChartTrackball(
                dashArray: [1, 5, 10, 15],
                hideDelay: 1,
                tooltipFormatter: ((details) {
                  details;
                  return data[details.y].toString();
                }),
                activationMode: SparkChartActivationMode.tap),
            labelDisplayMode: SparkChartLabelDisplayMode.all),*/
        )
        //Initialize the chart widget
        /*SfCartesianChart(
              primaryXAxis: CategoryAxis(),
              // Chart title
              title: ChartTitle(text: 'Half yearly sales analysis'),
              // Enable legend
              legend: Legend(isVisible: true),
              // Enable tooltip
              tooltipBehavior: TooltipBehavior(enable: true),
              series: <ChartSeries<_SalesData, String>>[
                LineSeries<_SalesData, String>(
                    dataSource: data,
                    xValueMapper: (_SalesData sales, _) => sales.year,
                    yValueMapper: (_SalesData sales, _) => sales.sales,
                    name: 'Sales',
                    // Enable data label
                    dataLabelSettings: DataLabelSettings(isVisible: true))
              ]),*/

        /* Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              //Initialize the spark charts widget
              child: SfSparkLineChart.custom(
                //Enable the trackball
                trackball: SparkChartTrackball(
                    activationMode: SparkChartActivationMode.tap),
                //Enable marker
                marker: SparkChartMarker(
                    displayMode: SparkChartMarkerDisplayMode.all),
                //Enable data label
                labelDisplayMode: SparkChartLabelDisplayMode.all,
                xValueMapper: (int index) => data[index].year,
                yValueMapper: (int index) => data[index].sales,
                dataCount: 5,
              ),
            ),
          )*/
        );
  }
}

class GDPData {
  GDPData(this.x, this.y);
  final String x;
  final double y;
}

class WeekValue {
  WeekValue(this.name, this.value);
  final String name;
  double value;
}
