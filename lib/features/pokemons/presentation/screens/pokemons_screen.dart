import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reforzamiento/features/pokemons/pokemons.dart';
import 'package:reforzamiento/features/widgets/full_screen_loader.dart';

class PokemonsScreen extends StatelessWidget {
  const PokemonsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _PokemonView());
  }
}

class _PokemonView extends StatefulWidget {
  const _PokemonView({super.key});

  @override
  State<_PokemonView> createState() => _PokemonViewState();
}

class _PokemonViewState extends State<_PokemonView> {
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    context.read<PokemonsBloc>().loadNextPage();
    scrollController.addListener(() {});
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final pokemonState = context.read<PokemonsBloc>().state;

    return pokemonState.isLoading
        ? Scaffold(body: FullScreenLoader())
        : CustomScrollView(
            // controller: scrollController,
            slivers: [
              SliverAppBar(
                title: const Text('Pokemons'),
                floating: true,
                backgroundColor: Colors.white.withValues(alpha: 0.8),
              ),
              _PokemonGrid(pokemons: pokemonState.simplePokemons),
            ],
          );
  }
}

class _PokemonGrid extends StatelessWidget {
  final List<SimplePokemon> pokemons;
  const _PokemonGrid({required this.pokemons});

  @override
  Widget build(BuildContext context) {
    return SliverGrid.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 3,
        mainAxisSpacing: 2,
      ),
      itemCount: pokemons.length,

      itemBuilder: (context, index) {
        final pokemon = pokemons[index];
        return GestureDetector(
          //TODO:  onTap: ,
          child: Image.network(pokemon.imageUrl, fit: BoxFit.contain),
        );
      },
    );
  }
}
