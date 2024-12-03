import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:love_shayri/constants/stringConstants.dart';
import 'package:love_shayri/service/ThemeService.dart';
import 'package:provider/provider.dart';

class CreatePostScreenController extends GetxController {
  RxString text = "".obs;
  bool isDarkMode = Get.context!.watch<ModelTheme>().isDark;
  Rx<Color> baseColor = Colors.transparent.obs;
  Rx<Color>? textColors;
  RxInt textSize = 14.obs;
  RxBool isEditByAi = false.obs;
  @override
  void onInit() {
    if (Get.arguments != null) {
      text.value = Get.arguments[ArgumentConstants.shayariText];
    }
    textColors?.value = isDarkMode ? Colors.white : Colors.black;
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
