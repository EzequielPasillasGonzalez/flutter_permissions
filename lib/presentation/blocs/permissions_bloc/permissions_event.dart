part of 'permissions_bloc.dart';

sealed class PermissionsEvent extends Equatable {
  const PermissionsEvent();

  @override
  List<Object> get props => [];
}

class RequestCameraPermission extends PermissionsEvent {
  const RequestCameraPermission();
}

class RequestPhotoLibraryPermission extends PermissionsEvent {
  const RequestPhotoLibraryPermission();
}

class RequestSensorsPermission extends PermissionsEvent {
  const RequestSensorsPermission();
}

class RequestLocationPermission extends PermissionsEvent {
  const RequestLocationPermission();
}

class RequestLocationAlwaysPermission extends PermissionsEvent {
  const RequestLocationAlwaysPermission();
}

class RequestLocationWhenInUsePermission extends PermissionsEvent {
  const RequestLocationWhenInUsePermission();
}

class CheckAllPermissions extends PermissionsEvent {
  const CheckAllPermissions();
}
