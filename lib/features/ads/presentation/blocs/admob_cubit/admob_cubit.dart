import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:reforzamiento/config/config.dart';

part 'admob_state.dart';

class AdmobCubit extends Cubit<AdmobState> {
  AdmobCubit() : super(AdmobState()) {
    checkAdsState();
  }

  void checkAdsState() async {
    final isEnabled = await SharedPreferencesPlugin.getBool('showAds');
    emit(state.copyWith(showAds: isEnabled));
  }

  void changeAdsState() async {
    final newState = !state.showAds;
    await SharedPreferencesPlugin.setBool('showAds', newState);
    emit(state.copyWith(showAds: newState));
  }

  void showInterstitialAd() {
    final ad = state.interstitialAd;
    if (ad == null) return;

    // 1. Limpiamos el estado PRIMERO para que nadie más pueda tocar este objeto
    emit(state.copyWith(interstitialAd: () => null));

    // 2. Mostramos el anuncio que ya tenemos guardado en la variable local 'ad'
    ad.show();
  }

  void showRewardedAd() {
    final adToShow = state.rewardedAd;
    if (adToShow == null) return;

    emit(state.copyWith(rewardedAd: () => null));
    adToShow.show(
      onUserEarnedReward: (ad, reward) {
        debugPrint('¡Premio otorgado! Cantidad: ${reward.amount}');
        emit(
          state.copyWith(
            rewardedPoints: (state.rewardedPoints + reward.amount).toInt(),
          ),
        );
      },
    );
  }

  Future<void> loadBanner() async {
    // Evitar cargar dos veces si ya está cargando o ya hay un anuncio
    if (state.isLoading || state.bannerAd != null) return;

    emit(state.copyWith(isLoading: true));

    try {
      final ad = await AdmobPlugin.loadBannerAd();
      emit(state.copyWith(bannerAd: () => ad, isLoading: false));
    } catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          errorMessage: () => 'Error al cargar el anuncio $e',
        ),
      );
    }
  }

  Future<void> loadInterstitialAd() async {
    // Evitar cargar dos veces si ya está cargando o ya hay un anuncio
    if (state.isLoading || state.interstitialAd != null) return;

    emit(state.copyWith(isLoading: true));

    try {
      final ad = await AdmobPlugin.loadInterstitialAd();

      // Importante: Configurar qué pasa cuando el usuario interactúa con el anuncio
      ad.fullScreenContentCallback = FullScreenContentCallback(
        onAdShowedFullScreenContent: (ad) => debugPrint('Anuncio en pantalla'),

        // Cuando el usuario cierra el anuncio:
        onAdDismissedFullScreenContent: (interstitialAd) {
          // Usamos la referencia que viene en el callback para cerrar
          interstitialAd.dispose();

          // Agregamos un pequeño delay o simplemente llamamos a cargar
          // pero asegurándonos de que el estado esté limpio.
          loadInterstitialAd();
        },
        // Si falla al mostrarse:
        onAdFailedToShowFullScreenContent: (ad, error) {
          ad.dispose();
          emit(state.copyWith(interstitialAd: null));
        },
      );

      emit(state.copyWith(interstitialAd: () => ad, isLoading: false));
    } catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          errorMessage: () => 'Error al cargar el anuncio $e',
        ),
      );
    }
  }

  Future<void> loadRewardedAd() async {
    if (state.isLoading || state.rewardedAd != null) return;
    emit(state.copyWith(isLoading: true));

    try {
      final ad = await AdmobPlugin.loadRewardedAd();

      ad.fullScreenContentCallback = FullScreenContentCallback(
        onAdShowedFullScreenContent: (ad) => debugPrint('Anuncio en pantalla'),

        onAdDismissedFullScreenContent: (ad) {
          debugPrint('El usuario cerró el anuncio');
          ad.dispose(); // Aquí es el único lugar donde se destruye
          loadRewardedAd(); // Cargamos el siguiente
        },

        onAdFailedToShowFullScreenContent: (ad, error) {
          debugPrint('Falló al mostrarse: $error');
          ad.dispose(); //  Destruimos porque falló
          // Limpiamos el estado por si acaso seguía ahí
          emit(state.copyWith(rewardedAd: () => null));
          loadRewardedAd();
        },
      );

      emit(state.copyWith(rewardedAd: () => ad, isLoading: false));
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: () => 'Error: $e'));
    }
  }

  //  Limpiar el anuncio cuando el Cubit se destruya
  @override
  Future<void> close() {
    state.bannerAd?.dispose();
    state.interstitialAd?.dispose();
    state.rewardedAd?.dispose();
    return super.close();
  }
}
