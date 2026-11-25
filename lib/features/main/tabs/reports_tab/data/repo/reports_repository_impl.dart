import '../../domain/entities/reports_entity.dart';
import '../../domain/repo/reports_repository.dart';
import '../datasources/reports_local_datasource.dart';

class ReportsRepositoryImpl implements ReportsRepository {
  final ReportsLocalDataSource localDataSource;

  const ReportsRepositoryImpl(this.localDataSource);

  @override
  Future<ReportsEntity> getReports({required String filterKey}) {
    return localDataSource.getReports(filterKey: filterKey);
  }
}
