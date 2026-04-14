import 'package:reforzamiento/features/pokemons/domain/entities/simple_pokemon.dart';

abstract class PokemonsLocalDbDatasource {
  Future<List<SimplePokemon>> loadPokemons({int limit = 20, int offset = 0});
  Future<int> pokemonCount();
  Future<void> insertPokemon(SimplePokemon pokemon);
}
