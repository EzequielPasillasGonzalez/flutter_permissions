import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:reforzamiento/features/pokemons/pokemons.dart';
part 'pokemons_db_state.dart';

class PokemonsDbCubit extends Cubit<PokemonsDbState> {
  final PokemonsLocalDbRepository repository;

  PokemonsDbCubit({PokemonsLocalDbRepository? repository})
    : repository = repository ?? PokemonSqfliteLocalDbRespositorieImpl(),
      super(PokemonsDbState());
  Future<void> loadNextPage() async {
    if (state.status == PokemonsStatus.loading) return;

    emit(state.copyWith(status: PokemonsStatus.loading));

    try {
      final newPokemons = await repository.loadPokemons(
        limit: 20,
        offset: state.pokemons.length,
      );

      emit(
        state.copyWith(
          status: PokemonsStatus.success,
          pokemons: [...state.pokemons, ...newPokemons],
          offset: state.pokemons.length + newPokemons.length,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: PokemonsStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
