part of 'biometrics_bloc.dart';

sealed class BiometricsState extends Equatable {
  const BiometricsState();

  @override
  List<Object> get props => [];
}

final class BiometricsInitial extends BiometricsState {}

final class BiometricCanCheck extends BiometricsState {
  const BiometricCanCheck();
}

final class BiometricAuthenticated extends BiometricsState {
  const BiometricAuthenticated();
}

final class BiometricNotAuthenticated extends BiometricsState {
  const BiometricNotAuthenticated();
}

final class BiometricTooMuchIntents extends BiometricsState {
  const BiometricTooMuchIntents();
}

final class BiometricNotHardware extends BiometricsState {
  const BiometricNotHardware();
}

final class BiometricNotCredentialsSet extends BiometricsState {
  const BiometricNotCredentialsSet();
}
