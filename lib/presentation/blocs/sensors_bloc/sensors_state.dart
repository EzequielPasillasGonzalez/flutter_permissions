part of 'sensors_bloc.dart';

sealed class SensorsState extends Equatable {
  const SensorsState();

  @override
  List<Object?> get props => [];
}

final class SensorsInitial extends SensorsState {
  const SensorsInitial();
}

final class SensorsGyroscope extends SensorsState {
  final double x;
  final double y;
  final double z;

  const SensorsGyroscope({required this.x, required this.y, required this.z});

  @override
  List<Object?> get props => [x, y, z];

  @override
  String toString() {
    return '''
    X: ${x.toStringAsFixed(2)}\n
    Y: ${y.toStringAsFixed(2)}\n
    Z: ${z.toStringAsFixed(2)}
    ''';
  }
}

final class SensorsAccelerometer extends SensorsState {
  final double x;
  final double y;
  final double z;

  const SensorsAccelerometer({
    required this.x,
    required this.y,
    required this.z,
  });

  @override
  List<Object?> get props => [x, y, z];

  @override
  String toString() {
    return '''
    X: ${x.toStringAsFixed(2)}\n
    Y: ${y.toStringAsFixed(2)}\n
    Z: ${z.toStringAsFixed(2)}
    ''';
  }
}
