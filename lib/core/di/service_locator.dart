import 'package:masrofy/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:masrofy/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:masrofy/features/auth/presentation/cubit/auth_cubit.dart';

class AppDependencies {
  AppDependencies._();

  static late final AuthCubit authCubit;

  static void init() {
    final dataSource = AuthLocalDataSourceImpl();
    final repository = AuthRepositoryImpl(dataSource);
    authCubit = AuthCubit(repository)..checkSession();
  }
}
