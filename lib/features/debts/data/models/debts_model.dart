import 'package:flutter/material.dart';
import 'package:masrofy/core/theme/app_colors.dart';

class DebtsModel {
  final String id;
  final String title; // مثل: قرض شخصي، بطاقة ائتمان
  final String subtitle; // مثل: الأهلد
  final num current; // المبلغ المتبقي
  final num target; // المبلغ الإجمالي
  final Color color; // لون شريط التقدم

  DebtsModel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.current,
    required this.target,
    required this.color,
  });

  double get progress => target == 0 ? 0 : current / target;
  int get percentage => (progress * 100).round();
  bool get isActive => current > 0;
  bool get isPaid => current == 0;
}

final List<DebtsModel> debtsModel = [
  DebtsModel(
    id: '1',
    title: 'قرض شخصي',
    subtitle: 'الأهلي',
    current: 3000, // 3,000 EGP متبقي
    target: 6000, // 6,000 EGP الإجمالي
    color: AppColors.error, // اللون الأحمر/الوردي البارز في الصورة
  ),
  DebtsModel(
    id: '2',
    title: 'بطاقة ائتمان',
    subtitle: 'البنك التجاري الدولي',
    current: 1250, // 1,250 EGP متبقي
    target: 2000, // 2,000 EGP الإجمالي
    color: AppColors.saving, // اللون البنفسجي/الأزرق البارز في الصورة
  ),
  DebtsModel(
    id: '3',
    title: 'دين لصديق',
    subtitle: 'محمود الدسوقي',
    current: 0, //   متبقي
    target: 100, //   الإجمالي
    color: AppColors.cyan, // اللون الأخضر البارز في الصورة
  ),
];
