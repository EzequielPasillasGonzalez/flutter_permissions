import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:flutter/foundation.dart';
import 'package:reforzamiento/features/pokemons/pokemons.dart';

class PokemonSqfliteLocalDbDatasourceImpl extends PokemonsLocalDbDatasource {
  Database? _db;

  // Getter para asegurar que la DB esté abierta antes de usarla
  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _initDB();
    return _db!;
  }

  Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'pokemons_db.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        // SQL puro para crear la tabla
        await db.execute('''
          CREATE TABLE simple_pokemons (
            localId INTEGER PRIMARY KEY AUTOINCREMENT,
            id TEXT,
            name TEXT,
            imageUrl TEXT
          )
        ''');
      },
    );
  }

  @override
  Future<void> insertPokemon(SimplePokemon pokemon) async {
    final db = await database;
    // En sqflite usamos Maps, no objetos directos
    final id = await db.insert(
      'simple_pokemons',
      pokemon.toDBMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    debugPrint('Pokemon insertado con ID local: $id');
  }

  @override
  Future<List<SimplePokemon>> loadPokemons({
    int limit = 20,
    int offset = 0,
  }) async {
    final db = await database;
    // Consulta SQL a través de helper
    final List<Map<String, dynamic>> maps = await db.query(
      'simple_pokemons',
      limit: limit,
      offset: offset,
    );

    return List.generate(maps.length, (i) {
      return SimplePokemon.fromDBMap(maps[i]);
    });
  }

  @override
  Future<int> pokemonCount() async {
    final db = await database;
    // Consulta directa para contar
    final count = Sqflite.firstIntValue(
      await db.rawQuery('SELECT COUNT(*) FROM simple_pokemons'),
    );
    return count ?? 0;
  }
}
