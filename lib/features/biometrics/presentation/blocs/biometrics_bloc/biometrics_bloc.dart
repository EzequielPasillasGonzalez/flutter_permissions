import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:reforzamiento/config/config.dart';

part 'biometrics_event.dart';
part 'biometrics_state.dart';

class BiometricsBloc extends Bloc<BiometricsEvent, BiometricsState> {
  BiometricsBloc() : super(BiometricsInitial()) {
    on<CheckBiometricsAvailability>(_onCheckAvailability);
    on<AuthenticateUser>(_onAuthenticateUser);
  }

  void checkBiometricsAvailability() {
    add(const CheckBiometricsAvailability());
  }

  void authenticateUser(String reason) {
    add(AuthenticateUser(reason: reason));
  } 

  Future<void> _onCheckAvailability(
    CheckBiometricsAvailability event,
    Emitter<BiometricsState> emit,
  ) async {
    final canCheck = await LocalAuthPlugin.canCheckBiometrics();

    if (canCheck) {
      emit(const BiometricCanCheck());
    } else {
      emit(const BiometricNotHardware());
    }
  }

  Future<void> _onAuthenticateUser(
    AuthenticateUser event,
    Emitter<BiometricsState> emit,
  ) async {
    // 1. Llamamos a tu plugin actualizado
    final (status, message) = await LocalAuthPlugin.authenticate();

    // 2. Evaluamos el Enum directamente
    switch (status) {
      case LocalAuthStatus.success:
        emit(const BiometricAuthenticated());
        break;

      case LocalAuthStatus.noHardware:
        emit(const BiometricNotHardware());
        break;

      case LocalAuthStatus.lockedOut:
        emit(const BiometricTooMuchIntents());
        break;

      case LocalAuthStatus.noBiometricsEnrolled:
      case LocalAuthStatus.noCredentialsSet:
        // Ambos casos los mandamos al estado de credenciales faltantes
        emit(const BiometricNotCredentialsSet());
        break;

      case LocalAuthStatus.canceled:
      case LocalAuthStatus.error:
        // Si cancela o hay error general, simplemente no está autenticado
        emit(const BiometricNotAuthenticated());
        break;
    }
  }
}
