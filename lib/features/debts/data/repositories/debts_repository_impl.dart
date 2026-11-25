import 'package:masrofy/features/debts/data/datasources/debts_local_datasource.dart';
import 'package:masrofy/features/debts/data/models/debts_model.dart';
import 'package:masrofy/features/debts/domain/repositories/debts_repository.dart';

class DebtsRepositoryImpl implements DebtsRepository {
  final DebtsLocalDataSource _localDataSource;

  DebtsRepositoryImpl(this._localDataSource);

  @override
  List<DebtsModel> getDebts() => _localDataSource.getDebts();

  @override
  Future<List<DebtsModel>> addDebt(DebtsModel debt) async {
    final currentList = List<DebtsModel>.from(_localDataSource.getDebts());
    final newDebt = debt.id.isEmpty
        ? debt.copyWith(id: DateTime.now().millisecondsSinceEpoch.toString())
        : debt;
    currentList.add(newDebt);
    await _localDataSource.saveDebts(currentList);
    return currentList;
  }

  @override
  Future<List<DebtsModel>> updateDebt(DebtsModel debt) async {
    final currentList = List<DebtsModel>.from(_localDataSource.getDebts());
    final index = currentList.indexWhere((item) => item.id == debt.id);
    if (index != -1) {
      currentList[index] = debt;
      await _localDataSource.saveDebts(currentList);
    }
    return currentList;
  }

  @override
  Future<List<DebtsModel>> deleteDebt(String id) async {
    final currentList = _localDataSource
        .getDebts()
        .where((item) => item.id != id)
        .toList();
    await _localDataSource.saveDebts(currentList);
    return currentList;
  }
}
