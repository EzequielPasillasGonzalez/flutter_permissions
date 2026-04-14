import 'package:reforzamiento/features/pokemons/pokemons.dart';

class PokemonSqfliteLocalDbRespositorieImpl extends PokemonsLocalDbRepository {
  PokemonSqfliteLocalDbRespositorieImpl([PokemonsLocalDbDatasource? datasource])
    : _datasource = datasource ?? PokemonSqfliteLocalDbDatasourceImpl();

  final PokemonsLocalDbDatasource _datasource;

  @override
  Future<List<SimplePokemon>> loadPokemons({int limit = 20, int offset = 0}) {
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
