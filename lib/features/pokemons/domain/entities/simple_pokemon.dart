import 'package:isar/isar.dart';

part 'simple_pokemon.g.dart';

@collection
class SimplePokemon {
  Id isarId = Isar.autoIncrement;

  final String id;
  final String name;
  final String imageUrl;

  SimplePokemon({required this.id, required this.name, required this.imageUrl});
}
