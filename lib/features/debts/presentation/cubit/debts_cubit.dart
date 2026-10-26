import 'package:flutter_bloc/flutter_bloc.dart';

enum DebtsStatus { isActive, paid }

class DebtsCubit extends Cubit<DebtsStatus> {
  DebtsCubit() : super(DebtsStatus.isActive);
  void debtsStatusFunc(DebtsStatus debtsStatus) => emit(debtsStatus);
}
