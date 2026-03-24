import 'package:reforzamiento/features/pokemons/pokemons.dart';

abstract class PokemonsDatasource {
  Future<List<SimplePokemon>> getPokemonsByPage({int limit = 20, offset = 0});
  Future<Pokemon> getPokemonById(int id);
}
