import 'package:flutter_sqlite/constants/database.dart';
import 'package:flutter_sqlite/core/database/migrations/0001_init.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> initDatabase() async  {
  final databasePath = await getDatabasesPath();
  final path = join(databasePath, DatabaseConstants.databaseName);

  return openDatabase(
    path,
    version: DatabaseConstants.databaseVersion,
    onCreate: (db, version) async {
      // Inicializa o batch de criação das tabelas
      final batch = db.batch();

      // Executa a migração de criação das tabelas
      migration0001Init(batch);

      // Executa o batch
      await batch.commit();
    },
  );
}