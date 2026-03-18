part of 'sensors_bloc.dart';

sealed class SensorsEvent extends Equatable {
  const SensorsEvent();

  @override
  List<Object?> get props => [];
}

class OnSensorsInitial extends SensorsEvent {
  const OnSensorsInitial();
}

class OnUseGyroscope extends SensorsEvent {
  const OnUseGyroscope();
}

class OnSensorsStop extends SensorsEvent {
  const OnSensorsStop();
}


class _OnGyroscopeEvent extends SensorsEvent {
  final GyroscopeEvent event;
  const _OnGyroscopeEvent(this.event);
  @override
  List<Object?> get props => [event];
}
