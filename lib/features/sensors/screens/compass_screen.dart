import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:reforzamiento/features/permissions/presentation/blocs/permissions_bloc/permissions_bloc.dart';
import 'package:reforzamiento/features/permissions/presentation/screens/ask_location_screen.dart';
import 'package:reforzamiento/features/sensors/sensors.dart';

class CompassScreen extends StatefulWidget {
  const CompassScreen({super.key});

  @override
  State<CompassScreen> createState() => _CompassScreenState();
}

class _CompassScreenState extends State<CompassScreen> {
  late final SensorsBloc sensorsBloc;
  @override
  void initState() {
    sensorsBloc = context.read<SensorsBloc>();
    sensorsBloc.compassStart();
    super.initState();
  }

  @override
  void dispose() {
    sensorsBloc.sensorsStop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final permissionSatate = context.watch<PermissionsBloc>().state;
    final bool permissionLocationGranted = permissionSatate.locationGranted;

    if (!permissionLocationGranted) {
      return const AskLocationScreen();
    }

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          'CompassScreen',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
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
            if (state is SensorsCompass) {
              return _CompassView(state: state);
            }
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}

class _CompassView extends StatefulWidget {
  final SensorsCompass state;

  const _CompassView({required this.state});

  @override
  State<_CompassView> createState() => _CompassViewState();
}

class _CompassViewState extends State<_CompassView> {
  double prevValue = 0.0;

  double turns = 0;

  double getTurns() {
    double? direction = widget.state.heading;
    direction = (direction < 0) ? (360 + direction) : direction;

    double diff = direction - prevValue;
    if (diff.abs() > 180) {
      if (prevValue > direction) {
        diff = 360 - (direction - prevValue).abs();
      } else {
        diff = 360 - (prevValue - direction).abs();
        diff = diff * -1;
      }
    }

    turns += (diff / 360);
    prevValue = direction;

    return turns * -1;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      spacing: 20,
      children: <Widget>[
        Stack(
          alignment: AlignmentGeometry.center,
          children: <Widget>[
            Image.asset('assets/images/compass/needle-1.png'),

            AnimatedRotation(
              turns: getTurns(),
              duration: const Duration(seconds: 1),
              curve: Curves.easeOut,
              child: Image.asset('assets/images/compass/quadrant-1.png'),
            ),
          ],
        ),
      ],
    );
  }
}
