import '../entities/income_entity.dart';
import '../repositories/income_repository.dart';

class GetIncomesUseCase {
  final IncomeRepository repository;
  const GetIncomesUseCase(this.repository);

  Future<List<IncomeEntity>> call() => repository.getIncomes();
}

class AddIncomeUseCase {
  final IncomeRepository repository;
  const AddIncomeUseCase(this.repository);

  Future<void> call(IncomeEntity income) => repository.addIncome(income);
}

class UpdateIncomeUseCase {
  final IncomeRepository repository;
  const UpdateIncomeUseCase(this.repository);

  Future<void> call(IncomeEntity income) => repository.updateIncome(income);
}

class DeleteIncomeUseCase {
  final IncomeRepository repository;
  const DeleteIncomeUseCase(this.repository);

  Future<void> call(String id) => repository.deleteIncome(id);
}
