import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:reforzamiento/features/biometrics/biometrics.dart';
import 'package:reforzamiento/features/home/home.dart';
import 'package:reforzamiento/features/permissions/permissions.dart';
import 'package:reforzamiento/features/pokemons/pokemons.dart';

import 'package:reforzamiento/features/sensors/sensors.dart';

final router = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (context, state) => const HomeScreen()),
    GoRoute(
      path: '/permissions',
      builder: (context, state) => const PermissionsScreen(),
    ),

    GoRoute(
      path: '/permissions',
      builder: (context, state) => const PermissionsScreen(),
    ),

    GoRoute(
      path: '/bopmetrics',
      builder: (context, state) => const BiometricScreen(),
    ),

    ShellRoute(
      builder: (context, state, child) =>
          BlocProvider(create: (_) => PokemonsBloc(), child: child),
      routes: [
        GoRoute(
          path: '/pokemons',
          builder: (context, state) => PokemonsScreen(),
          routes: [
            GoRoute(
              path: ':id',
              builder: (context, state) {
                final id = state.pathParameters['id'] ?? 1;
                return PokemonScreen(pokemonId: int.parse(id.toString()));
              },
            ),
          ],
        ),
      ],
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
