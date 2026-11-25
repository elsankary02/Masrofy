import '../../domain/entities/transaction_entity.dart';
import '../../domain/repositories/transactions_repository.dart';
import '../datasources/transactions_local_datasource.dart';

class TransactionsRepositoryImpl implements TransactionsRepository {
  final TransactionsLocalDataSource localDataSource;

  const TransactionsRepositoryImpl(this.localDataSource);

  @override
  Future<List<TransactionEntity>> getTransactions() =>
      localDataSource.getTransactions();
}
