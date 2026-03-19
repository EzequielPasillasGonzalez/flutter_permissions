import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:reforzamiento/features/permissions/permissions.dart';

class AskLocationScreen extends StatelessWidget {
  const AskLocationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final permissionBloc = context.read<PermissionsBloc>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Permiso requerido'),
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
