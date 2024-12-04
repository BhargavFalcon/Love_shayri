import 'package:flutter/services.dart';
import 'package:gma_mediation_applovin/applovin_mediation_extras.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../constants/stringConstants.dart';
import '../../main.dart';

class AdService {
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
    interstitialAds?.show().then((value) =>
        SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []));
  }

  AppLovinMediationExtras applovinExtras =
      AppLovinMediationExtras(isMuted: true);
  loadInterstitialAd() {
    InterstitialAd.load(
      adUnitId: PrefConstant.interAdId,
      request: AdRequest(
        mediationExtras: [applovinExtras],
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
