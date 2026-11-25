import 'dart:convert';

import 'package:masrofy/core/services/shared_preferences.dart';
import 'package:masrofy/features/income/data/models/income_model.dart';

abstract class IncomeLocalDataSource {
  Future<List<IncomeModel>> getIncomes();
  Future<void> saveIncomes(List<IncomeModel> incomes);
}

class IncomeLocalDataSourceImpl implements IncomeLocalDataSource {
  static const String _storageKey = 'masrofy_incomes_list';

  @override
  Future<List<IncomeModel>> getIncomes() async {
    final String? rawJson = SPService.getString(_storageKey);
    if (rawJson == null || rawJson.trim().isEmpty) {
      return [];
    }
    final List<dynamic> decoded = jsonDecode(rawJson) as List<dynamic>;
    return decoded
        .map((item) => IncomeModel.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<void> saveIncomes(List<IncomeModel> incomes) async {
    final String encoded = jsonEncode(incomes.map((e) => e.toJson()).toList());
    await SPService.setString(_storageKey, encoded);
  }
}
