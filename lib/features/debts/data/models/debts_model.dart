import 'package:flutter/material.dart';
import 'package:masrofy/core/theme/app_colors.dart';

class DebtsModel {
  final String id;
  final String title;
  final String subtitle;
  final num current; // المبلغ المتبقي
  final num target; // المبلغ الإجمالي
  final Color color;

  const DebtsModel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.current,
    required this.target,
    required this.color,
  });

  double get progress => target == 0 ? 0 : (current / target).clamp(0.0, 1.0);
  int get percentage => (progress * 100).round();
  bool get isActive => current > 0;
  bool get isPaid => current == 0;

  DebtsModel copyWith({
    String? id,
    String? title,
    String? subtitle,
    num? current,
    num? target,
    Color? color,
  }) {
    return DebtsModel(
      id: id ?? this.id,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      current: current ?? this.current,
      target: target ?? this.target,
      color: color ?? this.color,
    );
  }

  factory DebtsModel.fromMap(Map<String, dynamic> map) {
    return DebtsModel(
      id: map['id'] as String? ?? '',
      title: map['title'] as String? ?? '',
      subtitle: map['subtitle'] as String? ?? '',
      current: (map['current'] as num?) ?? 0,
      target: (map['target'] as num?) ?? 0,
      color: Color((map['colorValue'] as int?) ?? AppColors.error.toARGB32()),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'subtitle': subtitle,
      'current': current,
      'target': target,
      'colorValue': color.toARGB32(),
    };
  }
}

final List<DebtsModel> initialDebts = [
  DebtsModel(
    id: '1',
    title: 'قرض شخصي',
    subtitle: 'الأهلي',
    current: 3000,
    target: 6000,
    color: AppColors.error,
  ),
  DebtsModel(
    id: '2',
    title: 'بطاقة ائتمان',
    subtitle: 'البنك التجاري الدولي',
    current: 1250,
    target: 2000,
    color: AppColors.saving,
  ),
  DebtsModel(
    id: '3',
    title: 'دين لصديق',
    subtitle: 'محمود الدسوقي',
    current: 0,
    target: 100,
    color: AppColors.cyan,
  ),
];
