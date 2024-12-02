import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:love_shayri/constants/stringConstants.dart';
import 'package:love_shayri/models/shayariMiodel.dart';
import 'package:love_shayri/service/dbManager.dart';

class QuoteDetailController extends GetxController
    with GetSingleTickerProviderStateMixin {
  RxList<shayariModel> shayariList = <shayariModel>[].obs;
  Rx<shayariModel> shayarimodel = shayariModel().obs;
  late AnimationController animationController;
  late Animation<double> opacityAnimation;
  late Animation<Offset> positionAnimation;
  RxBool isShow = false.obs;
  RxString shayariCate = "".obs;
  RxInt currentIndex = 0.obs;
  RxBool showToaster = false.obs;
  RxString toasterMessage = "".obs;
  @override
  void onInit() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (Get.arguments != null) {
        shayariCate.value = Get.arguments[ArgumentConstants.shayariCate];
        shayariList.value =
            RxList(Get.arguments[ArgumentConstants.shayariList] ?? []);
        currentIndex.value = Get.arguments[ArgumentConstants.shayariIndex] ?? 0;
      }
      animationController = AnimationController(
        duration: const Duration(milliseconds: 300),
        vsync: this,
      );

      opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: animationController, curve: Curves.easeInOut),
      );

      positionAnimation =
          Tween<Offset>(begin: Offset(0, 0.05), end: Offset(0, 0.0)).animate(
        CurvedAnimation(parent: animationController, curve: Curves.easeInOut),
      );
      isShow.value = true;
      print(isShow);
      shayarimodel.value = shayariList[currentIndex.value];
      animationController.forward();
      update();
    });
    super.onInit();
  }

  favoriteQuote() {
    if (shayarimodel.value.favourite == "1") {
      shayarimodel.value.favourite = "0";
    } else {
      shayarimodel.value.favourite = "1";
    }
    String updateStr =
        "UPDATE myShayari SET favourite = '${shayarimodel.value.favourite}' WHERE shayari_id = '${shayarimodel.value.shayariId}'";
    DatabaseHelper.instance.rawQuery(updateStr).then(
      (value) {
        showToasterMessage(shayarimodel.value.favourite == "1"
            ? "Added to favourite"
            : "Removed from favourite");
      },
    );
    update();
  }

  void startAnimation() {
    animationController.forward(from: 0.0);
  }

  @override
  void onClose() {
    animationController.dispose();
    super.onClose();
  }

  nextQuote() {
    if (currentIndex.value < shayariList.length - 1) {
      currentIndex.value++;
    } else {
      currentIndex.value = 0;
    }
    shayarimodel.value = shayariList[currentIndex.value];
    startAnimation();
  }

  prevQuote() {
    if (currentIndex.value > 0) {
      currentIndex.value--;
    } else {
      currentIndex.value = shayariList.length - 1;
    }
    shayarimodel.value = shayariList[currentIndex.value];
    startAnimation();
  }

  showToasterMessage(String message) {
    showToaster.value = true;
    toasterMessage.value = message;
    Future.delayed(Duration(seconds: 3), () {
      showToaster.value = false;
    });
  }
}
