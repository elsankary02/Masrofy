import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masrofy/features/income/domain/entities/income_entity.dart';
import 'package:masrofy/features/income/domain/usecases/get_incomes_usecase.dart';
import 'package:masrofy/features/income/presentation/cubit/income_state.dart';

class IncomeCubit extends Cubit<IncomeState> {
  final GetIncomesUseCase getIncomesUseCase;
  final AddIncomeUseCase addIncomeUseCase;
  final UpdateIncomeUseCase updateIncomeUseCase;
  final DeleteIncomeUseCase deleteIncomeUseCase;

  IncomeCubit({
    required this.getIncomesUseCase,
    required this.addIncomeUseCase,
    required this.updateIncomeUseCase,
    required this.deleteIncomeUseCase,
  }) : super(const IncomeState());

  Future<void> loadIncomes() async {
    emit(state.copyWith(isLoading: true));
    final items = await getIncomesUseCase();
    emit(state.copyWith(incomes: items, isLoading: false));
  }

  void changeFilter(IncomeFilter filter) {
    emit(state.copyWith(filter: filter));
  }

  Future<void> addIncome(IncomeEntity income) async {
    await addIncomeUseCase(income);
    await loadIncomes();
  }

  Future<void> updateIncome(IncomeEntity income) async {
    await updateIncomeUseCase(income);
    await loadIncomes();
  }

  Future<void> deleteIncome(String id) async {
    await deleteIncomeUseCase(id);
    await loadIncomes();
  }
}
