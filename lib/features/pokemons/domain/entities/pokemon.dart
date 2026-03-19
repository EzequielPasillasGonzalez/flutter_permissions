class Pokemon {
  final int id;
  final String name;
  final List<String> imageUrl;
  final List<String> types;
  final List<String> abilities;
  final int height;
  final int weight;
  final Map<String, int> stats;

  Pokemon({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.types,
    required this.abilities,
    required this.height,
    required this.weight,
    required this.stats,
  });
}
