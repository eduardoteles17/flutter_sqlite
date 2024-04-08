import 'package:flutter_sqlite/core/injector.dart';
import 'package:flutter_sqlite/models/user_model.dart';
import 'package:flutter_sqlite/utils/password_hash.dart';
import 'package:sqflite/sqflite.dart';

class UserController {
  final Database _db = getIt.get();

  Future<User> createUser({
    required String name,
    required String email,
    required String password,
  }) async {
    final exists = await findUserByEmail(email);

    if (exists != null) {
      throw Exception('User already exists');
    }

    final passwordHash = PasswordHash.hash(password);

    final userId = await _db.insert('users', {
      'name': name,
      'email': email,
      'passwordHash': passwordHash,
    });

    final user = await findUserById(userId);

    if (user == null) {
      throw Exception('User not found');
    }

    return user;
  }

  Future<User?> findUserById(int id) async {
    final List<Map<String, dynamic>> result = await _db.query(
      'users',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (result.isEmpty) {
      return null;
    }

    return User.fromMap(result.first);
  }

  Future<User?> findUserByEmail(String email) async {
    final List<Map<String, dynamic>> result = await _db.query(
      'users',
      where: 'email = ?',
      whereArgs: [email],
    );

    if (result.isEmpty) {
      return null;
    }

    return User.fromMap(result.first);
  }

  Future<List<User>> getAllUsers() async {
    final List<Map<String, dynamic>> result = await _db.query('users');

    return result.map((e) => User.fromMap(e)).toList();
  }

  Future<void> deleteUser(int id) async {
    await _db.delete(
      'users',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
