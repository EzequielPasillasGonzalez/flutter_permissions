import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:reforzamiento/presentation/blocs/permissions_bloc/permissions_bloc.dart';
import 'package:reforzamiento/presentation/screens/permissions/ask_location_screen.dart';

class CompassScreen extends StatelessWidget {
  const CompassScreen({super.key});

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
      body: const Center(child: _CompassView()),
    );
  }
}

class _CompassView extends StatelessWidget {
  const _CompassView();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      spacing: 20,
      children: <Widget>[
        const Text('155°', style: TextStyle(color: Colors.white, fontSize: 30)),
        Stack(
          alignment: AlignmentGeometry.center,
          children: <Widget>[
            Image.asset('assets/images/compass/quadrant-1.png'),
            Image.asset('assets/images/compass/needle-1.png'),
          ],
        ),
      ],
    );
  }
}
