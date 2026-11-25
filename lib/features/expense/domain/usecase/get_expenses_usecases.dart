import 'package:masrofy/features/expense/domain/entities/expense_entity.dart';
import 'package:masrofy/features/expense/domain/repo/expense_repository.dart';

class GetExpensesUseCase {
  final ExpenseRepository repository;
  const GetExpensesUseCase(this.repository);

  Future<List<ExpenseEntity>> call() => repository.getExpenses();
}

class AddExpenseUseCase {
  final ExpenseRepository repository;
  const AddExpenseUseCase(this.repository);

  Future<void> call(ExpenseEntity expense) => repository.addExpense(expense);
}

class DeleteExpenseUseCase {
  final ExpenseRepository repository;
  const DeleteExpenseUseCase(this.repository);

  Future<void> call(String id) => repository.deleteExpense(id);
}
