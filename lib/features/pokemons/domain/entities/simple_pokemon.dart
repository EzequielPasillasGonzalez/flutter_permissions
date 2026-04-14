class SimplePokemon {
  final int? localId;
  final String id;
  final String name;
  final String imageUrl;

  SimplePokemon({
    required this.id,
    required this.name,
    required this.imageUrl,
    this.localId,
  });

  // Convertir a Map para insertar en la DB
  Map<String, dynamic> toDBMap() {
    return {'localId': localId, 'id': id, 'name': name, 'imageUrl': imageUrl};
  }

  // Crear objeto desde Map de la DB
  factory SimplePokemon.fromDBMap(Map<String, dynamic> map) {
    return SimplePokemon(
      localId: map['localId'],
      id: map['id'],
      name: map['name'],
      imageUrl: map['imageUrl'],
    );
  }
}
