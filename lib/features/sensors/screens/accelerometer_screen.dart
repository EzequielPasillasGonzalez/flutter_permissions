import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:reforzamiento/features/sensors/sensors.dart';

class AccelerometerScreen extends StatefulWidget {
  const AccelerometerScreen({super.key});

  @override
  State<AccelerometerScreen> createState() => _AccelerometerScreenState();
}

class _AccelerometerScreenState extends State<AccelerometerScreen> {
  late final SensorsBloc sensorsBloc;

  @override
  void initState() {
    sensorsBloc = context.read<SensorsBloc>();
    sensorsBloc.accelerometerStart();
    super.initState();
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
        title: const Text('Acelerómetro'),
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
            if (state is SensorsAccelerometer) {
              return Text(
                state.toString(),
                style: const TextStyle(fontSize: 30),
                textAlign: TextAlign.center,
              );
            }
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
