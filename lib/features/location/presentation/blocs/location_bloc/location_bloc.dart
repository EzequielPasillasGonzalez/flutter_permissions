import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:reforzamiento/features/permissions/permissions.dart';

part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  final PermissionsBloc permissionsBloc;

  LocationBloc({required this.permissionsBloc}) : super(LocationState()) {
    on<GetCurrentLocation>(_onGetCurrentLocation);
  }
  void getCurrentLocation() {
    add(const GetCurrentLocation());
  }

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
}
