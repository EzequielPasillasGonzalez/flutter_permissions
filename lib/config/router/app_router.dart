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
  initialLocation: '/',
  routes: [
    // --- RUTAS INDEPENDIENTES ---
    GoRoute(path: '/', builder: (context, state) => const HomeScreen()),
    GoRoute(
      path: '/permissions',
      builder: (context, state) => const PermissionsScreen(),
    ),

    // --- BADGE ---
    GoRoute(
      path: '/badge',
      builder: (context, state) =>
          BlocProvider(create: (_) => BadgeCubit(), child: const BadgeScreen()),
    ),

    // --- BIOMETRICS ---
    GoRoute(
      path: '/biometrics',
      builder: (context, state) => BlocProvider(
        create: (_) => BiometricsBloc(),
        child: const BiometricScreen(),
      ),
    ),

    // --- ANUNCIOS ---
    GoRoute(
      path: '/ad-fullscreen',
      builder: (context, state) => const AdFullScreen(),
    ),
    GoRoute(
      path: '/ad-rewarded',
      builder: (context, state) => const AdRewardedScreen(),
    ),

    // --- UBICACIÓN Y MAPAS ---
    ShellRoute(
      builder: (context, state, child) => MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
                LocationBloc(permissionsBloc: context.read<PermissionsBloc>()),
          ),
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
          builder: (context, state) => const LocationScreen(),
        ),
        GoRoute(path: '/maps', builder: (context, state) => const MapScreen()),
        GoRoute(
          path: '/controlled-map',
          builder: (context, state) => const ControlledMapScreen(),
        ),
      ],
    ),

    // --- POKEMONS ---
    ShellRoute(
      builder: (context, state, child) => MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => PokemonsBloc()),
          BlocProvider(
            create: (_) => PokemonsDbCubit(),
          ),
        ],
        child: child,
      ),
      routes: [
        GoRoute(
          path: '/pokemons',
          builder: (context, state) => const PokemonsScreen(),
          routes: [
            GoRoute(
              path: ':id',
              builder: (context, state) {
                final id = state.pathParameters['id'] ?? '1';
                return PokemonScreen(pokemonId: int.parse(id));
              },
            ),
          ],
        ),
        GoRoute(
          path: '/pokemons-db',
          builder: (context, state) => const PokemonsDbScreen(),
        ),
      ],
    ),

    // --- SENSORES ---
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
