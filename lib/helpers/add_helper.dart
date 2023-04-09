
import 'constants.dart';

class AdHelper {

  static String get bannerAdUnitId {
    // if (Platform.isAndroid) {
      return bannerHomeId;
    // } else if (Platform.isIOS) {
    //   return '<YOUR_IOS_BANNER_AD_UNIT_ID>';
    // } else {
    //   throw UnsupportedError('Unsupported platform');
    // }
  }

  static String get interstitialAdUnitId {

    return pageAddId;
    // if (Platform.isAndroid) {
    //   return '<YOUR_ANDROID_INTERSTITIAL_AD_UNIT_ID>';
    // } else if (Platform.isIOS) {
    //   return '<YOUR_IOS_INTERSTITIAL_AD_UNIT_ID>';
    // } else {
    //   throw UnsupportedError('Unsupported platform');
    // }
  }

  static String get rewardedAdUnitId {
    return pageAddId;
  }
}