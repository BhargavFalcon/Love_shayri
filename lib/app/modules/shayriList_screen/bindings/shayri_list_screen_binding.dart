import 'package:get/get.dart';

import '../controllers/shayri_list_screen_controller.dart';

class ShayriListScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ShayriListScreenController>(
      () => ShayriListScreenController(),
    );
  }
}
