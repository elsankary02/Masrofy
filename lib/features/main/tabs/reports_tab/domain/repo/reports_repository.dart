import '../entities/reports_entity.dart';

abstract class ReportsRepository {
  Future<ReportsEntity> getReports({required String filterKey});
}
