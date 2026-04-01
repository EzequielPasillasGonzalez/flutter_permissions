import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:reforzamiento/features/location/location.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  @override
  void initState() {
    super.initState();

    context.read<LocationBloc>().getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    final currentPosition = context.watch<LocationBloc>().state;

    return Scaffold(
      appBar: AppBar(
        title: const Text('MapScreen'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            }
          },
        ),
      ),
      body: _MapView(
        initialLat: currentPosition.lat,
        initialLng: currentPosition.lng,
      ),
    );
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
    return GoogleMap(
      mapType: MapType.hybrid,
      initialCameraPosition: CameraPosition(
        target: LatLng(widget.initialLat, widget.initialLng),
        zoom: 12,
      ),
      onMapCreated: (GoogleMapController controller) {
        // _controller.complete(controller);
      },
    );
  }
}
