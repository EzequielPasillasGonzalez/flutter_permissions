import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:reforzamiento/features/pokemons/domain/domain.dart';
import 'package:reforzamiento/features/pokemons/infrastructure/infrastructure.dart';

part 'pokemons_event.dart';
part 'pokemons_state.dart';

class PokemonsBloc extends Bloc<PokemonsEvent, PokemonsState> {
  final pokemonRepositorieImp = PokemonRepositorieImp(
    datasource: PokemonsDatasourceImpl(),
  );

  PokemonsBloc() : super(PokemonsState()) {
    on<PokemonsLoadNextPage>(_onLoadNextPage);
  }

  void loadNextPage() => add(PokemonsLoadNextPage());

  void _onLoadNextPage(
    PokemonsLoadNextPage event,
    Emitter<PokemonsState> emit,
  ) async {
    if (state.isLoading || state.isLastPage) return;

    emit(state.copyWith(isLoading: true, errorMessage: ''));

    try {
      final pokemons = await pokemonRepositorieImp.getPokemonsByPage(
        limit: state.limit,
        offset: state.offset,
      );

      if (pokemons.isEmpty) {
        emit(state.copyWith(isLoading: false, isLastPage: true));
        return;
      }

      emit(
        state.copyWith(
          isLastPage: false,
          isLoading: false,
          offset: state.offset + state.limit,
          simplePokemons: [...state.simplePokemons, ...pokemons],
        ),
      );
    } catch (e) {
      emit(state.copyWith(errorMessage: 'Error al cargar más productos $e'));
    } finally {
      emit(_limpiarLoading());
    }
  }

  PokemonsState _limpiarLoading() {
    return state.copyWith(isLoading: false);
  }
}
