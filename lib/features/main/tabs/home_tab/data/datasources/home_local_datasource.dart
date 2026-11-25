import 'dart:convert';

import '../../../../../../core/services/shared_preferences.dart';
import '../model/home_summary_model.dart';

abstract class HomeLocalDataSource {
  Future<HomeSummaryModel> getHomeSummary();
}

class HomeLocalDataSourceImpl implements HomeLocalDataSource {
  static const String _expensesKey = 'masrofy_expenses_list';
  static const String _incomesKey = 'masrofy_incomes_list';
  static const String _debtsKey = 'masrofy_debts_list';
  static const String _goalsKey = 'masrofy_goals_list';

  num? _parseNum(dynamic value) {
    if (value is num) return value;
    if (value is String) return num.tryParse(value.trim());
    return null;
  }

  List<dynamic> _decodeList(String? rawJson, {String? nestedMapKey}) {
    if (rawJson == null || rawJson.trim().isEmpty) return const [];
    final decoded = jsonDecode(rawJson);
    if (decoded is List) return decoded;
    if (decoded is Map &&
        nestedMapKey != null &&
        decoded[nestedMapKey] is List) {
      return decoded[nestedMapKey] as List<dynamic>;
    }
    return const [];
  }

  @override
  Future<HomeSummaryModel> getHomeSummary() async {
    final now = DateTime.now();

    final expensesRaw = SPService.getString(_expensesKey);
    int todayExpenses = 0;
    int totalExpenses = 0;
    for (final item in _decodeList(expensesRaw, nestedMapKey: 'expenses')) {
      if (item is! Map) continue;
      final map = Map<String, dynamic>.from(item);
      final amount = (_parseNum(map['amount']) ?? 0).round();
      totalExpenses += amount;

      final parsedDate = DateTime.tryParse(map['date']?.toString() ?? '');
      if (parsedDate != null &&
          parsedDate.year == now.year &&
          parsedDate.month == now.month &&
          parsedDate.day == now.day) {
        todayExpenses += amount;
      }
    }

    final incomesRaw = SPService.getString(_incomesKey);
    int totalIncome = 0;
    for (final item in _decodeList(incomesRaw, nestedMapKey: 'incomes')) {
      if (item is! Map) continue;
      final map = Map<String, dynamic>.from(item);
      totalIncome += (_parseNum(map['amount']) ?? 0).round();
    }

    final debtsRaw = SPService.getString(_debtsKey);
    int remainingDebts = 0;
    for (final item in _decodeList(debtsRaw, nestedMapKey: 'debts')) {
      if (item is! Map) continue;
      final map = Map<String, dynamic>.from(item);

      final directRemaining = _parseNum(
        map['current'] ?? map['remaining'] ?? map['remainingAmount'],
      );
      if (directRemaining != null) {
        if (directRemaining > 0) {
          remainingDebts += directRemaining.round();
        }
        continue;
      }

      final total =
          (_parseNum(map['target'] ?? map['total'] ?? map['amount']) ?? 0)
              .round();
      final paid = (_parseNum(map['paid'] ?? map['paidAmount']) ?? 0).round();
      final rem = total - paid;
      if (rem > 0) {
        remainingDebts += rem;
      }
    }

    final goalsRaw = SPService.getString(_goalsKey);
    int completedGoals = 0;
    int totalGoals = 0;
    final goalsList = _decodeList(goalsRaw, nestedMapKey: 'goals');
    totalGoals = goalsList.length;
    for (final item in goalsList) {
      if (item is! Map) continue;
      final map = Map<String, dynamic>.from(item);
      final current =
          (_parseNum(map['current'] ?? map['currentAmount'] ?? map['saved']) ??
                  0)
              .round();
      final target =
          (_parseNum(
                    map['target'] ?? map['targetAmount'] ?? map['goalAmount'],
                  ) ??
                  0)
              .round();
      if (target > 0 && current >= target) {
        completedGoals++;
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
