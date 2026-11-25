import 'package:masrofy/features/goals/data/models/goals_card_model.dart';

enum GoalsStatus { active, completed }

class GoalsState {
  final List<GoalsCardModel> goals;
  final GoalsStatus status;
  final bool isLoading;

  const GoalsState({
    this.goals = const [],
    this.status = GoalsStatus.active,
    this.isLoading = false,
  });

  GoalsState copyWith({
    List<GoalsCardModel>? goals,
    GoalsStatus? status,
    bool? isLoading,
  }) {
    return GoalsState(
      goals: goals ?? this.goals,
      status: status ?? this.status,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
