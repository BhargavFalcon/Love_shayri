import 'package:get/get.dart';

import '../controllers/quote_detail_controller.dart';

class QuoteDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<QuoteDetailController>(
      () => QuoteDetailController(),
    );
  }
}
