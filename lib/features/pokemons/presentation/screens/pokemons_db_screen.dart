import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:reforzamiento/config/config.dart';
import 'package:reforzamiento/config/workmanager/cubit/workmanager_cubit.dart';
import 'package:reforzamiento/features/pokemons/pokemons.dart';
import 'package:reforzamiento/features/widgets/widgets.dart';
import 'package:workmanager/workmanager.dart';

class PokemonsDbScreen extends StatefulWidget {
  const PokemonsDbScreen({super.key});

  @override
  State<PokemonsDbScreen> createState() => _PokemonsDbScreenState();
}

class _PokemonsDbScreenState extends State<PokemonsDbScreen> {
  @override
  void initState() {
    super.initState();
    context.read<PokemonsDbCubit>().loadNextPage();
    context.read<WorkmanagerCubit>().checkStatus(fetchBackgroundTaskKey);
  }

  @override
  Widget build(BuildContext context) {
    final pokemonsDbState = context.watch<PokemonsDbCubit>().state;

    return pokemonsDbState.status == PokemonsStatus.loading
        ? FullScreenLoader()
        : Scaffold(
            appBar: AppBar(
              title: const Text('Background Process'),
              actions: [
                IconButton(
                  onPressed: () {
                    Workmanager().registerOneOffTask(
                      fetchBackgroundTaskKey,
                      fetchBackgroundTaskKey,
                      initialDelay: const Duration(seconds: 3),
                      inputData: {'data': 'fetching background pokemon'},
                    );
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
            body: CustomScrollView(
              slivers: [_PokemonGrid(pokemons: pokemonsDbState.pokemons)],
            ),
            floatingActionButton: _FAB(),
          );
  }
}

class _FAB extends StatelessWidget {
  const _FAB();

  @override
  Widget build(BuildContext context) {
    // Usamos BlocBuilder para escuchar solo los cambios de este Cubit
    return BlocBuilder<WorkmanagerCubit, WorkmanagerState>(
      builder: (context, state) {
        // Extraemos el estado de nuestra tarea específica
        final isWorking =
            state.activeProcesses[fetchBackgroundTaskKey] ?? false;

        return FloatingActionButton.extended(
          onPressed: () {
            context.read<WorkmanagerCubit>().toggleProcess(
              fetchBackgroundTaskKey,
            );
          },
          // Color dinámico para feedback visual
          backgroundColor: isWorking
              ? Colors.red.shade400
              : Colors.blue.shade700,

          // Icono que cambia según el estado
          icon: Icon(isWorking ? Icons.stop_circle_outlined : Icons.av_timer),

          // Label dinámico
          label: Text(
            isWorking ? 'Detener proceso' : 'Activar fetch periódico',
          ),
        );
      },
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
        crossAxisSpacing: 2,
        mainAxisSpacing: 2,
      ),
      itemCount: pokemons.length,
      itemBuilder: (context, index) {
        final pokemon = pokemons[index];

        return GestureDetector(
          onTap: () => context.push('/pokemons/${pokemon.id}'),
          child: FadeInImage.assetNetwork(
            placeholder: 'assets/loaders/gorila-loader.gif',
            image: pokemon.imageUrl,
          ),
        );
      },
    );
  }
}
