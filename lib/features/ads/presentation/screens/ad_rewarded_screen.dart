import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reforzamiento/features/ads/ads.dart';

class AdRewardedScreen extends StatefulWidget {
  const AdRewardedScreen({super.key});

  @override
  State<AdRewardedScreen> createState() => _AdRewardedScreenState();
}

class _AdRewardedScreenState extends State<AdRewardedScreen> {
  @override
  void initState() {
    super.initState();
    context.read<AdmobCubit>().loadRewardedAd();
  }

  @override
  Widget build(BuildContext context) {
    final adState = context.watch<AdmobCubit>().state;

    return Scaffold(
      appBar: AppBar(title: const Text('Ad Rewarded Screen')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Puntos obtenidos: ${adState.rewardedPoints}'),
            _AdRewardedWidget(state: adState),
          ],
        ),
      ),
    );
  }
}

class _AdRewardedWidget extends StatelessWidget {
  final AdmobState state;
  const _AdRewardedWidget({required this.state});

  @override
  Widget build(BuildContext context) {
    // Si esta cargando y no hay anuncio aún
    if (state.isLoading && state.rewardedAd == null) {
      return const SizedBox(
        height: 50, // Altura típica de un banner
        child: Center(
          child: CircularProgressIndicator.adaptive(strokeWidth: 2),
        ),
      );
    }

    // Si hubo un error o simplemente no hay anuncio
    if (state.rewardedAd == null) {
      return const Text('No hay anuncios disponibles en este momento');
    }

    return FilledButton(
      // Si está cargando o no hay anuncio, botón deshabilitado (null)
      onPressed: (state.rewardedAd != null && !state.isLoading)
          ? () => context.read<AdmobCubit>().showRewardedAd()
          : null,
      child: state.isLoading
          ? const Text('Cargando...')
          : const Text('Ver anuncio para premio'),
    );
  }
}
