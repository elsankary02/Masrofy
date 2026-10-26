import 'package:flutter/material.dart';
import 'package:masrofy/core/theme/app_colors.dart';

class GoalsCardModel {
  final String id;
  final String title;
  final Color color;
  final IconData? icon;
  final int current;
  final int target;

  GoalsCardModel({
    required this.id,
    required this.title,
    required num current,
    required num target,
    this.icon,
    required this.color,
  }) : current = current.toInt(),
       target = target.toInt();
// 
  double get progress => target == 0 ? 0 : current / target;
  int get percentage => (progress * 100).round();
// 
  bool get isActive => current < target;
  bool get isCompleted => current >= target;
}

List<GoalsCardModel> goalModel = [
  GoalsCardModel(
    id: '1',
    title: 'صندوق طوارئ',
    icon: Icons.shield_rounded,
    color: AppColors.cyan,
    current: 4000,
    target: 10000,
  ),

  GoalsCardModel(
    id: '2',
    title: 'شراء لابتوب جديد',
    icon: Icons.laptop_rounded,
    color: AppColors.purple,
    current: 4000,
    target: 35000,
  ),

  GoalsCardModel(
    id: '3',
    title: 'ماوس RGB ردراجون',
    icon: Icons.mouse_rounded,
    color: AppColors.cyan,
    current: 1400,
    target: 1400,
  ),
  GoalsCardModel(
    id: '4',
    title: 'كيبورد RGB ردراجون',
    icon: Icons.keyboard_rounded,
    color: AppColors.purple,
    current: 2000,
    target: 2000,
  ),
];
