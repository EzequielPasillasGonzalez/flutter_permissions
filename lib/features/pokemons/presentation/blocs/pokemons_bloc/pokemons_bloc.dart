import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'pokemons_event.dart';
part 'pokemons_state.dart';

class PokemonsBloc extends Bloc<PokemonsEvent, PokemonsState> {
  PokemonsBloc() : super(const PokemonsState(offset: 30)) {
    on<PokemonsEvent>((event, emit) {});
  }
}
