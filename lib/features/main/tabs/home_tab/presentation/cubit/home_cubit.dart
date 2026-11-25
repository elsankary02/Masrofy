import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masrofy/features/main/tabs/home_tab/domain/usecases/get_home_summary_usecase.dart';
import 'package:masrofy/features/main/tabs/home_tab/presentation/cubit/home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final GetHomeSummaryUseCase getHomeSummaryUseCase;

  HomeCubit(this.getHomeSummaryUseCase) : super(const HomeState());

  Future<void> loadSummary() async {
    emit(state.copyWith(isLoading: true));
    final data = await getHomeSummaryUseCase();
    emit(state.copyWith(summary: data, isLoading: false));
  }

  void toggleBalanceVisibility() {
    emit(state.copyWith(isObscured: !state.isObscured));
  }
}
