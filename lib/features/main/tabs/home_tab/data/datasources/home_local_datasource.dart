import 'dart:convert';

import 'package:masrofy/core/services/shared_preferences.dart';
import 'package:masrofy/features/main/tabs/home_tab/data/model/home_summary_model.dart';

abstract class HomeLocalDataSource {
  Future<HomeSummaryModel> getHomeSummary();
}

class HomeLocalDataSourceImpl implements HomeLocalDataSource {
  static const String _expensesKey = 'masrofy_expenses_list';
  static const String _incomesKey = 'masrofy_incomes_list';
  static const String _debtsKey = 'masrofy_debts_list';
  static const String _goalsKey = 'masrofy_goals_list';

  @override
  Future<HomeSummaryModel> getHomeSummary() async {
    final now = DateTime.now();

    final expensesRaw = SPService.getString(_expensesKey);
    int todayExpenses = 0;
    int totalExpenses = 0;
    if (expensesRaw != null && expensesRaw.trim().isNotEmpty) {
      final List<dynamic> list = jsonDecode(expensesRaw) as List<dynamic>;
      for (final item in list) {
        final map = item as Map<String, dynamic>;
        final amount = ((map['amount'] as num?) ?? 0).round();
        totalExpenses += amount;

        final parsedDate = DateTime.tryParse(map['date']?.toString() ?? '');
        if (parsedDate != null &&
            parsedDate.year == now.year &&
            parsedDate.month == now.month &&
            parsedDate.day == now.day) {
          todayExpenses += amount;
        }
      }
    }

    final incomesRaw = SPService.getString(_incomesKey);
    int totalIncome = 0;
    if (incomesRaw != null && incomesRaw.trim().isNotEmpty) {
      final List<dynamic> list = jsonDecode(incomesRaw) as List<dynamic>;
      for (final item in list) {
        final map = item as Map<String, dynamic>;
        totalIncome += ((map['amount'] as num?) ?? 0).round();
      }
    }

    final debtsRaw = SPService.getString(_debtsKey);
    int remainingDebts = 0;
    if (debtsRaw != null && debtsRaw.trim().isNotEmpty) {
      final List<dynamic> list = jsonDecode(debtsRaw) as List<dynamic>;
      for (final item in list) {
        final map = item as Map<String, dynamic>;
        final total = ((map['total'] as num?) ?? 0).round();
        final paid = ((map['paid'] as num?) ?? 0).round();
        final rem = total - paid;
        if (rem > 0) remainingDebts += rem;
      }
    }

    final goalsRaw = SPService.getString(_goalsKey);
    int completedGoals = 0;
    int totalGoals = 0;
    if (goalsRaw != null && goalsRaw.trim().isNotEmpty) {
      final List<dynamic> list = jsonDecode(goalsRaw) as List<dynamic>;
      totalGoals = list.length;
      for (final item in list) {
        final map = item as Map<String, dynamic>;
        final current = ((map['current'] as num?) ?? 0).round();
        final target = ((map['target'] as num?) ?? 0).round();
        if (target > 0 && current >= target) {
          completedGoals++;
        }
      }
    }

    return HomeSummaryModel(
      todayExpenses: todayExpenses,
      totalExpenses: totalExpenses,
      currentMonthIncome: totalIncome,
      totalIncome: totalIncome,
      remainingDebts: remainingDebts,
      completedGoalsCount: completedGoals,
      totalGoalsCount: totalGoals,
    );
  }
}
