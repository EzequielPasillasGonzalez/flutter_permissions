import 'package:reforzamiento/features/pokemons/pokemons.dart';

class PokemonIsarLocalDbRespositorieImpl extends PokemonsLocalDbRepository {
  PokemonIsarLocalDbRespositorieImpl([PokemonsLocalDbDatasource? datasource])
    : _datasource = datasource ?? PokemonIsarLocalDbDatasourceImpl();

  final PokemonsLocalDbDatasource _datasource;

  @override
  Future<List<SimplePokemon>> loadPokemons({int limit = 20, offset = 0}) {
    return _datasource.loadPokemons(limit: limit, offset: offset);
  }

  @override
  Future<int> pokemonCount() {
    return _datasource.pokemonCount();
  }

  @override
  Future<void> insertPokemon(SimplePokemon pokemon) {
    return _datasource.insertPokemon(pokemon);
  }
}
