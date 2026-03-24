part of 'pokemons_bloc.dart';

sealed class PokemonsEvent extends Equatable {
  const PokemonsEvent();

  @override
  List<Object> get props => [];
}

final class PokemonsLoadNextPage extends PokemonsEvent {}

final class GetPokemonById extends PokemonsEvent {
  final int id;

  const GetPokemonById({required this.id});

  @override
  List<Object> get props => [id];
}
