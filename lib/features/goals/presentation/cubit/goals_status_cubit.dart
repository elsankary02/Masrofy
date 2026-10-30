import 'package:flutter_bloc/flutter_bloc.dart';

enum GoalsStatus { active, completed }

class GoalsStatusCubit extends Cubit<GoalsStatus> {
  GoalsStatusCubit() : super(GoalsStatus.active);
  void changeGoalStatus(GoalsStatus goalsStatus) => emit(goalsStatus);
}
