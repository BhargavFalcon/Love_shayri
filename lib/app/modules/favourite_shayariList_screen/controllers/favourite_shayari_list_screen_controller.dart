import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:love_shayri/models/shayariMiodel.dart';
import 'package:love_shayri/service/dbManager.dart';

class FavouriteShayariListScreenController extends GetxController {
  RxList<shayariModel> shayariList = <shayariModel>[].obs;
  RxList<shayariModel> dummyShayariList = <shayariModel>[].obs;
  TextEditingController searchController = TextEditingController();
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
      await DatabaseHelper.instance.initDatabase();
      DatabaseHelper.instance
          .rawQuery("SELECT * FROM myShayari WHERE favourite = '1'")
          .then((value) {
        shayariList.value = value.map((e) => shayariModel.fromJson(e)).toList();
        dummyShayariList.addAll(shayariList);
      });
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
