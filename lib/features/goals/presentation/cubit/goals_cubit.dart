import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masrofy/features/goals/data/models/goals_card_model.dart';
import 'package:masrofy/features/goals/data/repos/goals_repository.dart';
import 'package:masrofy/features/goals/presentation/cubit/goals_status_cubit.dart';

class GoalsCubit extends Cubit<GoalsState> {
  final GoalsRepository repository;

  GoalsCubit(this.repository) : super(const GoalsState());

  Future<void> loadGoals() async {
    emit(state.copyWith(isLoading: true));
    final items = await repository.getGoals();
    emit(state.copyWith(goals: items, isLoading: false));
  }

  void changeGoalStatus(GoalsStatus status) {
    emit(state.copyWith(status: status));
  }

  Future<void> addGoal(GoalsCardModel goal) async {
    final newGoal = goal.copyWith(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
    );
    final updated = [...state.goals, newGoal];
    await repository.saveGoals(updated);
    emit(state.copyWith(goals: updated));
  }

  Future<void> updateGoal(GoalsCardModel updatedGoal) async {
    final updated = state.goals
        .map((item) => item.id == updatedGoal.id ? updatedGoal : item)
        .toList();
    await repository.saveGoals(updated);
    emit(state.copyWith(goals: updated));
  }

  Future<void> deleteGoal(String id) async {
    final updated = state.goals.where((item) => item.id != id).toList();
    await repository.saveGoals(updated);
    emit(state.copyWith(goals: updated));
  }
}
