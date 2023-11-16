import 'package:flutter/material.dart';

class Responsive {
  static double w(double w, BuildContext context) {
    return MediaQuery.sizeOf(context).width * (w / 393);
  }

  static double h(double h, BuildContext context) {
    return MediaQuery.sizeOf(context).height * (h / 852);
  }
}
