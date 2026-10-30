import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:masrofy/core/theme/app_colors.dart';
import 'package:masrofy/core/utils/constants/locale_keys.g.dart';
import 'package:masrofy/core/utils/extensions/extensions.dart';

class OverViewModel {
  final String title;
  final FaIconData? icon;
  final Color? color;
  final String currency;
  final String price;
  final Color? valueColor;

  OverViewModel({
    required this.title,
    required this.icon,
    required this.color,
    required this.price,
    required this.currency,
    this.valueColor,
  });
}

List<OverViewModel> getOverviewData(
  BuildContext context, {
  required String todayExpenses,
  required String currentMonthIncome,
  required String totalDebts,
  required String completedGoals,
}) => [
  OverViewModel(
    title: LocaleKeys.todays_expenses.tr(),
    icon: FontAwesomeIcons.receipt,
    color: AppColors.error,
    valueColor: context.isDarkMode
        ? AppColors.textPrimaryDark
        : AppColors.grey800,
    price: todayExpenses,
    currency: LocaleKeys.currency_egp.tr(),
  ),
  OverViewModel(
    title: LocaleKeys.current_month_income.tr(),
    icon: FontAwesomeIcons.moneyBillTrendUp,
    color: AppColors.success,
    valueColor: AppColors.success,
    price: currentMonthIncome,
    currency: LocaleKeys.currency_egp.tr(),
  ),
  OverViewModel(
    title: LocaleKeys.total_debts.tr(),
    icon: FontAwesomeIcons.handHoldingDollar,
    color: AppColors.warning,
    valueColor: AppColors.error,
    price: totalDebts,
    currency: LocaleKeys.currency_egp.tr(),
  ),
  OverViewModel(
    title: LocaleKeys.completed_goals.tr(),
    icon: FontAwesomeIcons.circleCheck,
    color: AppColors.saving,
    valueColor: AppColors.saving,
    price: completedGoals,
    currency: '',
  ),
];
