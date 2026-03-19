import 'package:reforzamiento/features/pokemons/domain/domain.dart';

class PokemonsMapper {
  static Pokemons jsonToEntity(Map<String, dynamic> json) =>
      Pokemons(count: count, next: next, previous: previous, results: results);
}
