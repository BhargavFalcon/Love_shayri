import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:love_shayri/app/modules/favourite_shayariList_screen/controllers/favourite_shayari_list_screen_controller.dart';
import 'package:love_shayri/constants/stringConstants.dart';
import 'package:love_shayri/models/shayariMiodel.dart';
import 'package:love_shayri/service/dbManager.dart';
import 'package:share_plus/share_plus.dart';

class QuoteDetailController extends GetxController
    with GetSingleTickerProviderStateMixin {
  RxList<shayariModel> shayariList = <shayariModel>[].obs;
  Rx<shayariModel> shayarimodel = shayariModel().obs;
  late AnimationController animationController;
  late Animation<double> opacityAnimation;
  late Animation<Offset> positionAnimation;
  RxBool isShow = false.obs;
  RxInt currentIndex = 0.obs;
  RxBool showToaster = false.obs;
  RxString toasterMessage = "".obs;
  @override
  void onInit() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      if (Get.arguments != null) {
        shayarimodel.value = Get.arguments[ArgumentConstants.shayariModel];
      }
      await DatabaseHelper.instance.initDatabase();
      DatabaseHelper.instance
          .rawQuery(
              "SELECT * FROM myShayari WHERE shayari_cate = '${shayarimodel.value.shayariCate}'")
          .then((value) {
        shayariList.value = value.map((e) => shayariModel.fromJson(e)).toList();
      });
      shayariList.forEach((element) {
        if (element.shayariId == shayarimodel.value.shayariId) {
          currentIndex.value = shayariList.indexOf(element);
        }
      });
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
    if (Get.isRegistered<FavouriteShayariListScreenController>()) {
      FavouriteShayariListScreenController controller = Get.find();
      DatabaseHelper.instance
          .rawQuery("SELECT * FROM myShayari WHERE favourite = '1'")
          .then((value) {
        controller.favouriteList.value =
            value.map((e) => shayariModel.fromJson(e)).toList();
        controller.dummyShayariList.addAll(shayariList);
        controller.update();
      });
    }
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

  shareQuote() {
    Share.share("${shayarimodel.value.shayariText}");
  }

  showToasterMessage(String message) {
    showToaster.value = true;
    toasterMessage.value = message;
    Future.delayed(Duration(seconds: 3), () {
      showToaster.value = false;
    });
  }
}
