import 'package:flutter_sqlite/controllers/auth_controller.dart';
import 'package:flutter_sqlite/controllers/brands_controller.dart';
import 'package:flutter_sqlite/core/injector.dart';
import 'package:flutter_sqlite/models/tenis_model.dart';
import 'package:sqflite/sqflite.dart';

class TenisController {
  final AuthController _authController = getIt.get<AuthController>();
  final BrandsController _brandsController = getIt.get<BrandsController>();
  final Database _database = getIt.get<Database>();

  Future<List<TenisWithBrand>> findAllTenisWithBrand() async {
    final userId = _authController.user.id;

    final List<Map<String, dynamic>> result = await _database.query(
      'tenis',
      where: 'user_id = ?',
      whereArgs: [userId],
    );

    final List<TenisWithBrand> tenisList = [];

    for (final Map<String, dynamic> item in result) {
      final tenis = Tenis.fromMap(item);
      final brand = await _brandsController.findBrandById(tenis.brandId);

      if (brand == null) {
        continue;
      }

      tenisList.add(TenisWithBrand.fromTenis(tenis, brand));
    }

    return tenisList;
  }

  Future<void> createTenis({
    required int brandId,
    required String name,
    required String color,
  }) async {
    final userId = _authController.user.id;

    await _database.insert(
      'tenis',
      {
        'user_id': userId,
        'marca_id': brandId,
        'name': name,
        'color': color,
      },
    );
  }

  Future<void> updateTenis({
    required int id,
    required int brandId,
    required String name,
    required String color,
  }) async {
    final userId = _authController.user.id;

    await _database.update(
      'tenis',
      {
        'marca_id': brandId,
        'name': name,
        'color': color,
      },
      where: 'id = ? AND user_id = ?',
      whereArgs: [id, userId],
    );
  }

  Future<void> deleteTenis(int tenisId) async {
    final userId = _authController.user.id;

    await _database.delete(
      'tenis',
      where: 'id = ? AND user_id = ?',
      whereArgs: [tenisId, userId],
    );
  }
}
