import 'dart:convert';
import 'package:masrofy/core/services/shared_preferences.dart';
import 'package:masrofy/features/debts/data/models/debts_model.dart';

abstract class DebtsLocalDataSource {
  List<DebtsModel> getDebts();
  Future<void> saveDebts(List<DebtsModel> debts);
}

class DebtsLocalDataSourceImpl implements DebtsLocalDataSource {
  static const _debtsKey = 'masrofy_local_debts';
  static const _seededKey = 'masrofy_debts_seeded';

  @override
  List<DebtsModel> getDebts() {
    final hasSeeded = SPService.getBool(_seededKey) ?? false;
    final raw = SPService.getString(_debtsKey);

    if (!hasSeeded && (raw == null || raw.isEmpty)) {
      return List<DebtsModel>.from(initialDebts);
    }

    if (raw == null || raw.isEmpty) return [];

    final List<dynamic> decoded = jsonDecode(raw) as List<dynamic>;
    return decoded
        .map((item) => DebtsModel.fromMap(item as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<void> saveDebts(List<DebtsModel> debts) async {
    await SPService.setBool(_seededKey, true);
    await SPService.setString(
      _debtsKey,
      jsonEncode(debts.map((d) => d.toMap()).toList()),
    );
  }
}
