import 'package:flutter/widgets.dart';
import 'package:reforzamiento/config/const/enviroment.dart';
import 'package:reforzamiento/features/pokemons/pokemons.dart';
import 'package:workmanager/workmanager.dart';

const String fetchBackgroundTaskKey =
    'com.chekepasillas.flutter_permissions.fetch-background-pokemon';

const String fetchPeriodicBackgroundTaskKey =
    'com.chekepasillas.flutter_permissions.fetch-periodic-background-pokemon';

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    // Asegurar que los bindings de Flutter estén listos en el Isolate
    WidgetsFlutterBinding.ensureInitialized();
    try {
      await Enviroment.initEnviroment();
      switch (task) {
        case fetchBackgroundTaskKey:
          await loadNextPokemon();
          break;

        case fetchPeriodicBackgroundTaskKey:
          debugPrint('fetchPeriodicBackgroundTaskKey');
          break;

        case Workmanager.iOSBackgroundTask:
          debugPrint('Workmanager.iOSBackgroundTask');
          break;
      }
      return true;
    } catch (e) {
      debugPrint("Error detallado en Workmanager: $e");
      return false;
    }

    // debugPrint("Native: Background task: $task");
    // // Your background work here
    // return Future.value(true);
  });
}

Future loadNextPokemon() async {
  final localDbRepository = PokemonSqfliteLocalDbRespositorieImpl();
  final pokemonRepository = PokemonRepositorieImp(
    datasource: PokemonsDatasourceImpl(),
  );
  final lastPokemonId = await localDbRepository.pokemonCount() + 1;

  try {
    final pokemon = await pokemonRepository.getPokemonById(lastPokemonId);

    final pokemonEntity = SimplePokemonMapper.pokemonEntityToSimplePokemon(
      pokemon,
    );

    await localDbRepository.insertPokemon(pokemonEntity);
    debugPrint('Pokemon inserted: ${pokemonEntity.name}');
  } catch (e) {
    debugPrint('$e');
  }
}
