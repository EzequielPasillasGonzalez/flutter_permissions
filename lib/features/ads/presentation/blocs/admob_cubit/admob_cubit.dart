import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:reforzamiento/config/plugins/admob_plugin.dart';

part 'admob_state.dart';

class AdmobCubit extends Cubit<AdmobState> {
  AdmobCubit() : super(AdmobState());

  Future<void> loadBanner() async {
    // Evitar cargar dos veces si ya está cargando o ya hay un anuncio
    if (state.isLoading || state.bannerAd != null) return;

    emit(state.copyWith(isLoading: true));

    try {
      final ad = await AdmobPlugin.loadBannerAd();
      emit(state.copyWith(bannerAd: ad, isLoading: false));
    } catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          errorMessage: 'Error al cargar el anuncio $e',
        ),
      );
    }
  }

  //  Limpiar el anuncio cuando el Cubit se destruya
  @override
  Future<void> close() {
    state.bannerAd?.dispose();
    return super.close();
  }
}
