import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reforzamiento/presentation/blocs/blocs.dart';

class AskLocationScreen extends StatelessWidget {
  const AskLocationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final permissionBloc = context.read<PermissionsBloc>();

    return Scaffold(
      appBar: AppBar(title: const Text('Permiso requerido')),
      body: Center(
        child: FilledButton(
          onPressed: () {
            permissionBloc.requestLocationAccess();
          },
          child: const Text('Localización necesaria'),
        ),
      ),
    );
  }
}
