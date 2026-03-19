import 'package:flutter/material.dart';

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
    scrollController.addListener(() {});
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      // controller: scrollController,
      slivers: [
        SliverAppBar(
          title: const Text('Pokemons'),
          floating: true,
          backgroundColor: Colors.white.withValues(alpha: 0.8),
        ),
        const _PokemonGrid(),
      ],
    );
  }
}

class _PokemonGrid extends StatelessWidget {
  const _PokemonGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverGrid.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 3,
        mainAxisSpacing: 2,
      ),
      itemCount: 10,
      itemBuilder: (context, index) {
        return GestureDetector(
          //TODO:  onTap: ,
          child: Image.network(
            'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/${index + 1}.png',
            fit: BoxFit.contain,
          ),
        );
      },
    );
  }
}
