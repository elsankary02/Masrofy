import 'package:masrofy/features/main/tabs/home_tab/domain/entities/home_summary_entity.dart';
import 'package:masrofy/features/main/tabs/home_tab/domain/repositories/home_repository.dart';

class GetHomeSummaryUseCase {
  final HomeRepository repository;
  const GetHomeSummaryUseCase(this.repository);

  Future<HomeSummaryEntity> call() => repository.getHomeSummary();
}
