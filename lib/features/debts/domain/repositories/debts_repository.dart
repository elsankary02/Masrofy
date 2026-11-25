import '../entities/debt_entity.dart';

abstract class DebtsRepository {
  Future<List<DebtEntity>> getDebts();
  Future<void> addDebt(DebtEntity debt);
  Future<void> updateDebt(DebtEntity debt);
  Future<void> deleteDebt(String id);
}
