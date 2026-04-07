import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:reforzamiento/features/permissions/permissions.dart';

part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  final PermissionsBloc permissionsBloc;
  StreamSubscription<Position>? _locationSubscription;

  LocationBloc({required this.permissionsBloc}) : super(LocationState()) {
    on<GetCurrentLocation>(_onGetCurrentLocation);
    on<WatchLocation>(_onWatchLocation);
    on<OnNewLocation>(_onNewLocation);
  }
  void getCurrentLocation() => add(const GetCurrentLocation());

  void watchCurrentLocation() => add(const WatchLocation());

  

  void _onGetCurrentLocation(
    LocationEvent event,
    Emitter<LocationState> emit,
  ) async {
    // Revisar si el GPS del celular está encendido
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    emit(state.copyWith(serviceEnabled: serviceEnabled));
    if (!state.serviceEnabled) {
      emit(
        state.copyWith(
          message: 'El GPS está desactivado. Por favor, enciéndelo.',
        ),
      );
      return;
    }

    // Revisar los permisos usando otro BLoC
    PermissionStatus permission = permissionsBloc.state.location;

    if (permission == PermissionStatus.denied) {
      permission = await Permission.location.request();
      permissionsBloc.requestLocationAccess();
      if (permission == PermissionStatus.denied) {
        emit(
          state.copyWith(message: 'Se denegaron los permisos de ubicación.'),
        );
        return;
      }
    }

    if (permission == PermissionStatus.permanentlyDenied) {
      emit(
        state.copyWith(
          message:
              'Permisos denegados permanentemente. Ve a ajustes del teléfono.',
        ),
      );
      return;
    }

    try {
      emit(state.copyWith(loading: true));

      final location = await Geolocator.getCurrentPosition();

      emit(
        state.copyWith(
          lat: location.latitude,
          lng: location.longitude,
          loading: false,
          message: '¡Ubicación obtenida con éxito!',
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          message: 'Error al obtener la ubicación: $e',
          loading: false,
        ),
      );
    }
  }

  // Este evento se encarga de ACTUALIZAR el estado con cada movimiento
  void _onNewLocation(OnNewLocation event, Emitter<LocationState> emit) {
    emit(
      state.copyWith(
        lat: event.lat,
        lng: event.lng,
        loading: false,
        message: 'Ubicación actualizada',
      ),
    );
  }

  Future<void> _onWatchLocation(
    WatchLocation event,
    Emitter<LocationState> emit,
  ) async {
    // Revisar si el GPS del celular está encendido
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    emit(state.copyWith(serviceEnabled: serviceEnabled));
    if (!state.serviceEnabled) {
      emit(
        state.copyWith(
          message: 'El GPS está desactivado. Por favor, enciéndelo.',
        ),
      );
      return;
    }

    // Revisar los permisos usando otro BLoC
    PermissionStatus permission = permissionsBloc.state.location;

    if (permission == PermissionStatus.denied) {
      permission = await Permission.location.request();
      permissionsBloc.requestLocationAccess();
      if (permission == PermissionStatus.denied) {
        emit(
          state.copyWith(message: 'Se denegaron los permisos de ubicación.'),
        );
        return;
      }
    }

    if (permission == PermissionStatus.permanentlyDenied) {
      emit(
        state.copyWith(
          message:
              'Permisos denegados permanentemente. Ve a ajustes del teléfono.',
        ),
      );
      return;
    }

    await _locationSubscription?.cancel();

    emit(state.copyWith(loading: true));

    // SUSCRIPCIÓN ACTIVA
    _locationSubscription = Geolocator.getPositionStream().listen(
      (position) {
        // Por cada movimiento, dispara el evento de actualización
        add(OnNewLocation(position.latitude, position.longitude));
      },
      onError: (e) {
        emit(
          state.copyWith(message: 'Error en tiempo real: $e', loading: false),
        );
      },
    );
  }

  @override
  Future<void> close() {
    _locationSubscription?.cancel();
    return super.close();
  }
}
