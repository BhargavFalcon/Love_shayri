import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:love_shayri/Widget/assetImageWidget.dart';
import 'package:love_shayri/Widget/backgoundImageWidget.dart';
import 'package:love_shayri/Widget/textCommanWidget.dart';
import 'package:love_shayri/constants/sizeConstant.dart';
import 'package:love_shayri/constants/stringConstants.dart';
import 'package:love_shayri/service/ThemeService.dart';
import 'package:provider/provider.dart';
import '../controllers/about_app_controller.dart';

class AboutAppView extends GetView<AboutAppController> {
  const AboutAppView({super.key});
  @override
  Widget build(BuildContext context) {
    bool isDarkMode = context.watch<ModelTheme>().isDark;
    return Scaffold(
      body: BackGroundWidget(
        title: "About Us",
        leading: InkWell(
            onTap: () {
              Get.back();
            },
            child: Image.asset(
              isDarkMode
                  ? ImageConstant.arrowBackLight
                  : ImageConstant.arrowBackDark,
            )),
        child: Padding(
          padding: Spacing.symmetric(horizontal: 75),
          child: Column(
            children: [
              Spacing.height(118),
              Image.asset(
                ImageConstant.appIcon,
                height: 100,
                width: 100,
              ),
              Spacing.height(20),
              TextView(
                text: (Platform.isIOS)
                    ? "V ${controller.appVersionName.value}"
                    : "V ${controller.appVersionName.value}(${controller.appVersionCode.value})",
                fontSize: 19,
                fontWeight: FontWeight.bold,
              ),
              Spacing.height(20),
              TextView(
                text:
                    "© ${DateTime.now().year} Falcon Solutions \n All Rights Reserved",
                fontSize: 20,
                textAlign: TextAlign.center,
                fontWeight: FontWeight.bold,
              ),
              Spacing.height(20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                    onTap: () {
                      Uri uri = Uri.parse(
                          "https://www.facebook.com/falconsolutions/");
                      urlLauncher(url: uri, name: "Facebook");
                    },
                    child: AssetImageWidget(
                      lightImagePath: ImageConstant.fbLight,
                      darkImagePath: ImageConstant.fbDark,
                      width: 50,
                      height: 50,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Uri uri = Uri.parse(
                          "https://www.linkedin.com/company/falcon-solutions-m-s");
                      urlLauncher(url: uri, name: "Linkedin");
                    },
                    child: AssetImageWidget(
                      lightImagePath: ImageConstant.linkedinLight,
                      darkImagePath: ImageConstant.linkedinDark,
                      width: 50,
                      height: 50,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Uri uri = Uri.parse("https://twitter.com/FalconSolCo");
                      urlLauncher(url: uri, name: "Twitter");
                    },
                    child: AssetImageWidget(
                      lightImagePath: ImageConstant.xLight,
                      darkImagePath: ImageConstant.xDark,
                      width: 50,
                      height: 50,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Uri uri = Uri.parse(
                          "https://www.instagram.com/falconsolutionsco/");
                      urlLauncher(url: uri, name: "Instagram");
                    },
                    child: AssetImageWidget(
                      lightImagePath: ImageConstant.instagramLight,
                      darkImagePath: ImageConstant.instagramDark,
                      width: 50,
                      height: 50,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
