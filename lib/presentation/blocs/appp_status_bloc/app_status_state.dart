part of 'app_status_bloc.dart';

/*
    resumed: La app está visible y respondiendo al usuario (volvió a ella).

    inactive: La app está visible pero no recibe toques. Esto pasa, por ejemplo, cuando te entra una llamada telefónica clásica encima de la app, o cuando el usuario baja el panel de notificaciones del celular.

    paused: El usuario minimizó tu app o se fue a abrir otra cosa (como WhatsApp). Tu app sigue viva en la memoria RAM, pero está "dormida" en segundo plano (Background).

    detached: El motor de Flutter se desvinculó de la vista nativa. Suele ocurrir justo antes de que la aplicación sea destruida o cerrada por completo.
    */

sealed class AppStatusState extends Equatable {
  const AppStatusState();
  @override
  List<Object?> get props => [];
}

final class AppResumed extends AppStatusState {
  const AppResumed();
}

final class AppInactive extends AppStatusState {
  const AppInactive();
}

final class AppPaused extends AppStatusState {
  const AppPaused();
}

final class AppDetached extends AppStatusState {
  const AppDetached();
}

final class AppHiden extends AppStatusState {
  const AppHiden();
}
