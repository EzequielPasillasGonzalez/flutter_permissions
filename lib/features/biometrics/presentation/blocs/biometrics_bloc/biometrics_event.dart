part of 'biometrics_bloc.dart';

sealed class BiometricsEvent extends Equatable {
  const BiometricsEvent();

  @override
  List<Object> get props => [];
}

class OnBiometricAuthenticated extends BiometricsEvent {
  const OnBiometricAuthenticated();
}

class OnBiometricNotAuthenticated extends BiometricsEvent {
  const OnBiometricNotAuthenticated();
}

class OnBiometricCanCheck extends BiometricsEvent {
  const OnBiometricCanCheck();
}

class OnBiometricTooMuchItents extends BiometricsEvent {
  const OnBiometricTooMuchItents();
}

class OnBiometricNotHardware extends BiometricsEvent {
  const OnBiometricNotHardware();
}

class OnBiometricNotCredentialsSet extends BiometricsEvent {
  const OnBiometricNotCredentialsSet();
}
 