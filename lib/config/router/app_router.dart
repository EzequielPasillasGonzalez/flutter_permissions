import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:reforzamiento/presentation/blocs/blocs.dart';
import 'package:reforzamiento/presentation/screens/screens.dart';

final router = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (context, state) => const HomeScreen()),
    GoRoute(
      path: '/permissions',
      builder: (context, state) => const PermissionsScreen(),
    ),

    ShellRoute(
      builder: (context, state, child) =>
          BlocProvider(create: (_) => SensorsBloc(), child: child),
      routes: [
        GoRoute(
          path: '/gyroscope',
          builder: (context, state) => const GyroscopeScreen(),
        ),

        GoRoute(
          path: '/accelerometer',
          builder: (context, state) => const AccelerometerScreen(),
        ),

        GoRoute(
          path: '/magnetometer',
          builder: (context, state) => const MagnetometerScreen(),
        ),

        GoRoute(
          path: '/gyroscope-ball',
          builder: (context, state) => const GyroscopeBallScreen(),
        ),

        GoRoute(
          path: '/compass',
          builder: (context, state) => const CompassScreen(),
        ),
      ],
    ),
  ],
);
