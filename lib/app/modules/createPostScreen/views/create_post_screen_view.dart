import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:love_shayri/Widget/backgoundImageWidget.dart';
import 'package:love_shayri/constants/stringConstants.dart';
import 'package:love_shayri/service/ThemeService.dart';
import 'package:provider/provider.dart';

import '../controllers/create_post_screen_controller.dart';

class CreatePostScreenView extends GetWidget<CreatePostScreenController> {
  const CreatePostScreenView({super.key});
  @override
  Widget build(BuildContext context) {
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
            children: [],
          )),
    );
  }
}
