import '../entities/reports_entity.dart';
import '../repo/reports_repository.dart';

class GetReportsUseCase {
  final ReportsRepository repository;

  const GetReportsUseCase(this.repository);

  Future<ReportsEntity> call({required String filterKey}) {
    return repository.getReports(filterKey: filterKey);
  }
}
