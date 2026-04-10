import 'package:reforzamiento/features/pokemons/domain/entities/simple_pokemon.dart';

abstract class PokemonsLocalDbRepository {
  Future<List<SimplePokemon>> loadPokemons({int limit = 20, offset = 0});
  Future<int> pokemonCount();
  Future<void> insertPokemon(SimplePokemon pokemon);
}
