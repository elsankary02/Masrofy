import '../datasource/goals_local_datasource.dart';
import '../models/goals_card_model.dart';

abstract class GoalsRepository {
  Future<List<GoalsCardModel>> getGoals();
  Future<void> saveGoals(List<GoalsCardModel> goals);
}

class GoalsRepositoryImpl implements GoalsRepository {
  final GoalsLocalDataSource localDataSource;

  GoalsRepositoryImpl(this.localDataSource);

  @override
  Future<List<GoalsCardModel>> getGoals() => localDataSource.getGoals();

  @override
  Future<void> saveGoals(List<GoalsCardModel> goals) =>
      localDataSource.saveGoals(goals);
}
