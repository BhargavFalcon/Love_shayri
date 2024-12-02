import 'package:get/get.dart';

import '../controllers/create_post_screen_controller.dart';

class CreatePostScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreatePostScreenController>(
      () => CreatePostScreenController(),
    );
  }
}
