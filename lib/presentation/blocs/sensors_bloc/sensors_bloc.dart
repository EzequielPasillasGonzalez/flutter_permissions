import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sensors_plus/sensors_plus.dart';

part 'sensors_event.dart';
part 'sensors_state.dart';

class SensorsBloc extends Bloc<SensorsEvent, SensorsState> {
  // Guardar el estado del sensor gyroscope para poder desconectarlo cuando se requiera
  StreamSubscription<GyroscopeEvent>? _gyroscopeSubscription;
  StreamSubscription<AccelerometerEvent>? _accelerometerSubscription;

  SensorsBloc() : super(const SensorsInitial()) {
    on<OnUseGyroscope>(_onSensorGyroscope);
    on<_OnGyroscopeEvent>(_onGyroscopeDataReceived);
    on<OnUseAccelerometer>(_onSensorAccelerometer);
    on<_OnAccelerometerEvent>(_onAccelerometerDataReceived);
    on<OnSensorsStop>(_onSensorsStop);
  }

  void gyroscopeStart() => add(OnUseGyroscope());
  void accelerometerStart() => add(OnUseAccelerometer());
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

  void _onSensorAccelerometer(
    OnUseAccelerometer event,
    Emitter<SensorsState> emit,
  ) {
    //  cancelar cualquier escucha previa
    _accelerometerSubscription?.cancel();

    // Conectar al sensor, y por cada dato, lanzar un evento interno
    _accelerometerSubscription = accelerometerEventStream().listen((
      accelerometerEvent,
    ) {
      add(_OnAccelerometerEvent(accelerometerEvent));
    });
  }

  void _onAccelerometerDataReceived(
    _OnAccelerometerEvent event,
    Emitter<SensorsState> emit,
  ) {
    emit(
      SensorsAccelerometer(
        x: event.event.x,
        y: event.event.y,
        z: event.event.z,
      ),
    );
  }

  void _onSensorsStop(OnSensorsStop event, Emitter<SensorsState> emit) {
    _gyroscopeSubscription?.cancel();
    _accelerometerSubscription?.cancel();
    emit(const SensorsInitial());
  }

  // Si GoRouter destruye el BLoC, apagar el sensor por si acaso
  @override
  Future<void> close() {
    _gyroscopeSubscription?.cancel();
    _accelerometerSubscription?.cancel();
    return super.close();
  }
}
