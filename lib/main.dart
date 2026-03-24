import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reforzamiento/config/config.dart';
import 'package:reforzamiento/config/const/enviroment.dart';
import 'package:reforzamiento/features/app_status/app_status.dart';
import 'package:reforzamiento/features/permissions/permissions.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Enviroment.initEnviroment();

  // Setear una horientacion
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => AppStatusBloc()),
        BlocProvider(create: (_) => PermissionsBloc()),
      ],
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

    final PermissionsBloc permissionsBloc = context.read<PermissionsBloc>();

    switch (state) {
      case AppLifecycleState.resumed:
        permissionsBloc.checkPermissions();
        break;
      case AppLifecycleState.inactive:
        break;
      case AppLifecycleState.paused:
        break;
      case AppLifecycleState.detached:
        break;
      case AppLifecycleState.hidden:
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
