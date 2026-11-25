import 'package:masrofy/features/main/tabs/home_tab/domain/entities/home_summary_entity.dart';

abstract class HomeRepository {
  Future<HomeSummaryEntity> getHomeSummary();
}
