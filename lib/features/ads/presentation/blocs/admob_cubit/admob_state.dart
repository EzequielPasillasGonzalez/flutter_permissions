part of 'admob_cubit.dart';

class AdmobState extends Equatable {
  final BannerAd? bannerAd;
  final bool isLoading;
  final String? errorMessage;

  const AdmobState({this.bannerAd, this.isLoading = false, this.errorMessage});

  AdmobState copyWith({
    BannerAd? bannerAd,
    bool? isLoading,
    String? errorMessage,
  }) => AdmobState(
    bannerAd: bannerAd ?? this.bannerAd,
    isLoading: isLoading ?? this.isLoading,
    errorMessage:
        errorMessage, // Aquí permitir que sea null para limpiar errores
  );

  @override
  List<Object?> get props => [bannerAd, isLoading, errorMessage];
}
