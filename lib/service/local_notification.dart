import 'dart:convert';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:love_shayri/app/routes/app_pages.dart';
import 'package:love_shayri/models/shayariMiodel.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

@pragma('vm:entry-point') // Ensure this is accessible as an entry point
void onBackgroundNotificationResponse(NotificationResponse details) {
  Get.offAllNamed(Routes.HOME);
}

class LocalNotificationService {
  LocalNotificationService();

  final _localNotificationService = FlutterLocalNotificationsPlugin();

  Future<void> intialize() async {
    tz.initializeTimeZones();
    const AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings('@drawable/notification_icon');

    DarwinInitializationSettings iosInitializationSettings =
        DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    final InitializationSettings settings = InitializationSettings(
      android: androidInitializationSettings,
      iOS: iosInitializationSettings,
    );

    await _localNotificationService.initialize(
      settings,
      onDidReceiveBackgroundNotificationResponse:
          onBackgroundNotificationResponse,
      onDidReceiveNotificationResponse: (details) {
        print("onDidReceiveNotificationResponse");
        print(details.payload.runtimeType);
        try {
          String input = details.payload!;
          print("Input: $input");
          Map<String, dynamic> payload = jsonDecode(input);
          print("Payload: $payload");
        } catch (e) {
          print("Erasdasdror: $e");
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

  tz.TZDateTime _nextInstanceOfTime(
      {required int year,
      required int month,
      required int day,
      required int hour,
      required int minute}) {
    tz.TZDateTime scheduledDate =
        tz.TZDateTime(tz.local, year, month, day, hour, minute);
    tz.TZDateTime now = tz.TZDateTime.now(tz.local);

    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(Duration(days: 1));
    }
    print(scheduledDate);
    return scheduledDate;
  }

  Future<void> showScheduledNotification(
      {required int id,
      required String title,
      required String body,
      required shayariModel shayariModel,
      required int year,
      required int month,
      required int day,
      required int hours}) async {
    final details = await _notificationDetails();
    await _localNotificationService.zonedSchedule(
      id,
      title,
      body,
      payload: jsonEncode(shayariModel.toJson()),
      _nextInstanceOfTime(
          year: year, month: month, day: day, hour: hours, minute: 0),
      details,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      androidScheduleMode: AndroidScheduleMode.inexact,
    );
  }

  Future<void> shownNotification({
    required int id,
    required String title,
    required String body,
  }) async {
    final details = await _notificationDetails();
    try {
      await _localNotificationService
          .show(
        id,
        title,
        body,
        details,
      )
          .then((value) {
        print("Notification shown");
      });
    } catch (e) {
      print("Error=====: $e");
    }
  }

  void onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payload) {
    print('id $id');
  }

  cancelNotification() async {
    await _localNotificationService.cancelAll();
  }
}
