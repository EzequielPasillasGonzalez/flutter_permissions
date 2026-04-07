part of 'map_bloc.dart';

sealed class MapEvent extends Equatable {
  const MapEvent();

  @override
  List<Object?> get props => [];
}

final class SetMarker extends MapEvent {
  const SetMarker({
    required this.lat,
    required this.lng,
    this.title,
    this.body,
  });
  final double lat;
  final double lng;
  final String? title;
  final String? body;

  @override
  List<Object?> get props => [lat, lng, title, body];
}

final class ControllerMap extends MapEvent {
  const ControllerMap({required this.controller});
  final GoogleMapController controller;

  @override
  List<Object> get props => [controller];
}

final class ToggleFollowUser extends MapEvent {
  const ToggleFollowUser();
}
