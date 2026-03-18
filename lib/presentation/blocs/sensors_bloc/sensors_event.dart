part of 'sensors_bloc.dart';

sealed class SensorsEvent extends Equatable {
  const SensorsEvent();

  @override
  List<Object?> get props => [];
}

class OnSensorsInitial extends SensorsEvent {
  const OnSensorsInitial();
}

class OnSensorsStop extends SensorsEvent {
  const OnSensorsStop();
}

class OnUseGyroscope extends SensorsEvent {
  const OnUseGyroscope();
}

class _OnGyroscopeEvent extends SensorsEvent {
  final GyroscopeEvent event;
  const _OnGyroscopeEvent(this.event);
  @override
  List<Object?> get props => [event];
}

class OnUseAccelerometer extends SensorsEvent {
  const OnUseAccelerometer();
}

class _OnAccelerometerEvent extends SensorsEvent {
  final AccelerometerEvent event;
  const _OnAccelerometerEvent(this.event);
  @override
  List<Object?> get props => [event];
}

class OnUseMagnetometer extends SensorsEvent {
  const OnUseMagnetometer();
}

class _OnMagnetometerEvent extends SensorsEvent {
  final MagnetometerEvent event;
  const _OnMagnetometerEvent(this.event);
  @override
  List<Object?> get props => [event];
}
