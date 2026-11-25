import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/get_reports_usecase.dart';
import 'reports_state.dart';

class ReportsCubit extends Cubit<ReportsState> {
  final GetReportsUseCase getReportsUseCase;
  String currentFilter = 'this_month';

  ReportsCubit(this.getReportsUseCase) : super(ReportsInitial());

  Future<void> loadReports({String? filterKey}) async {
    if (filterKey != null) {
      currentFilter = filterKey;
    }
    emit(ReportsLoading());
    try {
      final result = await getReportsUseCase(filterKey: currentFilter);
      emit(ReportsLoaded(result));
    } catch (e) {
      emit(ReportsError(e.toString()));
    }
  }
}
