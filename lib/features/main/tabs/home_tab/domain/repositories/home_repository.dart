import '../entities/home_summary_entity.dart';

abstract class HomeRepository {
  Future<HomeSummaryEntity> getHomeSummary();
}
