import 'package:sqflite/sqflite.dart';

void migration0001Init(Batch batch) async {
  // Cria a tabela de usuários
  batch.execute('''
    CREATE TABLE users (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT NOT NULL,
      email TEXT NOT NULL,
      passwordHash TEXT NOT NULL
    )
  ''');

  // Cria a tabela de marcas de tenês
  batch.execute('''
    CREATE TABLE marcas (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      user_id INTEGER NOT NULL,
      name TEXT NOT NULL,
      FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE
    )
  ''');

  // Cria a tabela de tenês
  batch.execute('''
    CREATE TABLE tenis (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      user_id INTEGER NOT NULL,
      marca_id INTEGER NOT NULL,
      name TEXT NOT NULL,
      color TEXT NOT NULL,
      FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE,
      FOREIGN KEY (marca_id) REFERENCES marcas (id) ON DELETE CASCADE
    )
  ''');
}
