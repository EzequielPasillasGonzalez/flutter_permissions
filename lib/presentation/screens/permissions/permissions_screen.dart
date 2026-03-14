import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reforzamiento/presentation/blocs/permissions_bloc/permissions_bloc.dart';

class PermissionsScreen extends StatelessWidget {
  const PermissionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Permisos')),
      body: _PermissionsView(),
    );
  }
}

class _PermissionsView extends StatelessWidget {
  const _PermissionsView();

  @override
  Widget build(BuildContext context) {
    final permissions = context.watch<PermissionsBloc>().state;
    final permissionsBloc = context.read<PermissionsBloc>();

    return ListView(
      children: [
        CheckboxListTile(
          value: permissions.cameraGranted,
          onChanged: (_) {
            permissionsBloc.requestCameraAccess();
          },
          title: const Text('Cámara'),
          subtitle: Text('Estado actual: ${permissions.camera}'),
        ),
      ],
    );
  }
}
