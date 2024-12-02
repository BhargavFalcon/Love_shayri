import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:love_shayri/Widget/backgoundImageWidget.dart';
import 'package:love_shayri/Widget/textFiledWidget.dart';
import 'package:love_shayri/app/routes/app_pages.dart';
import 'package:love_shayri/constants/sizeConstant.dart';
import 'package:love_shayri/constants/stringConstants.dart';
import 'package:love_shayri/service/ThemeService.dart';
import 'package:provider/provider.dart';

import '../controllers/favourite_shayari_list_screen_controller.dart';

class FavouriteShayariListScreenView
    extends GetWidget<FavouriteShayariListScreenController> {
  const FavouriteShayariListScreenView({super.key});
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      bool isDarkMode = context.watch<ModelTheme>().isDark;
      return Scaffold(
        body: BackGroundWidget(
          title: "Favourite Shayari",
          leading: InkWell(
              onTap: () {
                Get.back();
              },
              child: Image.asset(
                isDarkMode
                    ? ImageConstant.arrowBackLight
                    : ImageConstant.arrowBackDark,
              )),
          child: Column(
            children: [
              Spacing.height(10),
              Padding(
                padding: Spacing.horizontal(16),
                child: Container(
                  height: MySize.getHeight(40),
                  child: TextFiledWidget(
                    hintText: "Search Favorite Shayari",
                    controller: controller.searchController,
                    onChanged: (value) {
                      controller.onSearch(value);
                    },
                  ),
                ),
              ),
              Spacing.height(10),
              (isNullEmptyOrFalse(controller.shayariList))
                  ? Center(
                      child: Text("No Favourite Shayari Found",
                          style: TextStyle(
                            color: isDarkMode ? Colors.white : Colors.black,
                            fontSize: MySize.getHeight(16),
                          )),
                    )
                  : Expanded(
                      child: ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: controller.shayariList.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: InkWell(
                              onTap: () {
                                Get.toNamed(Routes.QUOTE_DETAIL, arguments: {
                                  ArgumentConstants.shayariCate:
                                      controller.shayariList[index].shayariCate,
                                  ArgumentConstants.shayariList:
                                      controller.shayariList,
                                  ArgumentConstants.shayariIndex: index,
                                });
                              },
                              child: Container(
                                margin: Spacing.vertical(8),
                                padding: Spacing.all(16),
                                decoration: BoxDecoration(
                                  color: Color(int.parse(
                                      "0xFF${controller.getRandomColor(controller.colorCodes)}")),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Center(
                                  child: Text(
                                    textAlign: TextAlign.center,
                                    controller.shayariList[index].shayariText!,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: MySize.getHeight(16),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    )
            ],
          ),
        ),
      );
    });
  }
}
