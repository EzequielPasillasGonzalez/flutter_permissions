import 'package:reforzamiento/features/pokemons/pokemons.dart';

class PokemonMapper {
  static Pokemon pokeapiPokemonResponseToEntity(
    PokeapiPokemonResponse response,
  ) => Pokemon(
    id: response.id,
    name: response.name,
    imageUrl: _convertImages(response.sprites),
    types: _convertTypes(response.types),
    abilities: _convertAbilities(response.abilities),
    height: response.height,
    weight: response.weight,
    stats: _convertStats(response.stats),
  );

  static List<String> _convertImages(Sprites sprites) {
    return [
      sprites.other?.officialArtwork.frontDefault,
      sprites.other?.officialArtwork.frontShiny,
      sprites.frontDefault,
      sprites.backDefault,
      sprites.frontShiny,
      sprites.backShiny,
    ].whereType<String>().toList();
  }

  static List<String> _convertTypes(List<Type> types) {
    return types.map((t) => t.type.name).toList();
  }

  static List<String> _convertAbilities(List<Ability> abilities) {
    return abilities
        .map((a) => a.ability?.name ?? '')
        .where((name) => name.isNotEmpty)
        .toList();
  }

  static Map<String, int> _convertStats(List<Stat> stats) {
    return {for (var statItem in stats) statItem.stat.name: statItem.baseStat};
  }
}
