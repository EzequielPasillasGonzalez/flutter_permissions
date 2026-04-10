import 'package:isar/isar.dart';

part 'pokemon.g.dart';

@collection
class Pokemon {
  Id isarId = Isar.autoIncrement;
  final int id;
  final String name;
  final List<String> imageUrl;
  final List<String> types;
  final List<String> abilities;
  final int height;
  final int weight;

  @ignore // Isar ignora este campo al generar el esquema
  final Map<String, int>? stats;

  Pokemon({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.types,
    required this.abilities,
    required this.height,
    required this.weight,
    this.stats = const {},
  });
}
