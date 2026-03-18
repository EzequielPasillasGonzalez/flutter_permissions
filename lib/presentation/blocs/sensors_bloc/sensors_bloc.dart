import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sensors_plus/sensors_plus.dart';

part 'sensors_event.dart';
part 'sensors_state.dart';

class SensorsBloc extends Bloc<SensorsEvent, SensorsState> {
  // Guardar el estado del sensor gyroscope para poder desconectarlo cuando se requiera
  StreamSubscription<GyroscopeEvent>? _gyroscopeSubscription;

  SensorsBloc() : super(const SensorsInitial()) {
    on<OnUseGyroscope>(_onSensorGyroscope);
    on<_OnGyroscopeEvent>(_onGyroscopeDataReceived);
    on<OnSensorsStop>(_onSensorsStop);
  }

  void gyroscopeStart() => add(OnUseGyroscope());
  void sensorsStop() => add(const OnSensorsStop());

  void _onSensorGyroscope(OnUseGyroscope event, Emitter<SensorsState> emit) {
    //  cancelar cualquier escucha previa
    _gyroscopeSubscription?.cancel();

    // Conectar al sensor, y por cada dato, lanzar un evento interno
    _gyroscopeSubscription = gyroscopeEventStream().listen((gyroEvent) {
      add(_OnGyroscopeEvent(gyroEvent));
    });
  }

  void _onGyroscopeDataReceived(
    _OnGyroscopeEvent event,
    Emitter<SensorsState> emit,
  ) {
    emit(
      SensorsGyroscope(x: event.event.x, y: event.event.y, z: event.event.z),
    );
  }

  void _onSensorsStop(OnSensorsStop event, Emitter<SensorsState> emit) {
    _gyroscopeSubscription?.cancel();
    emit(const SensorsInitial());
  }

  // Si GoRouter destruye el BLoC, apagar el sensor por si acaso
  @override
  Future<void> close() {
    _gyroscopeSubscription?.cancel();
    return super.close();
  }
}
