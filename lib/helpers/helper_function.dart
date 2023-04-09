


import 'package:another_flushbar/flushbar.dart';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:url_launcher/url_launcher.dart';





import 'add_helper.dart';
import 'functions.dart';

class HelperFunction{


  static HelperFunction slt = HelperFunction();

  notifyUser({context, message, color, bool isNeedPop = false}) {
    return  Flushbar(
      padding: const EdgeInsets.all(30),
      flushbarStyle: FlushbarStyle.GROUNDED,
      flushbarPosition: FlushbarPosition.TOP,
      message: message,
      duration: const Duration(seconds: 3),
      backgroundColor: color,
      animationDuration: const Duration(milliseconds: 400),
      leftBarIndicatorColor: color,
    )..show(context).whenComplete(() {
      if (isNeedPop) pop(context);
    });
  }



  showSheet(BuildContext context,child) {
    showModalBottomSheet(
      context: context,
      clipBehavior: Clip.antiAlias,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (BuildContext bc) {
        return child;
      },
    );
  }


  openGoogleMapLocation(lat, lng) async {
    String mapOptions = [
      'saddr=${locData.latitude},${locData.longitude}',
      'daddr=$lat,$lng',
      'dir_action=navigate'
    ].join('&');

    final url = 'https://www.google.com/maps?$mapOptions';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

}
int createUniqueId() {
  return DateTime.now().millisecondsSinceEpoch.remainder(100000);
}

void loadInterstitialAd(onDone,onError) {
  InterstitialAd.load(
    adUnitId: AdHelper.interstitialAdUnitId,
    request: AdRequest(),
    adLoadCallback: InterstitialAdLoadCallback(
      onAdLoaded: (ad) {
        ad.fullScreenContentCallback = FullScreenContentCallback(
          onAdDismissedFullScreenContent: onDone,
        );


      },
      onAdFailedToLoad:onError ,

    ),
  );
}

void getAdds({onAddLoaded}) {
  // TODO: Load a banner ad
  BannerAd(
    adUnitId: AdHelper.bannerAdUnitId,
    request: AdRequest(),
    size: AdSize.banner,
    listener: BannerAdListener(
      onAdLoaded: onAddLoaded,
      onAdFailedToLoad: (ad, err) {
        print('Failed to load a banner ad: ${err.message}');
        ad.dispose();
      },
    ),
  ).load();
}