import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:reforzamiento/features/location/location.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  final LocationBloc locationBloc;
  MapBloc({required this.locationBloc}) : super(MapState()) {
    on<SetMarker>(_onSetMarker);
    on<ControllerMap>(_onSetControllerMap);
    on<ToggleFollowUser>(_onToggleFollowUser);
  }

  void setMarker(double lat, double lng, {String? title, String? body}) =>
      add(SetMarker(lat: lat, lng: lng, title: title, body: body));
  void setToggleFollowUser() => add(ToggleFollowUser());

  void setControllerMap(GoogleMapController controller) =>
      add(ControllerMap(controller: controller));

  void goToLocation(double latitude, double longitude) {
    final newPosition = CameraPosition(
      target: LatLng(latitude, longitude),
      zoom: 15,
    );

    state.controller?.animateCamera(
      CameraUpdate.newCameraPosition(newPosition),
    );
  }

  void _onSetMarker(SetMarker event, Emitter<MapState> emit) {
    final newMarker = Marker(
      markerId: MarkerId('${state.markers.length}'),
      position: LatLng(event.lat, event.lng),
      infoWindow: InfoWindow(
        title: event.title,
        snippet: event.body ?? 'Esto es el snippet del info window',
      ),
    );

    emit(state.copyWith(markers: [...state.markers, newMarker]));
  }

  void _onToggleFollowUser(ToggleFollowUser event, Emitter<MapState> emit) {
    emit(state.copyWith(followUser: !state.followUser));
    if (!state.followUser) return;

    locationBloc.watchCurrentLocation();
    goToLocation(locationBloc.state.lat, locationBloc.state.lng);
  }

  void _onSetControllerMap(ControllerMap event, Emitter<MapState> emit) {
    emit(state.copyWith(controller: event.controller, isReady: true));
  }
}
