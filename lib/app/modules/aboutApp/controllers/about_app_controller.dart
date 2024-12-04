import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AboutAppController extends GetxController {
  Rx<PackageInfo>? packageInfo;
  RxString appVersionCode = "".obs;
  RxString appVersionName = "".obs;
  @override
  void onInit() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      packageInfo = Rx(await PackageInfo.fromPlatform());
      appVersionName.value = packageInfo?.value.version ?? "";
      appVersionCode.value = packageInfo?.value.buildNumber ?? "";
      super.onInit();
    });
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
