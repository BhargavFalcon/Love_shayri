import 'package:get/get.dart';
import 'package:love_shayri/constants/stringConstants.dart';

class CreatePostScreenController extends GetxController {
  RxString text = "".obs;
  @override
  void onInit() {
    if (Get.arguments != null) {
      text.value = Get.arguments[ArgumentConstants.shayariText];
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
