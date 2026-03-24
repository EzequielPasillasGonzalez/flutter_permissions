part of 'pokemons_bloc.dart';

sealed class PokemonsEvent extends Equatable {
  const PokemonsEvent();

  @override
  List<Object> get props => [];
}

final class PokemonsLoadNextPage extends PokemonsEvent {}
