import 'package:flutter/material.dart';

extension Extensions on BuildContext {
  double get h => MediaQuery.sizeOf(this).height;
  double get w => MediaQuery.sizeOf(this).width;
  TextTheme get textTheme => Theme.of(this).textTheme;
  ThemeData get theme => Theme.of(this);
}
