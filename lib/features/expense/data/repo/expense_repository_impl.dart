import 'package:masrofy/features/expense/data/datasource/expense_local_datasource.dart';
import 'package:masrofy/features/expense/data/models/expense_model.dart';
import 'package:masrofy/features/expense/domain/entities/expense_entity.dart';
import 'package:masrofy/features/expense/domain/repo/expense_repository.dart';

class ExpenseRepositoryImpl implements ExpenseRepository {
  final ExpenseLocalDataSource localDataSource;

  const ExpenseRepositoryImpl(this.localDataSource);

  @override
  Future<List<ExpenseEntity>> getExpenses() => localDataSource.getExpenses();

  @override
  Future<void> addExpense(ExpenseEntity expense) async {
    final current = await localDataSource.getExpenses();
    final newItem = ExpenseModel.fromEntity(
      expense.copyWith(id: DateTime.now().microsecondsSinceEpoch.toString()),
    );
    await localDataSource.saveExpenses([newItem, ...current]);
  }

  @override
  Future<void> deleteExpense(String id) async {
    final current = await localDataSource.getExpenses();
    final updated = current.where((item) => item.id != id).toList();
    await localDataSource.saveExpenses(updated);
  }
}
