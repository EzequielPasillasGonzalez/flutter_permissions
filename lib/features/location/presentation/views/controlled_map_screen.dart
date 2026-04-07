import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:reforzamiento/features/location/location.dart';
import 'package:reforzamiento/features/widgets/full_screen_loader.dart';

class ControlledMapScreen extends StatefulWidget {
  const ControlledMapScreen({super.key});

  @override
  State<ControlledMapScreen> createState() => _ControlledMapScreenState();
}

class _ControlledMapScreenState extends State<ControlledMapScreen> {
  late LocationBloc locationBloc;

  @override
  void initState() {
    super.initState();
    locationBloc = context.read<LocationBloc>();
    locationBloc.getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    final locationState = context.watch<LocationBloc>().state;
    final mapBloc = context.watch<MapBloc>();
    final mapState = context.read<MapBloc>().state;

    if (locationState.loading) {
      return FullScreenLoader();
    } else {
      return Stack(
        children: <Widget>[
          _MapView(
            initialLat: locationState.lat,
            initialLng: locationState.lng,
          ),

          // ** salir de la pantalla
          Positioned(
            top: 40,
            left: 20,
            child: IconButton.filledTonal(
              onPressed: () {
                if (context.canPop()) {
                  context.pop();
                }
              },
              icon: const Icon(Icons.arrow_back),
            ),
          ),

          // ** posicionar al usuario
          Positioned(
            bottom: 40,
            left: 20,
            child: IconButton.filledTonal(
              onPressed: () =>
                  mapBloc.goToLocation(locationState.lat, locationState.lng),
              icon: const Icon(Icons.location_searching),
            ),
          ),

          // ** seguir al usuario
          Positioned(
            bottom: 90,
            left: 20,
            child: IconButton.filledTonal(
              onPressed: () => mapBloc.setToggleFollowUser(),
              icon: Icon(
                mapState.followUser
                    ? Icons.directions_run
                    : Icons.accessibility_new_outlined,
              ),
            ),
          ),

          // ** crear marcador
          Positioned(
            bottom: 140,
            left: 20,
            child: IconButton.filledTonal(
              onPressed: () => mapBloc.setMarker(
                locationState.lat,
                locationState.lng,
                title: 'Mi ubicación',
              ),
              icon: const Icon(Icons.pin_drop),
            ),
          ),
        ],
      );
    }
  }
}

class _MapView extends StatefulWidget {
  final double initialLat;
  final double initialLng;

  const _MapView({required this.initialLat, required this.initialLng});

  @override
  State<_MapView> createState() => _MapViewState();
}

class _MapViewState extends State<_MapView> {
  @override
  Widget build(BuildContext context) {
    final mapState = context.watch<MapBloc>().state;
    final mapBloc = context.read<MapBloc>();
    return GoogleMap(
      mapType: MapType.normal,
      markers: mapState.markersSet,
      myLocationButtonEnabled: false,
      zoomControlsEnabled: false,
      myLocationEnabled: true,
      compassEnabled: false,
      initialCameraPosition: CameraPosition(
        target: LatLng(widget.initialLat, widget.initialLng),
        zoom: 12,
      ),
      onMapCreated: (GoogleMapController controller) {
        context.read<MapBloc>().setControllerMap(controller);
      },
      onLongPress: (argument) => mapBloc.setMarker(
        argument.latitude,
        argument.longitude,
        title: 'Marcador desde long press',
      ),
    );
  }
}
