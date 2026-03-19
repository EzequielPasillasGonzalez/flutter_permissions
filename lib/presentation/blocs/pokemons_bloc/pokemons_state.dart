part of 'pokemons_bloc.dart';

class PokemonsState extends Equatable {
  final int offset;
  final List
  const PokemonsState({required this.offset});

  @override
  List<Object?> get props => [offset];
  PokemonsState copyWith({int? offset}) =>
      PokemonsState(offset: offset ?? this.offset);
}
