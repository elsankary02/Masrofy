import '../entities/transaction_entity.dart';
import '../repositories/transactions_repository.dart';

class GetTransactionsUseCase {
  final TransactionsRepository repository;

  const GetTransactionsUseCase(this.repository);

  Future<List<TransactionEntity>> call() => repository.getTransactions();
}
