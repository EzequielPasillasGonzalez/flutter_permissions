import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:reforzamiento/config/plugins/shared_preferences_plugin.dart';
import 'package:workmanager/workmanager.dart';

part 'workmanager_state.dart';

class WorkmanagerCubit extends Cubit<WorkmanagerState> {
  WorkmanagerCubit() : super(WorkmanagerState());
  Future<void> checkStatus(String processName) async {
    final isWorking = await SharedPreferencesPlugin.getBool(processName);

    // Actualizar solo la entrada de ese proceso en el mapa
    final newMap = Map<String, bool>.from(state.activeProcesses);
    newMap[processName] = isWorking;

    emit(state.copyWith(activeProcesses: newMap));
  }

  Future<void> toggleProcess(String processName) async {
    final isCurrentlyWorking = await SharedPreferencesPlugin.getBool(
      processName,
    );

    if (isCurrentlyWorking) {
      debugPrint('deactivate procecess');

      deactivePeriodicTaskStatus(processName);
    } else {
      debugPrint('activate procecess');

      activateProcess(processName);
    }

    // Actualizar el estado después de la acción
    await checkStatus(processName);
  }

  Future<void> activateProcess(String processName) async {
    await Workmanager().registerPeriodicTask(
      processName,
      processName,
      frequency: const Duration(seconds: 10), // Lo cambiara a 15 minutos
      constraints: Constraints(networkType: NetworkType.connected),
      tag: processName,
    );
    debugPrint('proccess activated');

    await SharedPreferencesPlugin.setBool(processName, true);
  }

  Future<void> deactivePeriodicTaskStatus(String processName) async {
    await Workmanager().cancelByTag(processName);
    await SharedPreferencesPlugin.setBool(processName, false);
  }
}
