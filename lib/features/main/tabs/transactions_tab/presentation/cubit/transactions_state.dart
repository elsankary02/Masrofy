import '../../domain/entities/transaction_entity.dart';

class TransactionsState {
  final List<TransactionEntity> allTransactions;
  final TransactionDateFilter filter;
  final bool isLoading;

  const TransactionsState({
    this.allTransactions = const [],
    this.filter = TransactionDateFilter.all,
    this.isLoading = false,
  });

  List<TransactionEntity> get filteredTransactions {
    final now = DateTime.now();
    switch (filter) {
      case TransactionDateFilter.all:
        return allTransactions;
      case TransactionDateFilter.today:
        return allTransactions
            .where(
              (item) =>
                  item.date.year == now.year &&
                  item.date.month == now.month &&
                  item.date.day == now.day,
            )
            .toList();
      case TransactionDateFilter.week:
        final weekAgo = now.subtract(const Duration(days: 7));
        return allTransactions
            .where((item) => item.date.isAfter(weekAgo))
            .toList();
      case TransactionDateFilter.month:
        return allTransactions
            .where(
              (item) =>
                  item.date.year == now.year && item.date.month == now.month,
            )
            .toList();
    }
  }

  num get totalExpenses => filteredTransactions
      .where((item) => item.isExpense)
      .fold<num>(0, (sum, item) => sum + item.amount);

  TransactionsState copyWith({
    List<TransactionEntity>? allTransactions,
    TransactionDateFilter? filter,
    bool? isLoading,
  }) {
    return TransactionsState(
      allTransactions: allTransactions ?? this.allTransactions,
      filter: filter ?? this.filter,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
