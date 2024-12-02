import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:love_shayri/constants/stringConstants.dart';
import 'package:love_shayri/models/shayariMiodel.dart';
import 'package:love_shayri/service/dbManager.dart';

class ShayriListScreenController extends GetxController {
  RxList<shayariModel> shayariList = <shayariModel>[].obs;
  RxList<shayariModel> dummyShayariList = <shayariModel>[].obs;
  TextEditingController searchController = TextEditingController();
  RxString shayariCate = "".obs;
  final List<String> colorCodes = [
    "D31E28",
    "3A399B",
    "8626C7",
    "EC523E",
    "32CEE3"
  ];

  @override
  void onInit() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      if (Get.arguments != null) {
        shayariCate.value = Get.arguments[ArgumentConstants.shayariCate];
      }
      await DatabaseHelper.instance.initDatabase();
      if (shayariCate.value == "All In One" ||
          shayariCate.value == "Best Wishes") {
        DatabaseHelper.instance
            .rawQuery(
                "SELECT * FROM myShayari WHERE shayari_cate = '${shayariCate.value}'")
            .then((value) {
          shayariList.value =
              value.map((e) => shayariModel.fromJson(e)).toList();
          dummyShayariList.addAll(shayariList);
        });
      } else if (shayariCate.value == "Valentine") {
        DatabaseHelper.instance
            .rawQuery(
                "SELECT * FROM myShayari WHERE shayari_cate = '${shayariCate.value} All Shayari'")
            .then((value) {
          shayariList.value =
              value.map((e) => shayariModel.fromJson(e)).toList();
          dummyShayariList.addAll(shayariList);
        });
      } else {
        DatabaseHelper.instance
            .rawQuery(
                "SELECT * FROM myShayari WHERE shayari_cate = '${shayariCate.value} Shayari'")
            .then((value) {
          shayariList.value =
              value.map((e) => shayariModel.fromJson(e)).toList();
          dummyShayariList.addAll(shayariList);
        });
      }
    });
    super.onInit();
  }

  String getRandomColor(List<String> colorCodes) {
    final random = Random();
    final randomIndex = random.nextInt(colorCodes.length);
    return colorCodes[randomIndex];
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  onSearch(String value) {
    if (value.isEmpty) {
      shayariList.clear();
      shayariList.value = List.from(dummyShayariList);
    } else {
      shayariList.value = dummyShayariList
          .where((element) =>
              element.shayariText!.toLowerCase().contains(value.toLowerCase()))
          .toList();
    }
  }
}
