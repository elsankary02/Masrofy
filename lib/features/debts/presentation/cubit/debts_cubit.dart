import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/debt_entity.dart';
import '../../domain/usecases/get_debts_usecase.dart';
import 'debts_state.dart';

class DebtsCubit extends Cubit<DebtsState> {
  final GetDebtsUseCase getDebtsUseCase;
  final AddDebtUseCase addDebtUseCase;
  final UpdateDebtUseCase updateDebtUseCase;
  final DeleteDebtUseCase deleteDebtUseCase;

  DebtsCubit({
    required this.getDebtsUseCase,
    required this.addDebtUseCase,
    required this.updateDebtUseCase,
    required this.deleteDebtUseCase,
  }) : super(const DebtsState());

  Future<void> loadDebts() async {
    emit(state.copyWith(isLoading: true));
    final items = await getDebtsUseCase();
    emit(state.copyWith(debts: items, isLoading: false));
  }

  void changeStatus(DebtsStatus status) {
    emit(state.copyWith(status: status));
  }

  Future<void> addDebt(DebtEntity debt) async {
    await addDebtUseCase(debt);
    await loadDebts();
  }

  Future<void> updateDebt(DebtEntity debt) async {
    await updateDebtUseCase(debt);
    await loadDebts();
  }

  Future<void> deleteDebt(String id) async {
    await deleteDebtUseCase(id);
    await loadDebts();
  }
}
