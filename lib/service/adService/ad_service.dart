import 'dart:io';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:gma_mediation_applovin/applovin_mediation_extras.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:love_shayri/constants/sizeConstant.dart';

import '../../constants/stringConstants.dart';
import '../../main.dart';

class AdService {
  RxInt adCount = (!isNullEmptyOrFalse(box.read(PrefConstant.adCount)))
      ? (box.read(PrefConstant.adCount) as int).obs
      : 0.obs;
  InterstitialAd? interstitialAds;
  void showInterstitialAd({VoidCallback? onAdDismissed}) {
    interstitialAds?.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (ad) =>
          print('Ad showed fullscreen content.'),
      onAdDismissedFullScreenContent: (ad) {
        onAdDismissed?.call();
        SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
            overlays: SystemUiOverlay.values);
        interstitialAds?.dispose();
        loadInterstitialAd();
        print('Ad dismissed fullscreen content.');
      },
      onAdFailedToShowFullScreenContent: (ad, error) {
        print('Ad failed to show fullscreen content: $error');
      },
    );
    if (box.read(PrefConstant.isAdRemoved) ?? false) {
      onAdDismissed?.call();
      return;
    }
    adCount.value++;
    box.write(PrefConstant.adCount, adCount.value);
    if (adCount.value == 5) {
      adCount.value = 0;
      box.write(PrefConstant.adCount, adCount.value);
      interstitialAds?.show().then((value) =>
          SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
              overlays: []));
    } else {
      onAdDismissed?.call();
    }
    if (interstitialAds == null) {
      loadInterstitialAd();
      onAdDismissed?.call();
    }
  }

  AppLovinMediationExtras applovinExtras =
      AppLovinMediationExtras(isMuted: true);
  loadInterstitialAd() {
    InterstitialAd.load(
      adUnitId: PrefConstant.interAdId,
      request: AdRequest(
        mediationExtras: (Platform.isIOS) ? [applovinExtras] : null,
      ),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          interstitialAds = ad;
          print("InterstitialAd loaded.");
        },
        onAdFailedToLoad: (error) {
          print('InterstitialAd failed to load: $error');
          Future.delayed(Duration(seconds: 5), () {
            loadInterstitialAd();
          });
        },
      ),
    );
  }
}
