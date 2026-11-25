import '../../domain/entities/debt_entity.dart';
import '../../domain/repositories/debts_repository.dart';
import '../datasources/debts_local_datasource.dart';
import '../models/debts_model.dart';

class DebtsRepositoryImpl implements DebtsRepository {
  final DebtsLocalDataSource localDataSource;

  const DebtsRepositoryImpl(this.localDataSource);

  @override
  Future<List<DebtEntity>> getDebts() => localDataSource.getDebts();

  @override
  Future<void> addDebt(DebtEntity debt) async {
    final currentList = await localDataSource.getDebts();
    final newItem = DebtsModel.fromEntity(
      debt.copyWith(id: DateTime.now().microsecondsSinceEpoch.toString()),
    );
    await localDataSource.saveDebts([...currentList, newItem]);
  }

  @override
  Future<void> updateDebt(DebtEntity debt) async {
    final currentList = await localDataSource.getDebts();
    final updatedItem = DebtsModel.fromEntity(debt);
    final updatedList = currentList
        .map((item) => item.id == updatedItem.id ? updatedItem : item)
        .toList();
    await localDataSource.saveDebts(updatedList);
  }

  @override
  Future<void> deleteDebt(String id) async {
    final currentList = await localDataSource.getDebts();
    final filtered = currentList.where((item) => item.id != id).toList();
    await localDataSource.saveDebts(filtered);
  }
}
