import 'package:local_auth/local_auth.dart';
import 'package:reforzamiento/config/config.dart';

class LocalAuthPlugin {
  static final LocalAuthentication auth = LocalAuthentication();

  static void availableBiometrics() async {
    final List<BiometricType> availableBiometrics = await auth
        .getAvailableBiometrics();

    if (availableBiometrics.isNotEmpty) {}

    if (availableBiometrics.contains(BiometricType.strong) ||
        availableBiometrics.contains(BiometricType.face)) {}
  }

  static Future<bool> canCheckBiometrics() async {
    return await auth.canCheckBiometrics;
  }

  static Future<(LocalAuthStatus, String)> authenticate() async {
    try {
      final bool didAuthenticate = await auth.authenticate(
        localizedReason: 'Por favor autenticate para continuar',
      );

      if (didAuthenticate) {
        return (LocalAuthStatus.success, 'Hecho');
      } else {
        return (LocalAuthStatus.canceled, 'Cancelado por el usuario');
      }
    } on LocalAuthException catch (e) {
      if (e.code == LocalAuthExceptionCode.noBiometricsEnrolled) {
        return (
          LocalAuthStatus.noBiometricsEnrolled,
          'No hay biométricos enrolados',
        );
      }
      if (e.code == LocalAuthExceptionCode.noBiometricHardware) {
        return (
          LocalAuthStatus.noHardware,
          'El dispositivo no tiene biométricos disponibles',
        );
      }
      if (e.code == LocalAuthExceptionCode.noCredentialsSet) {
        return (LocalAuthStatus.noCredentialsSet, 'No hay un PIN configurado');
      }
      if (e.code == LocalAuthExceptionCode.temporaryLockout ||
          e.code == LocalAuthExceptionCode.biometricLockout) {
        return (
          LocalAuthStatus.lockedOut,
          'Muchos intentos fallidos, intente de otra forma',
        );
      }

      // Si es un error distinto de los de arriba
      return (LocalAuthStatus.error, e.toString());
    } catch (e) {
      // Para cualquier otro tipo de error de Dart que no sea de biométricos
      return (LocalAuthStatus.error, 'Error inesperado: $e');
    }
  }
}
