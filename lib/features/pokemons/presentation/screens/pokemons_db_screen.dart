import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:reforzamiento/features/pokemons/pokemons.dart';

class PokemonsDbScreen extends StatelessWidget {
  const PokemonsDbScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Background Process'),
        actions: [
          IconButton(
            onPressed: () {
              //TODO: CREAR ACCCION
            },
            icon: const Icon(Icons.add_alarm_sharp),
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
      body: CustomScrollView(slivers: [_PokemonGrid(pokemons: [])]),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          //TODO: ACTIVAR O DESACTIVAR TAREA PERIODICA
        },
        label: const Text('Activar fetch periódico'),
        icon: Icon(Icons.av_timer),
      ),
    );
  }
}

class _PokemonGrid extends StatelessWidget {
  final List<Pokemon> pokemons;

  const _PokemonGrid({required this.pokemons});

  @override
  Widget build(BuildContext context) {
    return SliverGrid.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 2,
        mainAxisSpacing: 2,
      ),
      itemCount: pokemons.length,
      itemBuilder: (context, index) {
        final pokemon = pokemons[index];

        return Column(
          children: [
            Image.network(pokemon.imageUrl[0], fit: BoxFit.contain),
            Text('${pokemon.name}'),
          ],
        );
      },
    );
  }
}
