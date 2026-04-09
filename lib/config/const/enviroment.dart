import 'package:flutter_dotenv/flutter_dotenv.dart';

class Enviroment {
  static Future<void> initEnviroment() async {
    await dotenv.load(fileName: '.env');
  }

  static final String pokeApi =
      dotenv.env['POKE_API'] ??
      (throw AssertionError('POKE_API not found in .env files'));

  static final String imagePokeMonBaseUrl =
      dotenv.env['IMAGE_BASE_URL'] ??
      (throw AssertionError('IMAGE_BASE_URL not found in .env files'));

  static final String appWebUrl =
      dotenv.env['APP_WEB_URL'] ??
      (throw AssertionError('APP_WEB_URL not found in .env files'));

  static final String adBannerIdAndroid =
      dotenv.env['AD_BANNER_ID_ANDROID'] ??
      (throw AssertionError('AD_BANNER_ID_ANDROID not found in .env files'));

  static final String adBannerIdIOs =
      dotenv.env['AD_BANNER_ID_IOS'] ??
      (throw AssertionError('AD_BANNER_ID_IOS not found in .env files'));

  static final String adInterstitialIdAndroid =
      dotenv.env['AD_INTERSTITIAL_ID_ANDROID'] ??
      (throw AssertionError(
        'AD_INTERSTITIAL_ID_ANDROID not found in .env files',
      ));

  static final String adInterstitialIdIOs =
      dotenv.env['AD_INTERSTITIAL_ID_IOS'] ??
      (throw AssertionError('AD_INTERSTITIAL_ID_IOS not found in .env files'));

  static final String adRewardedIdAndroid =
      dotenv.env['AD_REWARDED_ID_ANDROID'] ??
      (throw AssertionError('AD_REWARDED_ID_ANDROID not found in .env files'));

  static final String adRewardedIdIOs =
      dotenv.env['AD_REWARDED_ID_IOS'] ??
      (throw AssertionError('AD_REWARDED_ID_IOS not found in .env files'));
}
