import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masrofy/features/debts/data/models/debts_model.dart';
import 'package:masrofy/features/debts/domain/repositories/debts_repository.dart';

import 'debts_state.dart';

class DebtsCubit extends Cubit<DebtsState> {
  final DebtsRepository _repository;

  DebtsCubit(this._repository) : super(const DebtsState());

  void loadDebts() {
    final debts = _repository.getDebts();
    emit(state.copyWith(debts: debts));
  }

  void debtsStatusFunc(DebtsStatus debtsStatus) {
    emit(state.copyWith(status: debtsStatus));
  }

  Future<void> addDebt(DebtsModel debt) async {
    final updated = await _repository.addDebt(debt);
    emit(state.copyWith(debts: updated));
  }

  Future<void> updateDebt(DebtsModel debt) async {
    final updated = await _repository.updateDebt(debt);
    emit(state.copyWith(debts: updated));
  }

  Future<void> deleteDebt(String id) async {
    final updated = await _repository.deleteDebt(id);
    emit(state.copyWith(debts: updated));
  }
}
