import 'package:reforzamiento/config/const/enviroment.dart';
import 'package:reforzamiento/features/pokemons/domain/domain.dart';

class SimplePokemonMapper {
  static SimplePokemon jsonToEntity(Map<String, dynamic> json) {
    final url = json["url"] as String;
    final parts = url.split('/');
    final id = parts[parts.length - 2];

    return SimplePokemon(
      id: id,
      name: json["name"],
      imageUrl: '${Enviroment.imagePokeMonBaseUrl}/$id.png',
    );
  }
}
