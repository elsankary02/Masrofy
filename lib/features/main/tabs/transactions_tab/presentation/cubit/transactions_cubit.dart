import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/transaction_entity.dart';
import '../../domain/usecases/et_transactions_usecase.dart';
import 'transactions_state.dart';

class TransactionsCubit extends Cubit<TransactionsState> {
  final GetTransactionsUseCase getTransactionsUseCase;

  TransactionsCubit(this.getTransactionsUseCase)
    : super(const TransactionsState());

  Future<void> loadTransactions() async {
    emit(state.copyWith(isLoading: true));
    final items = await getTransactionsUseCase();
    emit(state.copyWith(allTransactions: items, isLoading: false));
  }

  void changeFilter(TransactionDateFilter filter) {
    emit(state.copyWith(filter: filter));
  }
}
