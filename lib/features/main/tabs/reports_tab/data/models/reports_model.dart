import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:masrofy/core/theme/app_colors.dart';
import 'package:masrofy/core/utils/constants/locale_keys.g.dart';

class ReportsModel {
  final String label;
  final String amount;
  final String? changeText;
  final Color? changeColor;
  final String subText;
  final bool isPercentage;

  ReportsModel({
    required this.label,
    required this.amount,
    this.changeText,
    this.changeColor,
    required this.subText,
    this.isPercentage = false,
  });
}

List<ReportsModel> reportsData(BuildContext context) {
  return [
    ReportsModel(
      label: LocaleKeys.total_expenses.tr(),
      amount: "15,400",
      changeText: "8% ▼",
      changeColor: AppColors.expense,
      subText: LocaleKeys.from_last_month.tr(),
    ),
    ReportsModel(
      label: LocaleKeys.total_income_alt.tr(),
      amount: "27,850",
      changeText: "12% ▲",
      changeColor: AppColors.income,
      subText: LocaleKeys.from_last_month.tr(),
    ),
    ReportsModel(
      label: LocaleKeys.savings_rate.tr(),
      amount: "45%",
      subText: LocaleKeys.from_income.tr(),
      isPercentage: true,
    ),
    ReportsModel(
      label: LocaleKeys.net_income.tr(),
      amount: "12,450",
      subText: LocaleKeys.current_month_income.tr(),
    ),
  ];
}
