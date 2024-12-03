import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:love_shayri/constants/stringConstants.dart';
import 'package:love_shayri/models/shayariMiodel.dart';

class CreatePostScreenController extends GetxController {
  Rx<shayariModel> shayarimodel = shayariModel().obs;
  RxBool isEditByAi = false.obs;
  RxDouble fontSize = 16.0.obs;
  Rx<Color>? textColor;
  Rx<Color>? backgroundColor;
  Rx<Offset> offset = Offset(0, 0).obs;
  RxBool isTextSizeVisible = false.obs;
  RxString filePath = "".obs;
  RxBool baseColorAlertVisible = false.obs;
  final GlobalKey screenshotKey = GlobalKey();
  RxBool isCaptureScreenShot = false.obs;
  @override
  void onInit() {
    if (Get.arguments != null) {
      shayarimodel.value = Get.arguments[ArgumentConstants.shayariModel];
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
