import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:masrofy/core/theme/app_colors.dart';
import 'package:masrofy/core/utils/constants/locale_keys.g.dart';

class CategoryLegendModel {
  final String label;
  final Color color;
  final String percentage;
  final String amount;

  CategoryLegendModel({
    required this.label,
    required this.color,
    required this.percentage,
    required this.amount,
  });
}

final List<CategoryLegendModel> categories = [
  CategoryLegendModel(
    label: LocaleKeys.transportation.tr(),
    color: AppColors.blue,
    percentage: '25%',
    amount: 'EGP 3,850',
  ),
  CategoryLegendModel(
    label: LocaleKeys.food.tr(),
    color: AppColors.expense,
    percentage: '30%',
    amount: 'EGP 4,620',
  ),
  CategoryLegendModel(
    label: LocaleKeys.bills.tr(),
    color: AppColors.accent,
    percentage: '15%',
    amount: 'EGP 2,310',
  ),
  CategoryLegendModel(
    label: LocaleKeys.shopping.tr(),
    color: AppColors.purple,
    percentage: '12%',
    amount: 'EGP 1,848',
  ),
  CategoryLegendModel(
    label: LocaleKeys.entertainment.tr(),
    color: AppColors.orange,
    percentage: '10%',
    amount: 'EGP 1,540',
  ),
  CategoryLegendModel(
    label: LocaleKeys.other.tr(),
    color: AppColors.grey400,
    percentage: '8%',
    amount: 'EGP 1,232',
  ),
];
