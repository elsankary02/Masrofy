import 'dart:convert';

import '../../../../core/services/shared_preferences.dart';
import '../models/expense_model.dart';

abstract class ExpenseLocalDataSource {
  Future<List<ExpenseModel>> getExpenses();
  Future<void> saveExpenses(List<ExpenseModel> expenses);
}

class ExpenseLocalDataSourceImpl implements ExpenseLocalDataSource {
  static const String _storageKey = 'masrofy_expenses_list';

  @override
  Future<List<ExpenseModel>> getExpenses() async {
    final String? rawJson = SPService.getString(_storageKey);
    if (rawJson == null || rawJson.trim().isEmpty) {
      return [];
    }
    final List<dynamic> decoded = jsonDecode(rawJson) as List<dynamic>;
    return decoded
        .map((item) => ExpenseModel.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<void> saveExpenses(List<ExpenseModel> expenses) async {
    final String encoded = jsonEncode(expenses.map((e) => e.toJson()).toList());
    await SPService.setString(_storageKey, encoded);
  }
}
