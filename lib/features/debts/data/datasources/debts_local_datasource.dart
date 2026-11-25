import 'dart:convert';

import '../../../../core/services/shared_preferences.dart';
import '../models/debts_model.dart';

abstract class DebtsLocalDataSource {
  Future<List<DebtsModel>> getDebts();
  Future<void> saveDebts(List<DebtsModel> debts);
}

class DebtsLocalDataSourceImpl implements DebtsLocalDataSource {
  static const String _storageKey = 'masrofy_debts_list';

  @override
  Future<List<DebtsModel>> getDebts() async {
    final String? rawJson = SPService.getString(_storageKey);
    if (rawJson == null || rawJson.trim().isEmpty) {
      return [];
    }
    final List<dynamic> decoded = jsonDecode(rawJson) as List<dynamic>;
    return decoded
        .map((item) => DebtsModel.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<void> saveDebts(List<DebtsModel> debts) async {
    final String encoded = jsonEncode(debts.map((e) => e.toJson()).toList());
    await SPService.setString(_storageKey, encoded);
  }
}
