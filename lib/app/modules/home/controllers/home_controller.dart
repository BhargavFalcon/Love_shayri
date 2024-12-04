import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:love_shayri/constants/sizeConstant.dart';
import 'package:love_shayri/constants/stringConstants.dart';
import 'package:love_shayri/main.dart';
import 'package:love_shayri/models/shayariMiodel.dart';
import 'package:love_shayri/service/dbManager.dart';
import '../../../../models/itemModel.dart';

class HomeController extends GetxController {
  RxList<ItemModel> itemList = <ItemModel>[
    ItemModel(title: "All In One", image: ImageConstant.allInOne, size: 376),
    ItemModel(title: "Attitude", image: ImageConstant.attitude, size: 211),
    ItemModel(title: "2 Lines", image: ImageConstant.twoLines, size: 440),
    ItemModel(title: "Best Wishes", image: ImageConstant.bestWishes, size: 48),
    ItemModel(title: "Bewafa", image: ImageConstant.bewafa, size: 185),
    ItemModel(title: "Birthday", image: ImageConstant.birthday, size: 198),
    ItemModel(title: "Christmas", image: ImageConstant.christmas, size: 40),
    ItemModel(title: "Diwali", image: ImageConstant.diwali, size: 94),
    ItemModel(title: "Friend", image: ImageConstant.friend, size: 603),
    ItemModel(title: "Funny", image: ImageConstant.funny, size: 347),
    ItemModel(title: "Ganesha", image: ImageConstant.ganesha, size: 50),
    ItemModel(title: "God", image: ImageConstant.god, size: 40),
    ItemModel(title: "Holi", image: ImageConstant.holi, size: 61),
    ItemModel(
        title: "Independence", image: ImageConstant.independence, size: 46),
    ItemModel(title: "Janmashtami", image: ImageConstant.janmashtami, size: 51),
    ItemModel(title: "Sankranti", image: ImageConstant.sankranti, size: 25),
    ItemModel(title: "Love", image: ImageConstant.love, size: 658),
    ItemModel(title: "Morning", image: ImageConstant.morning, size: 404),
    ItemModel(title: "Navratri", image: ImageConstant.navratri, size: 44),
    ItemModel(title: "New Year", image: ImageConstant.newYear, size: 40),
    ItemModel(title: "Night", image: ImageConstant.night, size: 397),
    ItemModel(title: "Other", image: ImageConstant.other, size: 20),
    ItemModel(title: "Republic", image: ImageConstant.republic, size: 39),
    ItemModel(title: "Romantic", image: ImageConstant.romantic, size: 362),
    ItemModel(title: "Royal", image: ImageConstant.royal, size: 150),
    ItemModel(title: "Sad", image: ImageConstant.sad, size: 442),
    ItemModel(title: "Valentine", image: ImageConstant.valentine, size: 303),
    ItemModel(title: "Yaad", image: ImageConstant.yaad, size: 66),
  ].obs;
  RxList<ItemModel> dummyItemList = <ItemModel>[].obs;
  TextEditingController searchController = TextEditingController();
  @override
  void onInit() {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        if (isNullEmptyOrFalse(box.read(PrefConstant.year))) {
          box.write(PrefConstant.year, DateTime.now().year);
          box.write(PrefConstant.month, DateTime.now().month);
          box.write(PrefConstant.day, DateTime.now().day);
        }
        dummyItemList.addAll(itemList);
        await scheduleShayariNotifications();
      },
    );
    super.onInit();
  }

  onSearch(String value) {
    if (value.isEmpty) {
      itemList.clear();
      itemList.value = List.from(dummyItemList);
    } else {
      itemList.value = dummyItemList
          .where((element) =>
              element.title!.toLowerCase().contains(value.toLowerCase()))
          .toList();
    }
  }

  Future<void> scheduleShayariNotifications() async {
    if (box.read(PrefConstant.isNotificationOn) ?? false) {
      int page = box.read(PrefConstant.notificationPage) ?? 1;
      int pageSize = 50;
      int offset = (page - 1) * pageSize;
      await DatabaseHelper.instance.initDatabase();

      List<Map<String, dynamic>> value = await DatabaseHelper.instance.rawQuery(
          "SELECT * FROM myShayari ORDER BY shayari_id ASC LIMIT $pageSize OFFSET $offset");

      box.write(PrefConstant.notificationPage, page + 1);
      List<shayariModel> shayariList =
          value.map((e) => shayariModel.fromJson(e)).toList();
      shayariList.shuffle();

      int mid = shayariList.length ~/ 2;
      List<shayariModel> morningShayari = shayariList.take(mid).toList();
      List<shayariModel> nightShayari = shayariList.skip(mid).toList();

      for (int i = 0; i < morningShayari.length; i++) {
        shayariModel shayarimodel = morningShayari[i];
        service.showScheduledNotification(
          id: i,
          title: "Good Morning Shayari",
          body: shayarimodel.shayariText!,
          hours: 7,
          year: box.read(PrefConstant.year),
          month: box.read(PrefConstant.month),
          day: box.read(PrefConstant.day),
        );
      }

      for (int i = 0; i < nightShayari.length; i++) {
        shayariModel shayarimodel = nightShayari[i];
        service.showScheduledNotification(
          id: i + morningShayari.length,
          title: "Good Night Shayari",
          body: shayarimodel.shayariText!,
          hours: 19,
          year: box.read(PrefConstant.year),
          month: box.read(PrefConstant.month),
          day: box.read(PrefConstant.day),
        );
      }

      int year = box.read(PrefConstant.year) ?? 0;
      int month = box.read(PrefConstant.month) ?? 1;
      int day = box.read(PrefConstant.day) ?? 1;
      String formattedMonth = month.toString().padLeft(2, '0');
      String formattedDay = day.toString().padLeft(2, '0');
      String formattedDateString = "$year-$formattedMonth-$formattedDay";
      DateTime date = DateTime.parse(formattedDateString);
      date = date.add(Duration(days: 1));
      box.write(PrefConstant.year, date.year);
      box.write(PrefConstant.month, date.month);
      box.write(PrefConstant.day, date.day);
    }
  }
}
