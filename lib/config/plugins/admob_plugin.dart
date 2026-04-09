import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:reforzamiento/config/const/enviroment.dart';

final adBannerId = Platform.isAndroid
    ? Enviroment.adBannerIdAndroid
    : Enviroment.adBannerIdIOs;

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
          debugPrint("Ad was loaded. $ad");
          // setState(() {
          //   _bannerAd = ad as BannerAd;
          // });
        },
        onAdFailedToLoad: (ad, err) {
          // Called when an ad request failed.
          debugPrint("Ad failed to load with error: $err");
          ad.dispose();
        },
      ),
    );

    // Iniciat la carga (esto devuelve Future<void>)
    await ad.load();

    // Retorna la instancia del anuncio ya cargándose
    return ad;
  }
}
