import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reforzamiento/features/ads/ads.dart';
import 'package:reforzamiento/features/permissions/presentation/blocs/permissions_bloc/permissions_bloc.dart';

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
    final ads = context.watch<AdmobCubit>().state;
    final adsCubit = context.read<AdmobCubit>();
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

        CheckboxListTile(
          value: permissions.photoLibraryGranted,
          onChanged: (_) {
            permissionsBloc.requestPhotoLibraryAccess();
          },
          title: const Text('Galeria'),
          subtitle: Text('Estado actual: ${permissions.photoLibrary}'),
        ),

        CheckboxListTile(
          value: permissions.sensorsGranted,
          onChanged: (_) {
            permissionsBloc.requestSensorsAccess();
          },
          title: const Text('Sensores'),
          subtitle: Text('Estado actual: ${permissions.sensors}'),
        ),

        CheckboxListTile(
          value: permissions.locationGranted,
          onChanged: (_) {
            permissionsBloc.requestLocationAccess();
          },
          title: const Text('Ubicación'),
          subtitle: Text('Estado actual: ${permissions.location}'),
        ),

        CheckboxListTile(
          value: permissions.locationAlwaysGranted,
          onChanged: (_) {
            permissionsBloc.requestLocationAlwaysAccess();
          },
          title: const Text('Location Always'),
          subtitle: Text('Estado actual: ${permissions.locationAlways}'),
        ),

        CheckboxListTile(
          value: permissions.locationWhenInUseGranted,
          onChanged: (_) {
            permissionsBloc.requestLocationWhenInUseAccess();
          },
          title: const Text('Location cuando se usa'),
          subtitle: Text('Estado actual: ${permissions.locationWhenInUse}'),
        ),

        CheckboxListTile(
          value: ads.showAds,
          onChanged: (_) {
            adsCubit.changeAdsState();
          },
          title: const Text('¿Quieres ver anuncios?'),
          subtitle: Text('Estado actual: ${ads.showAds ? 'Sí' : 'No'}'),
        ),
      ],
    );
  }
}
