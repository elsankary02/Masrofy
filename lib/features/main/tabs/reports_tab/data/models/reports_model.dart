import 'package:easy_localization/easy_localization.dart';

import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/utils/constants/locale_keys.g.dart';
import '../../domain/entities/reports_entity.dart';

class ReportsModel extends ReportsEntity {
  const ReportsModel({
    required super.filterKey,
    required super.summaryCards,
    required super.categories,
    required super.totalExpensesAmount,
  });

  factory ReportsModel.fromTotals({
    required String filterKey,
    required double periodExpenses,
    required double periodIncome,
    required Map<String, double> categoryTotals,
  }) {
    final netIncome = periodIncome - periodExpenses;
    final savingsRate = periodIncome > 0
        ? (((periodIncome - periodExpenses) / periodIncome) * 100)
              .clamp(-100, 100)
              .round()
        : 0;

    final categoryMeta = [
      ('food', LocaleKeys.food.tr(), AppColors.expense),
      ('transportation', LocaleKeys.transportation.tr(), AppColors.blue),
      ('bills', LocaleKeys.bills.tr(), AppColors.accent),
      ('shopping', LocaleKeys.shopping.tr(), AppColors.purple),
      ('entertainment', LocaleKeys.entertainment.tr(), AppColors.orange),
      ('other', LocaleKeys.other.tr(), AppColors.grey400),
    ];

    final categories = categoryMeta.map((meta) {
      final value = categoryTotals[meta.$1] ?? 0;
      final fraction = periodExpenses > 0 ? (value / periodExpenses) : 0.0;
      return CategoryBreakdownEntity(
        keyName: meta.$1,
        label: meta.$2,
        color: meta.$3,
        amount: value,
        fraction: fraction,
      );
    }).toList();

    final summaryCards = [
      SummaryCardEntity(
        label: LocaleKeys.total_expenses.tr(),
        amount: periodExpenses.round().toString(),
        subText: LocaleKeys.from_last_month.tr(),
      ),
      SummaryCardEntity(
        label: LocaleKeys.total_income_alt.tr(),
        amount: periodIncome.round().toString(),
        subText: LocaleKeys.from_last_month.tr(),
      ),
      SummaryCardEntity(
        label: LocaleKeys.savings_rate.tr(),
        amount: '$savingsRate%',
        subText: LocaleKeys.from_income.tr(),
        isPercentage: true,
      ),
      SummaryCardEntity(
        label: LocaleKeys.net_income.tr(),
        amount: netIncome.round().toString(),
        subText: LocaleKeys.current_month_income.tr(),
      ),
    ];

    return ReportsModel(
      filterKey: filterKey,
      summaryCards: summaryCards,
      categories: categories,
      totalExpensesAmount: periodExpenses.round(),
    );
  }
}
