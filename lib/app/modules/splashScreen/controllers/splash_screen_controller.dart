import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:love_shayri/app/routes/app_pages.dart';
import 'package:love_shayri/constants/sizeConstant.dart';
import 'package:love_shayri/constants/stringConstants.dart';
import 'package:love_shayri/main.dart';
import 'package:love_shayri/service/inAppPurchase.dart';

class SplashScreenController extends GetxController {
  @override
  void onInit() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      InAppPurchaseClass.getInstance.initInAppPurchase();
      InAppPurchaseClass.getInstance.initListen();
      if ((box.read(PrefConstant.isAdRemoved) ?? false) == false) {
        adService.loadInterstitialAd();
      }
      if (isNullEmptyOrFalse(box.read(PrefConstant.isNotificationOn))) {
        box.write(PrefConstant.isNotificationOn, false);
      }
      Future.delayed(Duration(seconds: 2), () {
        Get.offAllNamed(Routes.HOME);
      });
    });
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
