import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:permission_handler/permission_handler.dart';

part 'permissions_event.dart';
part 'permissions_state.dart';

class PermissionsBloc extends Bloc<PermissionsEvent, PermissionsState> {
  PermissionsBloc() : super(const PermissionsState()) {
    on<CheckAllPermissions>(_onCheckAllPermissions);
    on<RequestCameraPermission>(_onRequestCamera);
    on<RequestPhotoLibraryPermission>(_onRequestPhotoLibrary);
    on<RequestSensorsPermission>(_onRequestSensors);
    on<RequestLocationPermission>(_onRequestLocation);
    on<RequestLocationAlwaysPermission>(_onRequestLocationAlways);
    on<RequestLocationWhenInUsePermission>(_onRequestLocationWhenInUse);
  }

  // --- Funciones de acceso rápido para la UI ---
  void checkPermissions() => add(const CheckAllPermissions());
  void requestCameraAccess() => add(const RequestCameraPermission());
  void requestPhotoLibraryAccess() =>
      add(const RequestPhotoLibraryPermission());
  void requestSensorsAccess() => add(const RequestSensorsPermission());
  void requestLocationAccess() => add(const RequestLocationPermission());
  void requestLocationAlwaysAccess() =>
      add(const RequestLocationAlwaysPermission());
  void requestLocationWhenInUseAccess() =>
      add(const RequestLocationWhenInUsePermission());

  // --- Lógica Interna de los Eventos ---
  Future<void> _onCheckAllPermissions(
    CheckAllPermissions event,
    Emitter<PermissionsState> emit,
  ) async {
    final permissions = await Future.wait([
      Permission.camera.status,
      Permission.photos.status,
      Permission.sensors.status,
      Permission.location.status,
      Permission.locationAlways.status,
      Permission.locationWhenInUse.status,
    ]);

    emit(
      state.copyWith(
        camera: permissions[0],
        photoLibrary: permissions[1],
        sensors: permissions[2],
        location: permissions[3],
        locationAlways: permissions[4],
        locationWhenInUse: permissions[5],
      ),
    );
  }

  Future<void> _onRequestCamera(
    RequestCameraPermission event,
    Emitter<PermissionsState> emit,
  ) async {
    final status = await Permission.camera.request();
    emit(state.copyWith(camera: status));
  }

  Future<void> _onRequestPhotoLibrary(
    RequestPhotoLibraryPermission event,
    Emitter<PermissionsState> emit,
  ) async {
    final status = await Permission.photos.request();
    emit(state.copyWith(photoLibrary: status));
  }

  Future<void> _onRequestSensors(
    RequestSensorsPermission event,
    Emitter<PermissionsState> emit,
  ) async {
    final status = await Permission.sensors.request();
    emit(state.copyWith(sensors: status));
  }

  Future<void> _onRequestLocation(
    RequestLocationPermission event,
    Emitter<PermissionsState> emit,
  ) async {
    final status = await Permission.location.request();
    emit(state.copyWith(location: status));
  }

  Future<void> _onRequestLocationAlways(
    RequestLocationAlwaysPermission event,
    Emitter<PermissionsState> emit,
  ) async {
    final status = await Permission.locationAlways.request();
    emit(state.copyWith(locationAlways: status));
  }

  Future<void> _onRequestLocationWhenInUse(
    RequestLocationWhenInUsePermission event,
    Emitter<PermissionsState> emit,
  ) async {
    final status = await Permission.locationWhenInUse.request();
    emit(state.copyWith(locationWhenInUse: status));
  }
}
