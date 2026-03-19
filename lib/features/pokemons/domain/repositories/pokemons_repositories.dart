import 'package:reforzamiento/features/pokemons/domain/domain.dart';

abstract class PokemonsRepositories {
  Future<List<Pokemons>> getPokemonsByPage({int limit = 10, offset = 0});
  Future<Pokemon> getPokemonById(int id);
}
