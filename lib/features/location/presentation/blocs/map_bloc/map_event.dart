part of 'map_bloc.dart';

sealed class MapEvent extends Equatable {
  const MapEvent();

  @override
  List<Object> get props => [];
}

final class SetMarker extends MapEvent {
  const SetMarker({required this.marker});
  final Marker marker;

  @override
  List<Object> get props => [marker];
}

final class ControllerMap extends MapEvent {
  const ControllerMap({required this.controller});
  final GoogleMapController controller;

  @override
  List<Object> get props => [controller];
}
