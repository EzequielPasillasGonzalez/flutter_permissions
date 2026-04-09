import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:reforzamiento/features/ads/ads.dart';

class AdFullScreen extends StatefulWidget {
  const AdFullScreen({super.key});

  @override
  State<AdFullScreen> createState() => _AdFullScreenState();
}

class _AdFullScreenState extends State<AdFullScreen> {
  @override
  void initState() {
    super.initState();
    context.read<AdmobCubit>().loadInterstitialAd();
  }

  @override
  Widget build(BuildContext context) {
    final adState = context.watch<AdmobCubit>().state;

    return Scaffold(
      appBar: AppBar(title: const Text('Ad Full Screen')),
      body: Center(child: _AdInterstitialWidget(state: adState)),
    );
  }
}

class _AdInterstitialWidget extends StatelessWidget {
  final AdmobState state;
  const _AdInterstitialWidget({required this.state});

  @override
  Widget build(BuildContext context) {
    // Si esta cargando y no hay anuncio aún
    if (state.isLoading && state.interstitialAd == null) {
      return const SizedBox(
        height: 50, // Altura típica de un banner
        child: Center(
          child: CircularProgressIndicator.adaptive(strokeWidth: 2),
        ),
      );
    }

    // Si hubo un error o simplemente no hay anuncio
    if (state.interstitialAd == null) {
      return const SizedBox();
    }

    return FilledButton(
      // Si el anuncio es null, el botón se deshabilita
      onPressed: state.interstitialAd != null
          ? () => context.read<AdmobCubit>().showInterstitialAd()
          : null,
      child: const Text('Mostrar Anuncio Pro'),
    );
  }
}
