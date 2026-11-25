import 'package:masrofy/features/main/tabs/home_tab/data/datasources/home_local_datasource.dart';
import 'package:masrofy/features/main/tabs/home_tab/domain/entities/home_summary_entity.dart';
import 'package:masrofy/features/main/tabs/home_tab/domain/repositories/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeLocalDataSource localDataSource;
  const HomeRepositoryImpl(this.localDataSource);

  @override
  Future<HomeSummaryEntity> getHomeSummary() =>
      localDataSource.getHomeSummary();
}
