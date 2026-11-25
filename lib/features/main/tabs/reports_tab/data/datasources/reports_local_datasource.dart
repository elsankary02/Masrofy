import 'dart:convert';

import '../../../../../../core/services/shared_preferences.dart';
import '../models/reports_model.dart';

abstract class ReportsLocalDataSource {
  Future<ReportsModel> getReports({required String filterKey});
}

class ReportsLocalDataSourceImpl implements ReportsLocalDataSource {
  static const String _expensesKey = 'masrofy_expenses_list';
  static const String _incomesKey = 'masrofy_incomes_list';

  double _parseAmount(dynamic raw) {
    if (raw is num) return raw.toDouble();
    if (raw is String) return double.tryParse(raw.trim()) ?? 0;
    return 0;
  }

  DateTime _parseDate(dynamic raw) {
    if (raw is String && raw.trim().isNotEmpty) {
      return DateTime.tryParse(raw) ?? DateTime.now();
    }
    return DateTime.now();
  }

  List _readList(String key, String nestedKey) {
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

  bool _matchesFilter(DateTime date, String filterKey, DateTime now) {
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

  @override
  Future<ReportsModel> getReports({required String filterKey}) async {
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

    return ReportsModel.fromTotals(
      filterKey: filterKey,
      periodExpenses: periodExpenses,
      periodIncome: periodIncome,
      categoryTotals: categoryTotals,
    );
  }
}
