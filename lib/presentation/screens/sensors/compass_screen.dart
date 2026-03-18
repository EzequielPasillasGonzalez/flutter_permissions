import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:reforzamiento/presentation/blocs/blocs.dart';
import 'package:reforzamiento/presentation/blocs/permissions_bloc/permissions_bloc.dart';
import 'package:reforzamiento/presentation/screens/permissions/ask_location_screen.dart';

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

class _CompassView extends StatelessWidget {
  final SensorsCompass state;

  const _CompassView({required this.state});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      spacing: 20,
      children: <Widget>[
        Text(
          state.toString(),
          style: TextStyle(color: Colors.white, fontSize: 30),
        ),
        Stack(
          alignment: AlignmentGeometry.center,
          children: <Widget>[
            Image.asset('assets/images/compass/quadrant-1.png'),

            Transform.rotate(
              angle: (state.heading * (pi / 180) * -1),
              child: Image.asset('assets/images/compass/needle-1.png'),
            ),
          ],
        ),
      ],
    );
  }
}
