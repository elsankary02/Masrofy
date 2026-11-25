import 'package:masrofy/features/income/domain/entities/income_entity.dart';

enum IncomeFilter { all, thisMonth, lastMonth, thisYear }

class IncomeState {
  final List<IncomeEntity> incomes;
  final IncomeFilter filter;
  final bool isLoading;

  const IncomeState({
    this.incomes = const [],
    this.filter = IncomeFilter.all,
    this.isLoading = false,
  });

  int get totalAmount =>
      incomes.fold<int>(0, (sum, item) => sum + item.amount);

  IncomeState copyWith({
    List<IncomeEntity>? incomes,
    IncomeFilter? filter,
    bool? isLoading,
  }) {
    return IncomeState(
      incomes: incomes ?? this.incomes,
      filter: filter ?? this.filter,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
