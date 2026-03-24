part of 'pokemons_bloc.dart';

class PokemonsState extends Equatable {
  final List<SimplePokemon> simplePokemons;
  final Pokemon? selectedPokemon;
  final bool isLoading;
  final String errorMessage;
  final int offset;
  final int limit;
  final bool isLastPage;

  const PokemonsState({
    this.simplePokemons = const [],
    this.selectedPokemon,
    this.isLoading = false,
    this.errorMessage = '',
    this.offset = 0,
    this.limit = 20,
    this.isLastPage = false,
  });

  @override
  List<Object?> get props => [
    simplePokemons,
    selectedPokemon,
    isLoading,
    errorMessage,
    offset,
    limit,
    isLastPage,
  ];

  PokemonsState copyWith({
    List<SimplePokemon>? simplePokemons,
    Pokemon? selectedPokemon,
    bool? isLoading,
    String? errorMessage,
    int? offset,
    int? limit,
    bool? isLastPage,
  }) {
    return PokemonsState(
      simplePokemons: simplePokemons ?? this.simplePokemons,
      selectedPokemon: selectedPokemon ?? this.selectedPokemon,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      offset: offset ?? this.offset,
      limit: limit ?? this.limit,
      isLastPage: isLastPage ?? this.isLastPage,
    );
  }
}
