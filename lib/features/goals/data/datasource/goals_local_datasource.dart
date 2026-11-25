import 'dart:convert';

import 'package:masrofy/core/services/shared_preferences.dart';
import 'package:masrofy/features/goals/data/models/goals_card_model.dart';

abstract class GoalsLocalDataSource {
  Future<List<GoalsCardModel>> getGoals();
  Future<void> saveGoals(List<GoalsCardModel> goals);
}

class GoalsLocalDataSourceImpl implements GoalsLocalDataSource {
  static const String _storageKey = 'masrofy_goals_list';

  @override
  Future<List<GoalsCardModel>> getGoals() async {
    final String? rawJson = SPService.getString(_storageKey);
    if (rawJson == null || rawJson.trim().isEmpty) {
      return [];
    }
    final List<dynamic> decoded = jsonDecode(rawJson) as List<dynamic>;
    return decoded
        .map((item) => GoalsCardModel.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<void> saveGoals(List<GoalsCardModel> goals) async {
    final String encoded = jsonEncode(goals.map((e) => e.toJson()).toList());
    await SPService.setString(_storageKey, encoded);
  }
}
