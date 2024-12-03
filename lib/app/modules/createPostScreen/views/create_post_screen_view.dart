import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:love_shayri/Widget/backgoundImageWidget.dart';
import 'package:love_shayri/constants/colorConstant.dart';
import 'package:love_shayri/constants/sizeConstant.dart';
import 'package:love_shayri/constants/stringConstants.dart';
import 'package:love_shayri/service/ThemeService.dart';
import 'package:provider/provider.dart';

import '../controllers/create_post_screen_controller.dart';

class CreatePostScreenView extends GetWidget<CreatePostScreenController> {
  const CreatePostScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      bool isDarkMode = context.watch<ModelTheme>().isDark;
      return Scaffold(
        body: BackGroundWidget(
            title: "Create Post",
            actions: [
              InkWell(
                onTap: () {},
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Share",
                    style: TextStyle(
                        color: isDarkMode ? Colors.white : Colors.black),
                  ),
                ),
              )
            ],
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
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: (controller.isEditByAi.value == true)
                      ? Container(
                          height: MySize.getHeight(450),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(isDarkMode
                                    ? ImageConstant.darkModeBg
                                    : ImageConstant.lightModeBg),
                                fit: BoxFit.cover),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Center(
                            child: Text(
                              controller.text.value,
                              style: TextStyle(
                                  color:
                                      isDarkMode ? Colors.white : Colors.black,
                                  fontSize:
                                      controller.textSize.value.toDouble()),
                            ),
                          ),
                        )
                      : Container(
                          height: MySize.getHeight(450),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: controller.baseColor.value,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Center(
                            child: Text(
                              textAlign: TextAlign.center,
                              controller.text.value,
                              style: TextStyle(
                                  color:
                                      isDarkMode ? Colors.white : Colors.black,
                                  fontSize:
                                      controller.textSize.value.toDouble()),
                            ),
                          ),
                        ),
                ),
                InkWell(
                  onTap: () {
                    if (!isNullEmptyOrFalse(controller.isEditByAi.value)) {
                      controller.isEditByAi.value = false;
                    } else {
                      controller.isEditByAi.value = true;
                    }
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: MySize.getHeight(40),
                    width: MySize.getWidth(200),
                    decoration: BoxDecoration(
                      color:
                          isDarkMode ? Colors.white : ColorConstants.redColor,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Center(
                      child: Text(
                        textAlign: TextAlign.center,
                        (!isNullEmptyOrFalse(controller.isEditByAi.value))
                            ? "Undo"
                            : "Edit Image With AI",
                        style: TextStyle(
                            color: isDarkMode ? Colors.black : Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: MySize.getHeight(16)),
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Image.asset(
                          isDarkMode
                              ? ImageConstant.textColorLight
                              : ImageConstant.textColorDark,
                          height: MySize.getHeight(40),
                        ),
                        Spacing.height(5),
                        Text(
                          "Text Color",
                          style: TextStyle(
                              fontSize: MySize.getHeight(12),
                              color: isDarkMode ? Colors.white : Colors.black),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Image.asset(
                          isDarkMode
                              ? ImageConstant.textSizeLight
                              : ImageConstant.textSizeDark,
                          height: MySize.getHeight(40),
                        ),
                        Spacing.height(5),
                        Text(
                          "Text Size",
                          style: TextStyle(
                              fontSize: MySize.getHeight(12),
                              color: isDarkMode ? Colors.white : Colors.black),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Image.asset(
                          isDarkMode
                              ? ImageConstant.baseColorLight
                              : ImageConstant.baseColorDark,
                          height: MySize.getHeight(40),
                        ),
                        Spacing.height(5),
                        Text(
                          "Base Color",
                          style: TextStyle(
                              fontSize: MySize.getHeight(12),
                              color: isDarkMode ? Colors.white : Colors.black),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Image.asset(
                          isDarkMode
                              ? ImageConstant.bgImageLight
                              : ImageConstant.bgImageDark,
                          height: MySize.getHeight(40),
                        ),
                        Spacing.height(5),
                        Text(
                          "BgImg",
                          style: TextStyle(
                              fontSize: MySize.getHeight(12),
                              color: isDarkMode ? Colors.white : Colors.black),
                        ),
                      ],
                    ),

                  ],
                )
              ],
            )),
      );
    });
  }
}
