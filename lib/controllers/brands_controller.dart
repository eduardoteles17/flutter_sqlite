import 'package:flutter_sqlite/controllers/auth_controller.dart';
import 'package:flutter_sqlite/core/injector.dart';
import 'package:flutter_sqlite/models/brand_model.dart';
import 'package:sqflite/sqflite.dart';

class BrandsController {
  final AuthController _authController = getIt.get<AuthController>();
  final Database _db = getIt.get<Database>();

  Future<Brand?> findBrandById(int id) async {
    final List<Map<String, dynamic>> result = await _db.query(
      'marcas',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (result.isEmpty) {
      return null;
    }

    return Brand.fromMap(result.first);
  }

  Future<List<Brand>> findAllBrands() async {
    final userId = _authController.user.id;

    final List<Map<String, dynamic>> result = await _db.query(
      'marcas',
      where: 'user_id = ?',
      whereArgs: [userId],
    );

    return result.map((e) => Brand.fromMap(e)).toList();
  }

  Future<Brand> createBrand({
    required String name,
  }) async {
    final userId = _authController.user.id;

    final brandId = await _db.insert('marcas', {
      'user_id': userId,
      'name': name,
    });

    final brand = await findBrandById(brandId);

    if (brand == null) {
      throw Exception('Brand not found');
    }

    return brand;
  }

  Future<void> updateBrand({
    required int id,
    required String name,
  }) async {
    final userId = _authController.user.id;

    final result = await _db.update(
      'marcas',
      {
        'name': name,
      },
      where: 'id = ? AND user_id = ?',
      whereArgs: [id, userId],
    );

    if (result == 0) {
      throw Exception('Brand not found');
    }
  }

  Future<void> deleteBrand(int id) async {
    final userId = _authController.user.id;

    final result = await _db.delete(
      'marcas',
      where: 'id = ? AND user_id = ?',
      whereArgs: [id, userId],
    );

    if (result == 0) {
      throw Exception('Brand not found');
    }
  }
}
