import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:reforzamiento/presentation/blocs/blocs.dart';

class GyroscopeScreen extends StatefulWidget {
  const GyroscopeScreen({super.key});

  @override
  State<GyroscopeScreen> createState() => _GyroscopeScreenState();
}

class _GyroscopeScreenState extends State<GyroscopeScreen> {
  late final SensorsBloc sensorsBloc;
  @override
  void initState() {
    super.initState();
    sensorsBloc = context.read<SensorsBloc>();
    sensorsBloc.gyroscopeStart();
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
        title: const Text('Giroscópio'),
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
            if (state is SensorsGyroscope) {
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
