import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:reforzamiento/config/const/enviroment.dart';

final adBannerId = Platform.isAndroid
    ? Enviroment.adBannerIdAndroid
    : Enviroment.adBannerIdIOs;

final adInterstitialId = Platform.isAndroid
    ? Enviroment.adInterstitialIdAndroid
    : Enviroment.adInterstitialIdIOs;

final adRewardedId = Platform.isAndroid
    ? Enviroment.adRewardedIdAndroid
    : Enviroment.adRewardedIdIOs;

class AdmobPlugin {
  static Future<void> initialize() async {
    await MobileAds.instance.initialize();
  }

  static Future<BannerAd> loadBannerAd() async {
    final ad = BannerAd(
      adUnitId: adBannerId,
      request: const AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        // Called when an ad is successfully received.
        onAdLoaded: (ad) {
          debugPrint("Banner  Ad was loaded. $ad");
          // setState(() {
          //   _bannerAd = ad as BannerAd;
          // });
        },
        onAdFailedToLoad: (ad, err) {
          // Called when an ad request failed.
          debugPrint("Banner Ad failed to load with error: $err");
          ad.dispose();
        },
      ),
    );

    // Iniciat la carga (esto devuelve Future<void>)
    await ad.load();

    // Retorna la instancia del anuncio ya cargándose
    return ad;
  }

  static Future<InterstitialAd> loadInterstitialAd() async {
    Completer<InterstitialAd> completer = Completer();

    InterstitialAd.load(
      adUnitId: adInterstitialId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          // Called when an ad is successfully received.
          debugPrint('Interstitial Ad was loaded.');
          // Keep a reference to the ad so you can show it later.
          completer.complete(ad);
        },
        onAdFailedToLoad: (LoadAdError error) {
          // Called when an ad request failed.
          debugPrint('Interstitial Ad failed to load with error: $error');
          completer.completeError(error);
        },
      ),
    );

    return completer.future;
  }

  static Future<RewardedAd> loadRewardedAd() async {
    Completer<RewardedAd> completer = Completer();

    RewardedAd.load(
      adUnitId: adRewardedId,
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (RewardedAd ad) {
          // Called when an ad is successfully received.
          debugPrint('Rewarded Ad was loaded.');
          // Keep a reference to the ad so you can show it later.
          completer.complete(ad);
        },
        onAdFailedToLoad: (LoadAdError error) {
          // Called when an ad request failed.
          debugPrint('Rewarded Ad failed to load with error: $error');
          completer.completeError(error);
        },
      ),
    );

    return completer.future;
  }
}
