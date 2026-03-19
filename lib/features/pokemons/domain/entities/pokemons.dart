class Pokemons {
  int count;
  String next;
  dynamic previous;
  List<Result> results;

  Pokemons({
    required this.count,
    required this.next,
    required this.previous,
    required this.results,
  });
}

class Result {
  String name;
  String url;

  Result({required this.name, required this.url});
}
