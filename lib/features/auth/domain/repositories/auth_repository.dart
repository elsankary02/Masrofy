import '../../data/user_model.dart';

abstract class AuthRepository {
  bool isLoggedIn();
  UserModel? getSavedUser();
  Future<UserModel> loginLocal({
    String name = 'مستخدم مصروفي',
    String email = '',
    String photoPath = '',
  });
  Future<void> logout();
}
