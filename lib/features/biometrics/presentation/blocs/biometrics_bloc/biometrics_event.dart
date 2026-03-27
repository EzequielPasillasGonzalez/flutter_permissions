part of 'biometrics_bloc.dart';

sealed class BiometricsEvent extends Equatable {
  const BiometricsEvent();

  @override
  List<Object> get props => [];
}

class CheckBiometricsAvailability extends BiometricsEvent {
  const CheckBiometricsAvailability();
}

class AuthenticateUser extends BiometricsEvent {
  final String reason;
  const AuthenticateUser({required this.reason});

  @override
  List<Object> get props => [reason];
}
