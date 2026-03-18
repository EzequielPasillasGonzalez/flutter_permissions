import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:sensors_plus/sensors_plus.dart';

part 'sensors_event.dart';
part 'sensors_state.dart';

class SensorsBloc extends Bloc<SensorsEvent, SensorsState> {
  // Guardar el estado del sensor gyroscope para poder desconectarlo cuando se requiera
  StreamSubscription<GyroscopeEvent>? _gyroscopeSubscription;
  StreamSubscription<AccelerometerEvent>? _accelerometerSubscription;
  StreamSubscription<MagnetometerEvent>? _magnetometerSubscription;
  StreamSubscription<CompassEvent>? _compassSubscription;

  SensorsBloc() : super(const SensorsInitial()) {
    on<OnUseGyroscope>(_onSensorGyroscope);
    on<_OnGyroscopeEvent>(_onGyroscopeDataReceived);

    on<OnUseAccelerometer>(_onSensorAccelerometer);
    on<_OnAccelerometerEvent>(_onAccelerometerDataReceived);

    on<OnUseMagnetometer>(_onSensorMagnetometer);
    on<_OnMagnetometerEvent>(_onMagnetometerDataReceived);

    on<OnUseCompass>(_onSensorCompass);
    on<_OnCompassEvent>(_onCompassDataReceived);

    on<OnSensorsStop>(_onSensorsStop);
  }

  void gyroscopeStart() => add(OnUseGyroscope());
  void accelerometerStart() => add(OnUseAccelerometer());
  void magnetometerStart() => add(OnUseMagnetometer());

  void compassStart() => add(OnUseCompass());
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

  void _onSensorMagnetometer(
    OnUseMagnetometer event,
    Emitter<SensorsState> emit,
  ) {
    //  cancelar cualquier escucha previa
    _magnetometerSubscription?.cancel();

    // Conectar al sensor, y por cada dato, lanzar un evento interno
    _magnetometerSubscription = magnetometerEventStream().listen((
      magnetometerEvent,
    ) {
      add(_OnMagnetometerEvent(magnetometerEvent));
    });
  }

  void _onMagnetometerDataReceived(
    _OnMagnetometerEvent event,
    Emitter<SensorsState> emit,
  ) {
    emit(
      SensorsMagnetometer(x: event.event.x, y: event.event.y, z: event.event.z),
    );
  }

  void _onSensorCompass(OnUseCompass event, Emitter<SensorsState> emit) {
    //  cancelar cualquier escucha previa
    _compassSubscription?.cancel();

    if (FlutterCompass.events == null) {
      throw Exception('Device does not hace sensors!');
    }

    // Conectar al sensor, y por cada dato, lanzar un evento interno
    _compassSubscription = FlutterCompass.events!.listen((compassEvent) {
      add(_OnCompassEvent(compassEvent));
    });
  }

  void _onCompassDataReceived(
    _OnCompassEvent event,
    Emitter<SensorsState> emit,
  ) {
    emit(SensorsCompass(heading: event.event.heading ?? 0));
  }

  void _onSensorsStop(OnSensorsStop event, Emitter<SensorsState> emit) {
    _gyroscopeSubscription?.cancel();
    _accelerometerSubscription?.cancel();
    _magnetometerSubscription?.cancel();
    _compassSubscription?.cancel();
    emit(const SensorsInitial());
  }

  // Si GoRouter destruye el BLoC, apagar el sensor por si acaso
  @override
  Future<void> close() {
    _gyroscopeSubscription?.cancel();
    _accelerometerSubscription?.cancel();
    _magnetometerSubscription?.cancel();
    _compassSubscription?.cancel();
    return super.close();
  }
}
