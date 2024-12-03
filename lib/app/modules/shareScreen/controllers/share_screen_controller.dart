import 'dart:io';

import 'package:flutter_social_share_plugin/flutter_social_share.dart';
import 'package:get/get.dart';
import 'package:love_shayri/constants/stringConstants.dart';

class ShareScreenController extends GetxController {
  File? shareFile;
  final FlutterSocialShare flutterShareMe = FlutterSocialShare();
  @override
  void onInit() {
    if (Get.arguments != null) {
      shareFile = Get.arguments[ArgumentConstants.imagePath];
      print(shareFile);
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
