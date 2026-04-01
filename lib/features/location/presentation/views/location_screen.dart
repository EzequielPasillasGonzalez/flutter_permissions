import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  }

  @override
  Widget build(BuildContext context) {
    final locationState = context.watch<LocationBloc>().state;

    return Scaffold(
      appBar: AppBar(title: const Text('Ubicacion')),
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
