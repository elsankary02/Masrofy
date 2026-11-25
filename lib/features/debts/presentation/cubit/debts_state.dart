import '../../domain/entities/debt_entity.dart';

enum DebtsStatus { isActive, isPaid }

class DebtsState {
  final List<DebtEntity> debts;
  final DebtsStatus status;
  final bool isLoading;

  const DebtsState({
    this.debts = const [],
    this.status = DebtsStatus.isActive,
    this.isLoading = false,
  });

  num get totalRemaining => debts.fold<num>(
    0,
    (sum, item) => sum + (item.current > 0 ? item.current : 0),
  );

  DebtsState copyWith({
    List<DebtEntity>? debts,
    DebtsStatus? status,
    bool? isLoading,
  }) {
    return DebtsState(
      debts: debts ?? this.debts,
      status: status ?? this.status,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
