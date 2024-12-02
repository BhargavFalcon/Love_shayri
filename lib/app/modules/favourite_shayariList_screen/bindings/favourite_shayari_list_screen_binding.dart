import 'package:get/get.dart';

import '../controllers/favourite_shayari_list_screen_controller.dart';

class FavouriteShayariListScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FavouriteShayariListScreenController>(
      () => FavouriteShayariListScreenController(),
    );
  }
}
