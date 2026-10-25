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

  double get progress => target == 0 ? 0 : current / target;
  int get percentage => (progress * 100).round();
  bool get isAcitve => current < target;
}

List<GoalsCardModel> goalModel = [
  GoalsCardModel(
    id: '1',
    title: 'شراء سيارة',
    icon: Icons.directions_car_filled_rounded,
    color: AppColors.saving,
    current: 0,
    target: 250000,
  ),
  GoalsCardModel(
    id: '2',
    title: 'سفر ألمانيا',
    icon: Icons.flight_takeoff_rounded,
    color: AppColors.income,
    current: 0,
    target: 23000,
  ),
  GoalsCardModel(
    id: '3',
    title: 'صندوق طوارئ',
    icon: Icons.shield_rounded,
    color: AppColors.cyan,
    current: 4000,
    target: 10000,
  ),
  GoalsCardModel(
    id: '4',
    title: 'شراء منزل',
    icon: Icons.home_rounded,
    color: AppColors.expense,
    current: 0,
    target: 500000,
  ),
  GoalsCardModel(
    id: '5',
    title: 'شراء لابتوب جديد',
    icon: Icons.laptop_rounded,
    color: AppColors.purple,
    current: 4000,
    target: 30000,
  ),

  GoalsCardModel(
    id: '6',
    title: 'مشروع تجاري مصغر',
    icon: Icons.store_rounded,
    color: AppColors.saving,
    current: 4000,
    target: 100000,
  ),
  GoalsCardModel(
    id: '7',
    title: 'ماوس RGB ردراجون',
    icon: Icons.mouse_rounded,
    color: AppColors.cyan,
    current: 1400,
    target: 1400,
  ),
  GoalsCardModel(
    id: '8',
    title: 'كيبورد RGB ردراجون',
    icon: Icons.keyboard_rounded,
    color: AppColors.purple,
    current: 2000,
    target: 2000,
  ),
];
