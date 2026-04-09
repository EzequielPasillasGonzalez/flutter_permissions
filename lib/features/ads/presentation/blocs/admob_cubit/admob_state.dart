part of 'admob_cubit.dart';

class AdmobState extends Equatable {
  final BannerAd? bannerAd;
  final InterstitialAd? interstitialAd;
  final bool isLoading;
  final String? errorMessage;

  const AdmobState({
    this.bannerAd,
    this.isLoading = false,
    this.errorMessage,
    this.interstitialAd,
  });

  AdmobState copyWith({
    BannerAd? Function()? bannerAd,
    InterstitialAd? Function()? interstitialAd,
    bool? isLoading,
    String? Function()? errorMessage,
  }) => AdmobState(
    bannerAd: (bannerAd != null) ? bannerAd() : this.bannerAd,
    interstitialAd: (interstitialAd != null)
        ? interstitialAd()
        : this.interstitialAd,
    isLoading: isLoading ?? this.isLoading,
    errorMessage: (errorMessage != null) ? errorMessage() : this.errorMessage,
  );

  @override
  List<Object?> get props => [
    bannerAd,
    interstitialAd,
    isLoading,
    errorMessage,
  ];
}
