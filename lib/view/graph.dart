import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:graph_project/utilities/responsive.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../model/graph_model.dart';

class CandlestickChartApp extends StatefulWidget {
  const CandlestickChartApp({super.key});

  @override
  State<CandlestickChartApp> createState() => _CandlestickChartAppState();
}

class _CandlestickChartAppState extends State<CandlestickChartApp> {
  List<ChartData> chartData = [];
  List<LinearChartData> linearChartData = [];

  @override
  void initState() {
    super.initState();

    Timer.periodic(const Duration(seconds: 1), (timer) {
      updateChartData();
    });
  }

  void updateChartData() {
    double open = 50 + (Random().nextDouble() * 50);
    double close = open + (Random().nextDouble() * 10);
    double high = max(open, close) + (Random().nextDouble() * 10);
    double low = min(open, close) - (Random().nextDouble() * 10);

    chartData.add(ChartData(
      x: DateTime.now(),
      open: open,
      close: close,
      high: high,
      low: low,
    ));

    double yValue = 50 + (Random().nextDouble() * 60);

    linearChartData.add(LinearChartData(
      x: DateTime.now(),
      y: yValue,
    ));

    if (chartData.length > 50) {
      chartData.removeAt(0);
    }

    if (linearChartData.length > 100) {
      linearChartData.removeAt(0);
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff111111),
      appBar: AppBar(
        backgroundColor: const Color(0xff111111),
        title: const Text(
          'Graph Chart',
          style: TextStyle(color: Colors.grey),
        ),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundColor: Colors.blue,
                radius: Responsive.w(5, context),
              ),
              SizedBox(
                width: Responsive.w(10, context),
              ),
              const Text(
                "ADA - USDT",
                style: TextStyle(color: Colors.grey),
              ),
              SizedBox(
                width: Responsive.w(10, context),
              ),
              const Icon(
                Icons.remove,
                color: Colors.green,
              ),
              SizedBox(
                width: Responsive.w(10, context),
              ),
              const Text(
                "TMA",
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
          SfCartesianChart(
            primaryXAxis: DateTimeAxis(
              majorGridLines: const MajorGridLines(width: 0),
              majorTickLines: const MajorTickLines(size: 0),
            ),
            primaryYAxis: NumericAxis(
              majorGridLines: const MajorGridLines(width: 0),
              majorTickLines: const MajorTickLines(size: 0),
            ),
            series: <ChartSeries>[
              CandleSeries<ChartData, DateTime>(
                dataSource: chartData,
                xValueMapper: (ChartData sales, _) => sales.x,
                lowValueMapper: (ChartData sales, _) => sales.low,
                highValueMapper: (ChartData sales, _) => sales.high,
                openValueMapper: (ChartData sales, _) => sales.open,
                closeValueMapper: (ChartData sales, _) => sales.close,
                bullColor: Colors.green,
                bearColor: Colors.red,
                isVisible: true,
              ),
              LineSeries<LinearChartData, DateTime>(
                dataSource: linearChartData,
                xValueMapper: (LinearChartData sales, _) => sales.x,
                yValueMapper: (LinearChartData sales, _) => sales.y,
                color: Colors.green,
              ),
            ],
            trackballBehavior: TrackballBehavior(
              enable: true,
              activationMode: ActivationMode.singleTap,
              tooltipAlignment: ChartAlignment.center,
              tooltipDisplayMode: TrackballDisplayMode.floatAllPoints,
              tooltipSettings: const InteractiveTooltip(
                format:
                    'O: point.open \nH: point.high\nL: point.low\nC: point.close\nY: point.y',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
