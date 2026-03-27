enum LocalAuthStatus {
  success, //  ok
  canceled, // El usuario le dio al botón de cancelar
  noBiometricsEnrolled, // El celular tiene lector, pero no hay huellas guardadas
  noHardware, // El celular no tiene lector físico
  noCredentialsSet, // No hay PIN ni patrón configurado en el celular
  lockedOut, // Se equivocó muchas veces y el sensor se bloqueó
  error, // Cualquier otro error raro
}
