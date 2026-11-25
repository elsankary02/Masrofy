import 'package:masrofy/features/debts/data/models/debts_model.dart';

enum DebtsStatus { isActive, paid }

class DebtsState {
  final DebtsStatus status;
  final List<DebtsModel> debts;

  const DebtsState({this.status = DebtsStatus.isActive, this.debts = const []});

  DebtsState copyWith({DebtsStatus? status, List<DebtsModel>? debts}) {
    return DebtsState(
      status: status ?? this.status,
      debts: debts ?? this.debts,
    );
  }
}
