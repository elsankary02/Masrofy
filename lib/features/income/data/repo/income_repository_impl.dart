import 'package:masrofy/features/income/data/datasource/income_local_datasource.dart';
import 'package:masrofy/features/income/data/models/income_model.dart';
import 'package:masrofy/features/income/domain/entities/income_entity.dart';
import 'package:masrofy/features/income/domain/repositories/income_repository.dart';

class IncomeRepositoryImpl implements IncomeRepository {
  final IncomeLocalDataSource localDataSource;

  const IncomeRepositoryImpl(this.localDataSource);

  @override
  Future<List<IncomeEntity>> getIncomes() => localDataSource.getIncomes();

  @override
  Future<void> addIncome(IncomeEntity income) async {
    final currentList = await localDataSource.getIncomes();
    final newItem = IncomeModel.fromEntity(
      income.copyWith(id: DateTime.now().microsecondsSinceEpoch.toString()),
    );
    await localDataSource.saveIncomes([...currentList, newItem]);
  }

  @override
  Future<void> updateIncome(IncomeEntity income) async {
    final currentList = await localDataSource.getIncomes();
    final updatedItem = IncomeModel.fromEntity(income);
    final updatedList = currentList
        .map((item) => item.id == updatedItem.id ? updatedItem : item)
        .toList();
    await localDataSource.saveIncomes(updatedList);
  }

  @override
  Future<void> deleteIncome(String id) async {
    final currentList = await localDataSource.getIncomes();
    final filtered = currentList.where((item) => item.id != id).toList();
    await localDataSource.saveIncomes(filtered);
  }
}
