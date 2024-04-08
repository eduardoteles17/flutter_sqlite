import 'package:flutter_sqlite/controllers/auth_controller.dart';
import 'package:flutter_sqlite/controllers/brands_controller.dart';
import 'package:flutter_sqlite/controllers/tenis_controller.dart';
import 'package:flutter_sqlite/controllers/users_controller.dart';
import 'package:flutter_sqlite/core/database/database.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

GetIt getIt = GetIt.I;

void setupApp() {
  getIt.registerSingletonAsync<Database>(() => initDatabase());
  getIt.registerSingletonAsync<SharedPreferences>(
    () => SharedPreferences.getInstance(),
  );

  // Controllers
  getIt.registerLazySingleton<UserController>(() => UserController());
  getIt.registerLazySingleton<AuthController>(() => AuthController());
  getIt.registerLazySingleton<BrandsController>(() => BrandsController());
  getIt.registerLazySingleton<TenisController>(() => TenisController());
}
