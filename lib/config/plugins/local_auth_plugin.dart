import 'package:local_auth/local_auth.dart';

class LocalAuthPlugin {
  static final LocalAuthentication auth = LocalAuthentication();

  static availableBiometrics() async {
    final List<BiometricType> availableBiometrics = await auth
        .getAvailableBiometrics();

    if (availableBiometrics.isNotEmpty) {}

    if (availableBiometrics.contains(BiometricType.strong) ||
        availableBiometrics.contains(BiometricType.face)) {}
  }

  static Future<bool> canCheckBiometrics() async {
    return await auth.canCheckBiometrics;
  }

  static Future<(bool, String)> authenticate() async {
    try {
      final bool didAuthenticate = await auth.authenticate(
        localizedReason: 'Por favor autenticate para continuar',
      );

      return (
        didAuthenticate,
        didAuthenticate ? 'Hecho' : 'Cancelado por el usuario',
      );
    } on LocalAuthException catch (e) {
      if (e.code == LocalAuthExceptionCode.noBiometricsEnrolled) {
        return (false, 'No hay biometricos enrolados');
      }
      if (e.code == LocalAuthExceptionCode.noBiometricHardware) {
        return (false, 'El dispositivo no tiene biometricos disponibles');
      }

      if (e.code == LocalAuthExceptionCode.noCredentialsSet) {
        return (false, 'No hay un PIN configurado');
      }

      if (e.code == LocalAuthExceptionCode.temporaryLockout ||
          e.code == LocalAuthExceptionCode.biometricLockout) {
        return (false, 'Muchos intentos fallidos, intente de otra forma');
      }

      return (false, e.toString());
    }
  }
}
