import 'package:reforzamiento/features/pokemons/domain/domain.dart';

class PokemonMapper {
  static Pokemon jsonToEntity(Map<String, dynamic> json) => Pokemon(
    abilities: json['abilities'],
    baseExperience: json['baseExperience'],
    cries: json['cries'],
    forms: json['forms'],
    gameIndices: json['gameIndices'],
    height: json['height'],
    heldItems: json['heldItems'],
    id: json['id'],
    isDefault: json['isDefault'],
    locationAreaEncounters: json['locationAreaEncounters'],
    moves: json['moves'],
    name: json['name'],
    order: json['order'],
    pastAbilities: json['pastAbilities'],
    pastStats: json['pastStats'],
    pastTypes: json['pastTypes'],
    species: json['species'],
    sprites: json['sprites'],
    stats: json['stats'],
    types: json['types'],
    weight: json['weight'],
  );
}
