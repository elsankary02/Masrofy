import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../core/services/shared_preferences.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/utils/constants/locale_keys.g.dart';

class ReportCardItem {
  final String label;
  final String amount;
  final String? changeText;
  final Color? changeColor;
  final String subText;
  final bool isPercentage;

  const ReportCardItem({
    required this.label,
    required this.amount,
    this.changeText,
    this.changeColor,
    required this.subText,
    this.isPercentage = false,
  });
}

class CategoryReportItem {
  final String keyName;
  final String label;
  final Color color;
  final double amount;
  final double fraction;

  const CategoryReportItem({
    required this.keyName,
    required this.label,
    required this.color,
    required this.amount,
    required this.fraction,
  });

  String get percentageText => '${(fraction * 100).round()}%';
  String get formattedAmount => 'EGP ${amount.round()}';
}

class ReportsSnapshot {
  final List<ReportCardItem> summaryCards;
  final List<CategoryReportItem> categories;
  final int totalExpensesAmount;

  const ReportsSnapshot({
    required this.summaryCards,
    required this.categories,
    required this.totalExpensesAmount,
  });
}

class ReportsCalculator {
  static const String _expensesKey = 'masrofy_expenses_list';
  static const String _incomesKey = 'masrofy_incomes_list';

  static double _parseAmount(dynamic raw) {
    if (raw is num) return raw.toDouble();
    if (raw is String) return double.tryParse(raw.trim()) ?? 0;
    return 0;
  }

  static DateTime _parseDate(dynamic raw) {
    if (raw is String && raw.trim().isNotEmpty) {
      return DateTime.tryParse(raw) ?? DateTime.now();
    }
    return DateTime.now();
  }

  static List<dynamic> _readList(String key, String nestedKey) {
    final raw = SPService.getString(key);
    if (raw == null || raw.trim().isEmpty) return const [];
    final decoded = jsonDecode(raw);
    if (decoded is List) {
      return decoded
          .whereType<Map>()
          .map((item) => Map<String, dynamic>.from(item))
          .toList();
    }
    if (decoded is Map && decoded[nestedKey] is List) {
      return (decoded[nestedKey] as List)
          .whereType<Map>()
          .map((item) => Map<String, dynamic>.from(item))
          .toList();
    }
    return const [];
  }

  static bool _matchesFilter(DateTime date, String filterKey, DateTime now) {
    switch (filterKey) {
      case 'this_week':
        final weekStart = DateTime(
          now.year,
          now.month,
          now.day,
        ).subtract(Duration(days: now.weekday - 1));
        return !date.isBefore(weekStart);
      case 'last_month':
        final prevMonth = DateTime(now.year, now.month - 1);
        return date.year == prevMonth.year && date.month == prevMonth.month;
      case 'this_year':
        return date.year == now.year;
      case 'this_month':
      default:
        return date.year == now.year && date.month == now.month;
    }
  }

  static ReportsSnapshot calculate(String filterKey) {
    final now = DateTime.now();
    final expenses = _readList(_expensesKey, 'expenses');
    final incomes = _readList(_incomesKey, 'incomes');

    double periodExpenses = 0;
    double periodIncome = 0;

    final Map<String, double> categoryTotals = {
      'food': 0,
      'transportation': 0,
      'bills': 0,
      'shopping': 0,
      'entertainment': 0,
      'other': 0,
    };

    for (final item in expenses) {
      final amount = _parseAmount(item['amount']);
      if (amount <= 0) continue;
      final date = _parseDate(item['date'] ?? item['createdAt']);
      if (!_matchesFilter(date, filterKey, now)) continue;

      periodExpenses += amount;
      final rawCat = (item['category'] ?? 'other')
          .toString()
          .toLowerCase()
          .trim();
      if (categoryTotals.containsKey(rawCat)) {
        categoryTotals[rawCat] = (categoryTotals[rawCat] ?? 0) + amount;
      } else {
        categoryTotals['other'] = (categoryTotals['other'] ?? 0) + amount;
      }
    }

    for (final item in incomes) {
      final amount = _parseAmount(item['amount']);
      if (amount <= 0) continue;
      final date = _parseDate(item['date'] ?? item['createdAt']);
      if (!_matchesFilter(date, filterKey, now)) continue;

      periodIncome += amount;
    }

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
      return CategoryReportItem(
        keyName: meta.$1,
        label: meta.$2,
        color: meta.$3,
        amount: value,
        fraction: fraction,
      );
    }).toList();

    final summaryCards = [
      ReportCardItem(
        label: LocaleKeys.total_expenses.tr(),
        amount: periodExpenses.round().toString(),
        subText: LocaleKeys.from_last_month.tr(),
      ),
      ReportCardItem(
        label: LocaleKeys.total_income_alt.tr(),
        amount: periodIncome.round().toString(),
        subText: LocaleKeys.from_last_month.tr(),
      ),
      ReportCardItem(
        label: LocaleKeys.savings_rate.tr(),
        amount: '$savingsRate%',
        subText: LocaleKeys.from_income.tr(),
        isPercentage: true,
      ),
      ReportCardItem(
        label: LocaleKeys.net_income.tr(),
        amount: netIncome.round().toString(),
        subText: LocaleKeys.current_month_income.tr(),
      ),
    ];

    return ReportsSnapshot(
      summaryCards: summaryCards,
      categories: categories,
      totalExpensesAmount: periodExpenses.round(),
    );
  }
}
