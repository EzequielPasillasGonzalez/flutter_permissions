import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:reforzamiento/config/config.dart';
import 'package:reforzamiento/features/pokemons/pokemons.dart';
import 'package:reforzamiento/features/widgets/widgets.dart';

class PokemonScreen extends StatefulWidget {
  final int pokemonId;
  const PokemonScreen({super.key, required this.pokemonId});

  @override
  State<PokemonScreen> createState() => _PokemonScreenState();
}

class _PokemonScreenState extends State<PokemonScreen> {
  @override
  void initState() {
    super.initState();
    context.read<PokemonsBloc>().getPokemonById(widget.pokemonId);
  }

  @override
  Widget build(BuildContext context) {
    final pokemonState = context.watch<PokemonsBloc>().state;
    final pokemon = pokemonState.selectedPokemon;
    final isLoading = pokemonState.isLoading || pokemon == null;

    return isLoading
        ? FullScreenLoader()
        : Scaffold(
            appBar: AppBar(
              title: Text(
                'Pokemon ID ${pokemon.id}',
                style: TextStyle(color: Colors.black),
              ),
              backgroundColor: Colors.white.withValues(alpha: 0.8),
              actions: [
                IconButton(
                  onPressed: () {
                    SharePlugin.shareLink(
                      title: pokemon.name,
                      link: pokemon.imageUrl.first,
                      subject: 'Mira este pokemon',
                    );
                  },
                  icon: const Icon(Icons.share),
                ),
              ],
              leading: IconButton(
                onPressed: () {
                  if (context.canPop()) context.pop();
                },
                icon: const Icon(
                  Icons.arrow_back_rounded,
                  size: 30,
                  color: Colors.black,
                ),
              ),
            ),
            body: Center(child: Image.network(pokemon.imageUrl.first)),
          );
  }
}
