import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  MapBloc() : super(MapState()) {
    on<SetMarker>(_onSetMarker);
    on<ControllerMap>(_onSetControllerMap);
  }

  void setMarker(Marker marker) => add(SetMarker(marker: marker));

  void goToLocation(double latitude, double longitude) {
    final newPosition = CameraPosition(
      target: LatLng(latitude, longitude),
      zoom: 15,
    );

    state.controller?.animateCamera(
      CameraUpdate.newCameraPosition(newPosition),
    );
  }

  void setControllerMap(GoogleMapController controller) =>
      add(ControllerMap(controller: controller));

  void _onSetMarker(SetMarker event, Emitter<MapState> emit) {}

  void _onSetControllerMap(ControllerMap event, Emitter<MapState> emit) {
    emit(state.copyWith(controller: event.controller, isReady: true));
  }
}
