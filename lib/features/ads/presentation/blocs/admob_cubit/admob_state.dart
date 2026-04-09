part of 'admob_cubit.dart';

class AdmobState extends Equatable {
  final BannerAd? bannerAd;
  final InterstitialAd? interstitialAd;
  final RewardedAd? rewardedAd;
  final int rewardedPoints;
  final bool isLoading;
  final String? errorMessage;

  const AdmobState({
    this.bannerAd,
    this.isLoading = false,
    this.rewardedPoints = 0,
    this.errorMessage,
    this.interstitialAd,
    this.rewardedAd,
  });

  AdmobState copyWith({
    BannerAd? Function()? bannerAd,
    InterstitialAd? Function()? interstitialAd,
    RewardedAd? Function()? rewardedAd,
    bool? isLoading,
    int? rewardedPoints,
    String? Function()? errorMessage,
  }) => AdmobState(
    bannerAd: (bannerAd != null) ? bannerAd() : this.bannerAd,
    interstitialAd: (interstitialAd != null)
        ? interstitialAd()
        : this.interstitialAd,
    rewardedAd: (rewardedAd != null) ? rewardedAd() : this.rewardedAd,
    isLoading: isLoading ?? this.isLoading,
    rewardedPoints: rewardedPoints ?? this.rewardedPoints,
    errorMessage: (errorMessage != null) ? errorMessage() : this.errorMessage,
  );

  @override
  List<Object?> get props => [
    bannerAd,
    interstitialAd,
    rewardedAd,
    isLoading,
    rewardedPoints,
    errorMessage,
  ];
}
