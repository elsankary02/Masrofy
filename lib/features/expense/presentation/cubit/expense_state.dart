import 'package:masrofy/features/expense/domain/entities/expense_entity.dart';

class ExpenseState {
  final List<ExpenseEntity> expenses;
  final bool isLoading;

  const ExpenseState({
    this.expenses = const [],
    this.isLoading = false,
  });

  double get totalAmount =>
      expenses.fold<double>(0, (sum, item) => sum + item.amount);

  ExpenseState copyWith({
    List<ExpenseEntity>? expenses,
    bool? isLoading,
  }) {
    return ExpenseState(
      expenses: expenses ?? this.expenses,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
