import 'package:flutter_bloc/flutter_bloc.dart';

enum GoalStatus { active, completed }

class GoalsStatusCubit extends Cubit<GoalStatus> {
  GoalsStatusCubit() : super(GoalStatus.active);
  void changeGoalStatus(GoalStatus status) => emit(status);
}
