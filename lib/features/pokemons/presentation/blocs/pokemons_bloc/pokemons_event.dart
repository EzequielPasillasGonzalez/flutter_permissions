part of 'pokemons_bloc.dart';

sealed class PokemonsEvent extends Equatable {
  const PokemonsEvent();

  @override
  List<Object> get props => [];
}

final class OnLoadMorePokemons extends PokemonsEvent {
  final int offset;

  const OnLoadMorePokemons({required this.offset});
}
