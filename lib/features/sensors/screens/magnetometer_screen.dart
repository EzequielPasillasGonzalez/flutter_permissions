import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:reforzamiento/features/sensors/sensors.dart';

class MagnetometerScreen extends StatefulWidget {
  const MagnetometerScreen({super.key});

  @override
  State<MagnetometerScreen> createState() => _MagnetometerScreenState();
}

class _MagnetometerScreenState extends State<MagnetometerScreen> {
  late final SensorsBloc sensorsBloc;

  @override
  void initState() {
    super.initState();
    sensorsBloc = context.read<SensorsBloc>();
    sensorsBloc.magnetometerStart();
  }

  @override
  void dispose() {
    sensorsBloc.sensorsStop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MagnetometerScreen'),
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
        child: BlocBuilder<SensorsBloc, SensorsState>(
          builder: (context, state) {
            if (state is SensorsMagnetometer) {
              return Text(
                state.toString(),
                style: const TextStyle(fontSize: 30),
                textAlign: TextAlign.center,
              );
            }
            return const CircularProgressIndicator(); // Mientras arranca el sensor
          },
        ),
      ),
    );
  }
}
