import '../entities/debt_entity.dart';
import '../repositories/debts_repository.dart';

class GetDebtsUseCase {
  final DebtsRepository repository;
  const GetDebtsUseCase(this.repository);

  Future<List<DebtEntity>> call() => repository.getDebts();
}

class AddDebtUseCase {
  final DebtsRepository repository;
  const AddDebtUseCase(this.repository);

  Future<void> call(DebtEntity debt) => repository.addDebt(debt);
}

class UpdateDebtUseCase {
  final DebtsRepository repository;
  const UpdateDebtUseCase(this.repository);

  Future<void> call(DebtEntity debt) => repository.updateDebt(debt);
}

class DeleteDebtUseCase {
  final DebtsRepository repository;
  const DeleteDebtUseCase(this.repository);

  Future<void> call(String id) => repository.deleteDebt(id);
}
