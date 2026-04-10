import 'package:flutter/cupertino.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:reforzamiento/features/pokemons/pokemons.dart';

class PokemonIsarLocalDbDatasourceImpl extends PokemonsLocalDbDatasource {
  late Future<Isar> db;

  PokemonIsarLocalDbDatasourceImpl() {
    db = openDB();
  }

  Future<Isar> openDB() async {
    final dir = await getApplicationDocumentsDirectory();

    if (Isar.instanceNames.isEmpty) {
      return await Isar.open([SimplePokemonSchema], directory: dir.path);
    }

    return Future.value(Isar.getInstance());
  }

  @override
  Future<void> insertPokemon(SimplePokemon pokemon) async {
    final isar = await db;
    final done = isar.writeTxnSync(() => isar.simplePokemons.putSync(pokemon));
    debugPrint('insert done: $done');
  }

  @override
  Future<List<SimplePokemon>> loadPokemons({int limit = 20, offset = 0}) async {
    final isar = await db;
    return isar.simplePokemons.where().offset(offset).limit(limit).findAll();
  }

  @override
  Future<int> pokemonCount() async {
    final isar = await db;
    return isar.simplePokemons.count();
  }
}
