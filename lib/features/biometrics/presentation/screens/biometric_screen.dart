import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reforzamiento/features/biometrics/biometrics.dart';

class BiometricScreen extends StatefulWidget {
  const BiometricScreen({super.key});

  @override
  State<BiometricScreen> createState() => _BiometricScreenState();
}

class _BiometricScreenState extends State<BiometricScreen> {
  @override
  void initState() {
    super.initState();

    context.read<BiometricsBloc>().checkBiometricsAvailability();
  }

  @override
  Widget build(BuildContext context) {
    final biometricsState = context.watch<BiometricsBloc>().state;
    final biometricsBloc = context.read<BiometricsBloc>();

    String canCheckText = 'Evaluando...';
    if (biometricsState is BiometricNotHardware) {
      canCheckText = 'No disponible';
    } else if (biometricsState is! BiometricsInitial) {
      canCheckText = 'Sí, disponible';
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Biometric Screen')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 40,
          children: <Widget>[
            FilledButton.tonal(
              onPressed: () {
                biometricsBloc.authenticateUser('Amigo o enemigo?');
              },
              child: const Text('Autenticar'),
            ),

            Text('Puede revisar biométricos: $canCheckText'),

            const Text('Estado del biométrico', style: TextStyle(fontSize: 30)),

            Text(
              biometricsState.runtimeType.toString(),
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,

                color: Colors.blueAccent,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
