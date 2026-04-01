import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:reforzamiento/features/location/location.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  @override
  void initState() {
    super.initState();
    context.read<LocationBloc>().getCurrentLocation();
    context.read<LocationBloc>().watchCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    final locationState = context.watch<LocationBloc>().state;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ubicacion'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            }
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 30,
          children: <Widget>[
            const Text('Ubicación Actual'),
            Text(locationState.toString()),
            const Text('Seguimiento de Ubicación'),
            Text(locationState.message),
          ],
        ),
      ),
    );
  }
}
