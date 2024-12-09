import 'dart:convert';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:love_shayri/app/modules/quoteDetail/controllers/quote_detail_controller.dart';
import 'package:love_shayri/app/routes/app_pages.dart';
import 'package:love_shayri/constants/stringConstants.dart';
import 'package:love_shayri/models/shayariMiodel.dart';
import 'package:love_shayri/service/dbManager.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

@pragma('vm:entry-point') // Ensure this is accessible as an entry point
void onBackgroundNotificationResponse(NotificationResponse details) {
  try {
    final payload = details.payload;
    if (payload != null) {
      shayariModel shayrimodel =
          shayariModel.fromJson(Map<String, dynamic>.from(jsonDecode(payload)));
      Get.offAllNamed(Routes.HOME);
      Get.toNamed(Routes.QUOTE_DETAIL, arguments: {
        ArgumentConstants.shayariModel: shayrimodel,
      });
    }
  } catch (e) {
    print("Error in onBackgroundNotificationResponse: $e");
  }
}

class LocalNotificationService {
  LocalNotificationService();

  final _localNotificationService = FlutterLocalNotificationsPlugin();

  Future<void> initialize() async {
    tz.initializeTimeZones();
    const AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings('@drawable/notification_icon');

    const DarwinInitializationSettings iosInitializationSettings =
        DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const InitializationSettings settings = InitializationSettings(
      android: androidInitializationSettings,
      iOS: iosInitializationSettings,
    );

    await _localNotificationService.initialize(
      settings,
      onDidReceiveBackgroundNotificationResponse:
          onBackgroundNotificationResponse,
      onDidReceiveNotificationResponse: (details) async {
        try {
          final payload = details.payload;
          if (payload != null) {
            shayariModel shayrimodel =
                shayariModel.fromJson(jsonDecode(payload));

            if (Get.isRegistered<QuoteDetailController>()) {
              final quoteDetailController = Get.find<QuoteDetailController>();
              await DatabaseHelper.instance.initDatabase();
              DatabaseHelper.instance
                  .rawQuery(
                      "SELECT * FROM myShayari WHERE shayari_cate = '${shayrimodel.shayariCate}'")
                  .then((value) {
                quoteDetailController.shayariList.value =
                    value.map((e) => shayariModel.fromJson(e)).toList();
              });
              quoteDetailController.shayariList.forEach((element) {
                if (element.shayariId == shayrimodel.shayariId) {
                  quoteDetailController.currentIndex.value =
                      quoteDetailController.shayariList.indexOf(element);
                }
              });
              quoteDetailController.shayarimodel.value = shayrimodel;
              quoteDetailController.update();
            } else {
              Get.toNamed(Routes.QUOTE_DETAIL, arguments: {
                ArgumentConstants.shayariModel: shayrimodel,
              });
            }
          }
        } catch (e) {
          print("Error in onDidReceiveNotificationResponse: $e");
        }
      },
    );

    _localNotificationService
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
  }

  Future<NotificationDetails> _notificationDetails() async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      'channel_id',
      'channel_name',
      channelDescription: 'description',
      importance: Importance.max,
      priority: Priority.max,
      playSound: true,
    );

    const DarwinNotificationDetails iosNotificationDetails =
        DarwinNotificationDetails();

    return const NotificationDetails(
      android: androidNotificationDetails,
      iOS: iosNotificationDetails,
    );
  }

  tz.TZDateTime _nextInstanceOfTime({
    required int year,
    required int month,
    required int day,
    required int hour,
    required int minute,
  }) {
    tz.TZDateTime scheduledDate =
        tz.TZDateTime(tz.local, year, month, day, hour, minute);
    tz.TZDateTime now = tz.TZDateTime.now(tz.local);

    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(Duration(days: 1));
    }
    print(scheduledDate);
    return scheduledDate;
  }

  Future<void> showScheduledNotification({
    required int id,
    required String title,
    required String body,
    required shayariModel shayariModel,
    required int year,
    required int month,
    required int day,
    required int hours,
  }) async {
    final details = await _notificationDetails();
    try {
      await _localNotificationService.zonedSchedule(
        id,
        title,
        body,
        _nextInstanceOfTime(
          year: year,
          month: month,
          day: day,
          hour: hours,
          minute: 0,
        ),
        details,
        payload: jsonEncode(shayariModel.toJson()),
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        androidScheduleMode: AndroidScheduleMode.inexact,
      );
    } catch (e) {
      print("Error scheduling notification: $e");
    }
  }

  Future<void> shownNotification({
    required int id,
    required String title,
    required String body,
    required shayariModel shayariModel,
  }) async {
    final details = await _notificationDetails();
    try {
      await _localNotificationService.show(
        id,
        title,
        body,
        details,
        payload: jsonEncode(shayariModel.toJson()),
      );
    } catch (e) {
      print("Error showing notification: $e");
    }
  }

  Future<void> cancelNotification() async {
    await _localNotificationService.cancelAll();
  }
}
