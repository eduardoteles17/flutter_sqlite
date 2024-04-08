import 'package:flutter_sqlite/core/database/database.dart';
import 'package:get_it/get_it.dart';
import 'package:sqflite/sqflite.dart';

GetIt getIt = GetIt.I;

void setupApp() {
  getIt.registerSingletonAsync<Database>(() => initDatabase());
}
