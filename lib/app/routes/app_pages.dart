import 'package:get/get.dart';

import '../modules/createPostScreen/bindings/create_post_screen_binding.dart';
import '../modules/createPostScreen/views/create_post_screen_view.dart';
import '../modules/favourite_shayariList_screen/bindings/favourite_shayari_list_screen_binding.dart';
import '../modules/favourite_shayariList_screen/views/favourite_shayari_list_screen_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/quoteDetail/bindings/quote_detail_binding.dart';
import '../modules/quoteDetail/views/quote_detail_view.dart';
import '../modules/shayriList_screen/bindings/shayri_list_screen_binding.dart';
import '../modules/shayriList_screen/views/shayri_list_screen_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.SHAYRI_LIST_SCREEN,
      page: () => const ShayriListScreenView(),
      binding: ShayriListScreenBinding(),
    ),
    GetPage(
      name: _Paths.QUOTE_DETAIL,
      page: () => const QuoteDetailView(),
      binding: QuoteDetailBinding(),
    ),
    GetPage(
      name: _Paths.CREATE_POST_SCREEN,
      page: () => const CreatePostScreenView(),
      binding: CreatePostScreenBinding(),
    ),
    GetPage(
      name: _Paths.FAVOURITE_SHAYARI_LIST_SCREEN,
      page: () => const FavouriteShayariListScreenView(),
      binding: FavouriteShayariListScreenBinding(),
    ),
  ];
}
