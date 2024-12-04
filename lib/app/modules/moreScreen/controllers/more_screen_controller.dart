import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:love_shayri/constants/stringConstants.dart';
import 'package:love_shayri/main.dart';
import 'package:rate_my_app/rate_my_app.dart';

class MoreScreenController extends GetxController
    with GetSingleTickerProviderStateMixin {
  TabController? tabController;
  List<String> tabList = ['Light Mode', 'Dark Mode'];
  RxBool isQuoteOfTheDay = false.obs;

  RateMyApp rateMyApp = RateMyApp(
    preferencesPrefix: 'rateMyApp_',
    minDays: 7,
    minLaunches: 10,
    remindDays: 7,
    remindLaunches: 10,
    googlePlayIdentifier: 'fr.skyost.example',
    appStoreIdentifier: '1178270657',
  );
  @override
  void onInit() {
    tabController = TabController(length: 2, vsync: this);
    if (tabController != null) {
      bool isDarkMode = box.read(PrefConstant.isDarkTheme) ?? true;
      tabController!.index = isDarkMode ? 1 : 0;
    }
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
