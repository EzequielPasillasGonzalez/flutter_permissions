import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:reforzamiento/features/ads/ads.dart';
import 'package:reforzamiento/features/badge/badge.dart';
import 'package:reforzamiento/features/biometrics/biometrics.dart';
import 'package:reforzamiento/features/home/home.dart';
import 'package:reforzamiento/features/location/location.dart';
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
      path: '/ad-fullscreen',
      builder: (context, state) => const AdFullScreen(),
    ),
    GoRoute(
      path: '/ad-rewarded',
      builder: (context, state) => const AdRewardedScreen(),
    ),
    GoRoute(
      path: '/badge',
      builder: (context, state) => BlocProvider(
        create: (context) => BadgeCubit(),
        child: const BadgeScreen(),
      ),
    ),

    ShellRoute(
      builder: (context, state, child) => MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) =>
                LocationBloc(permissionsBloc: context.read<PermissionsBloc>()),
          ),

          // Para el segundo, se usa el "context" que ya TIENE al de arriba para acceder a el LocationBloc
          BlocProvider(
            create: (context) =>
                MapBloc(locationBloc: context.read<LocationBloc>()),
          ),
        ],
        child: child,
      ),
      routes: [
        GoRoute(
          path: '/location',
          builder: (contet, state) => const LocationScreen(),
        ),

        GoRoute(path: '/maps', builder: (context, state) => const MapScreen()),

        GoRoute(
          path: '/controlled-map',
          builder: (context, state) => const ControlledMapScreen(),
        ),
      ],
    ),

    GoRoute(
      path: '/biometrics',
      builder: (context, state) => BlocProvider(
        create: (context) => BiometricsBloc(),
        child: const BiometricScreen(),
      ),
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
