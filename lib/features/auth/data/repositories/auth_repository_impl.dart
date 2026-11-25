import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_local_datasource.dart';
import '../user_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthLocalDataSource _localDataSource;

  AuthRepositoryImpl(this._localDataSource);

  @override
  bool isLoggedIn() => _localDataSource.isLoggedIn();

  @override
  UserModel? getSavedUser() => _localDataSource.getSavedUser();

  @override
  Future<UserModel> loginLocal({
    String name = 'مستخدم مصروفي',
    String email = '',
    String photoPath = '',
  }) {
    final user = UserModel(
      id: 'local_user',
      name: name.trim().isEmpty ? 'مستخدم مصروفي' : name.trim(),
      email: email.trim(),
      photoPath: photoPath,
    );
    return _localDataSource.saveLocalUser(user);
  }

  @override
  Future<void> logout() => _localDataSource.clearSession();
}
