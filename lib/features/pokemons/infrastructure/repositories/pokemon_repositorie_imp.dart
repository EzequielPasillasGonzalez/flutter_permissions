import 'package:reforzamiento/features/pokemons/domain/domain.dart';

class PokemonRepositorieImp extends PokemonsRepositories {
  PokemonRepositorieImp({required this.datasource});

  final PokemonsDatasource datasource;

  @override
  Future<Pokemon> getPokemonById(int id) {
    return datasource.getPokemonById(id);
  }

  @override
  Future<List<SimplePokemon>> getPokemonsByPage({int limit = 20, offset = 0}) {
    return datasource.getPokemonsByPage(limit: limit, offset: offset);
  }
}
