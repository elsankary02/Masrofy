import '../entities/home_summary_entity.dart';
import '../repositories/home_repository.dart';

class GetHomeSummaryUseCase {
  final HomeRepository repository;
  const GetHomeSummaryUseCase(this.repository);

  Future<HomeSummaryEntity> call() => repository.getHomeSummary();
}
