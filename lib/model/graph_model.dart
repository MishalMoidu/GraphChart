class ChartData {
  ChartData({
    required this.x,
    required this.open,
    required this.close,
    required this.low,
    required this.high,
  });

  DateTime x;
  double open;
  double close;
  double low;
  double high;
}

class LinearChartData {
  LinearChartData({
    required this.x,
    required this.y,
  });

  DateTime x;
  double y;
}
