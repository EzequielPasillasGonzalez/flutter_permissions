import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reforzamiento/config/config.dart';
import 'package:reforzamiento/presentation/blocs/appp_status_bloc/app_status_bloc.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: [BlocProvider(create: (_) => AppStatusBloc())],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();

    // observador que sirve para que la aplicación se entere de lo que el usuario está haciendo fuera de ella
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print('State: $state');
    /*
    resumed: La app está visible y respondiendo al usuario (volvió a ella).

    inactive: La app está visible pero no recibe toques. Esto pasa, por ejemplo, cuando te entra una llamada telefónica clásica encima de la app, o cuando el usuario baja el panel de notificaciones del celular.

    paused: El usuario minimizó tu app o se fue a abrir otra cosa (como WhatsApp). Tu app sigue viva en la memoria RAM, pero está "dormida" en segundo plano (Background).

    detached: El motor de Flutter se desvinculó de la vista nativa. Suele ocurrir justo antes de que la aplicación sea destruida o cerrada por completo.
    */

    final AppStatusBloc appStatusBloc = context.read<AppStatusBloc>();

    switch (state) {
      case AppLifecycleState.resumed:
        appStatusBloc.onAppResumed();
        break;
      case AppLifecycleState.inactive:
        appStatusBloc.onAppInactive();
        break;
      case AppLifecycleState.paused:
        appStatusBloc.onAppPaused();
        break;
      case AppLifecycleState.detached:
        appStatusBloc.onAppDetached();
        break;
      case AppLifecycleState.hidden:
        appStatusBloc.onAppHiden();
        break;
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: AppTheme().getTheme(),
      debugShowCheckedModeBanner: false,
      routerConfig: router,
    );
  }
}
