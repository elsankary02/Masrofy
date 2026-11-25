import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/expense_entity.dart';
import '../../domain/usecase/get_expenses_usecases.dart';
import 'expense_state.dart';

class ExpenseCubit extends Cubit<ExpenseState> {
  final GetExpensesUseCase getExpensesUseCase;
  final AddExpenseUseCase addExpenseUseCase;
  final DeleteExpenseUseCase deleteExpenseUseCase;

  ExpenseCubit({
    required this.getExpensesUseCase,
    required this.addExpenseUseCase,
    required this.deleteExpenseUseCase,
  }) : super(const ExpenseState());

  Future<void> loadExpenses() async {
    emit(state.copyWith(isLoading: true));
    final items = await getExpensesUseCase();
    emit(state.copyWith(expenses: items, isLoading: false));
  }

  Future<void> addExpense(ExpenseEntity expense) async {
    await addExpenseUseCase(expense);
    await loadExpenses();
  }

  Future<void> deleteExpense(String id) async {
    await deleteExpenseUseCase(id);
    await loadExpenses();
  }
}
