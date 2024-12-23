import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:gdpr_dialog_flutter/gdpr_dialog_flutter.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gma_mediation_applovin/gma_mediation_applovin.dart';
import 'package:gma_mediation_unity/gma_mediation_unity.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:love_shayri/service/ThemeService.dart';
import 'package:love_shayri/service/adService/ad_service.dart';
import 'package:love_shayri/service/local_notification.dart';
import 'package:provider/provider.dart';

import 'app/routes/app_pages.dart';
import 'constants/app_module.dart';

final getIt = GetIt.instance;
GetStorage box = GetStorage();
AdService adService = AdService();
late final LocalNotificationService service;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GdprDialogFlutter.instance
      .showDialog(isForTest: false, testDeviceId: '')
      .then((onValue) {
    print('result === $onValue');
  });
  await MobileAds.instance.initialize();
  await MobileAds.instance
      .updateRequestConfiguration(RequestConfiguration(testDeviceIds: [""]));
  if (Platform.isIOS) {
    GmaMediationApplovin().setHasUserConsent(true);
    GmaMediationApplovin().setIsAgeRestrictedUser(true);
    GmaMediationUnity().setGDPRConsent(true);
    GmaMediationUnity().setCCPAConsent(true);
  }
  await GetStorage.init();
  service = await LocalNotificationService();
  service.initialize();
  requestPermissions();
  setUp();
  runApp(
    ChangeNotifierProvider(
      create: (BuildContext context) => ModelTheme(),
      child: GetMaterialApp(
        title: "Application",
        initialRoute: AppPages.INITIAL,
        getPages: AppPages.routes,
        theme: ThemeData(
          fontFamily: GoogleFonts.roboto().fontFamily,
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.transparent,
            scrolledUnderElevation: 0,
            elevation: 0,
          ),
        ),
      ),
    ),
  );
}

void requestPermissions() {
  FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  notificationsPlugin
      .resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin>()
      ?.requestPermissions(alert: true, badge: true, sound: true);
}
