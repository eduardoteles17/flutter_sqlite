import 'package:flutter_sqlite/constants/shared_preferences_keys.dart';
import 'package:flutter_sqlite/controllers/users_controller.dart';
import 'package:flutter_sqlite/core/injector.dart';
import 'package:flutter_sqlite/models/user_model.dart';
import 'package:flutter_sqlite/utils/password_hash.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController {
  SharedPreferences sharedPreferences = getIt.get();
  UserController userController = getIt.get();

  User _user = User(id: 0, name: '', email: '', passwordHash: '');

  User get user => _user;

  Future<bool> init() async {
    final userId = sharedPreferences.getInt(
      SharedPreferencesKeys.authenticatedUser,
    );

    if (userId == null) {
      return false;
    }

    final user = await userController.findUserById(userId);

    if (user == null) {
      return false;
    }

    _user = user;

    return true;
  }

  Future<User> login({
    required String email,
    required String password,
  }) async {
    final user = await userController.findUserByEmail(email);

    if (user == null) {
      throw Exception('User not found');
    }

    if (!PasswordHash.compare(password, user.passwordHash)) {
      throw Exception('Invalid password');
    }

    await sharedPreferences.setInt(
      SharedPreferencesKeys.authenticatedUser,
      user.id,
    );

    _user = user;

    return user;
  }

  Future<void> logout() async {
    await sharedPreferences.remove(SharedPreferencesKeys.authenticatedUser);
    _user = User(id: 0, name: '', email: '', passwordHash: '');
  }
}
