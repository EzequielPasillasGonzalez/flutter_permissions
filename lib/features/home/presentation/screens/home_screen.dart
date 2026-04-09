import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:reforzamiento/features/ads/presentation/blocs/admob_cubit/admob_cubit.dart';
import 'package:reforzamiento/features/home/presentation/screens/main_menu.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<AdmobCubit>().loadBanner();
  }

  @override
  Widget build(BuildContext context) {
    final adBannerState = context.watch<AdmobCubit>().state;

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: CustomScrollView(
                slivers: [
                  SliverAppBar(
                    title: const Text('Miscelaneos'),
                    actions: [
                      IconButton(
                        onPressed: () => context.push('/permissions'),
                        icon: Icon(Icons.settings_sharp),
                      ),
                    ],
                  ),
                  const MainMenu(),
                ],
              ),
            ),
          ),

          // Ad Banner
          _AdBannerWidget(state: adBannerState),
        ],
      ),
    );
  }
}

class _AdBannerWidget extends StatelessWidget {
  final AdmobState state;
  const _AdBannerWidget({required this.state});

  @override
  Widget build(BuildContext context) {
    // Si esta cargando y no hay anuncio aún
    if (state.isLoading && state.bannerAd == null) {
      return const SizedBox(
        height: 50, // Altura típica de un banner
        child: Center(
          child: CircularProgressIndicator.adaptive(strokeWidth: 2),
        ),
      );
    }

    // Si hubo un error o simplemente no hay anuncio
    if (state.bannerAd == null) {
      return const SizedBox();
    }

    return SizedBox(
      width: state.bannerAd!.size.width.toDouble(),
      height: state.bannerAd!.size.height.toDouble(),
      child: AdWidget(ad: state.bannerAd!),
    );
  }
}
