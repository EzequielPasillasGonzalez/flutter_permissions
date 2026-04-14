part of 'pokemons_db_cubit.dart';

enum PokemonsStatus { initial, loading, success, error }

class PokemonsDbState extends Equatable {
  final List<SimplePokemon> pokemons;
  final PokemonsStatus status;
  final String errorMessage;
  final int offset;

  const PokemonsDbState({
    this.pokemons = const [],
    this.status = PokemonsStatus.initial,
    this.errorMessage = '',
    this.offset = 0,
  });

  PokemonsDbState copyWith({
    List<SimplePokemon>? pokemons,
    PokemonsStatus? status,
    String? errorMessage,
    int? offset,
  }) {
    return PokemonsDbState(
      pokemons: pokemons ?? this.pokemons,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      offset: offset ?? this.offset,
    );
  }

  @override
  List<Object> get props => [pokemons, status, errorMessage, offset];
}
