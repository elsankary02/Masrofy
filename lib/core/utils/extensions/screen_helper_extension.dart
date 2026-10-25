import 'package:flutter/material.dart';

extension ScreenHelperExtension on BuildContext {
  // الارتفاع والعرض الكلي للشاشة
  double get h => MediaQuery.sizeOf(this).height;
  double get w => MediaQuery.sizeOf(this).width;
  EdgeInsets get viewInsets => MediaQuery.of(this).viewInsets;

  // =================== نسب الارتفاع (Height Percentages) ===================
  double get h3 => h * 0.003;
  double get h5 => h * 0.005;
  double get h10 => h * 0.010;
  double get h15 => h * 0.015;
  double get h20 => h * 0.020;
  double get h25 => h * 0.025;
  double get h30 => h * 0.030;
  double get h35 => h * 0.035;
  double get h40 => h * 0.040;
  double get h45 => h * 0.045;
  double get h50 => h * 0.050;
  double get h55 => h * 0.055;
  double get h60 => h * 0.060;
  double get h65 => h * 0.065;
  double get h70 => h * 0.070;
  double get h75 => h * 0.075;
  double get h80 => h * 0.080;
  double get h85 => h * 0.085;
  double get h90 => h * 0.090;
  double get h95 => h * 0.095;
  double get h100 => h * 0.100;
  double get h110 => h * 0.110;
  double get h120 => h * 0.120;
  double get h130 => h * 0.130;
  double get h150 => h * 0.150;
  double get h200 => h * 0.200;
  double get h250 => h * 0.250;
  double get h300 => h * 0.300;

  // =================== نسب العرض (Width Percentages) ===================
  double get w3 => w * 0.003;
  double get w5 => w * 0.005;
  double get w10 => w * 0.010;
  double get w15 => w * 0.015;
  double get w20 => w * 0.020;
  double get w25 => w * 0.025;
  double get w30 => w * 0.030;
  double get w35 => w * 0.035;
  double get w40 => w * 0.040;
  double get w45 => w * 0.045;
  double get w50 => w * 0.050;
  double get w55 => w * 0.055;
  double get w60 => w * 0.060;
  double get w65 => w * 0.065;
  double get w70 => w * 0.070;
  double get w75 => w * 0.075;
  double get w80 => w * 0.080;
  double get w85 => w * 0.085;
  double get w90 => w * 0.090;
  double get w95 => w * 0.095;
  double get w100 => w * 0.100;
  double get w150 => w * 0.150;
  double get w200 => w * 0.200;
  double get w250 => w * 0.250;
  double get w300 => w * 0.300;
}
