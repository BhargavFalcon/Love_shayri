import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:love_shayri/Widget/assetImageWidget.dart';
import 'package:love_shayri/Widget/backgoundImageWidget.dart';
import 'package:love_shayri/Widget/textCommanWidget.dart';
import 'package:love_shayri/app/routes/app_pages.dart';
import 'package:love_shayri/constants/sizeConstant.dart';
import 'package:love_shayri/constants/stringConstants.dart';
import 'package:love_shayri/service/ThemeService.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

import '../controllers/more_screen_controller.dart';

class MoreScreenView extends GetView<MoreScreenController> {
  const MoreScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = context.watch<ModelTheme>().isDark;
    return Scaffold(
      body: BackGroundWidget(
        title: "More",
        leading: InkWell(
            onTap: () {
              Get.back();
            },
            child: Image.asset(
              isDarkMode
                  ? ImageConstant.arrowBackLight
                  : ImageConstant.arrowBackDark,
            )),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Spacing.height(10),
              _titleWidget(title: "Remove Ads", isDarkMode: isDarkMode),
              InkWell(
                onTap: () {},
                child: _subItemWidget(
                    title: "Remove Ads",
                    isDarkMode: isDarkMode,
                    widget: TextView(
                      text: "₹ 299.0",
                      fontSize: 18,
                      color: isDarkMode ? Colors.white : Colors.black,
                    )),
              ),
              Divider(height: 1),
              _subItemWidget(
                  title: "Restore", isDarkMode: isDarkMode, widget: SizedBox()),
              _titleWidget(
                  title: "Shayri", isDarkMode: isDarkMode, showBorder: true),
              _subItemWidget(
                  title: "Get Shayri Of The Day",
                  isDarkMode: isDarkMode,
                  isSwitch: true),
              _titleWidget(
                  title: "Appearance",
                  showBorder: true,
                  isDarkMode: isDarkMode),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                decoration: BoxDecoration(
                  color: (isDarkMode ? Colors.white : Colors.grey)
                      .withOpacity(0.1),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: TabBar(
                    dividerHeight: 0,
                    controller: controller.tabController,
                    padding: EdgeInsets.all(3),
                    indicator: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    indicatorSize: TabBarIndicatorSize.tab,
                    onTap: (value) {
                      if (value == 0) {
                        context.read<ModelTheme>().isDark = false;
                      } else if (value == 1) {
                        context.read<ModelTheme>().isDark = true;
                      }
                    },
                    tabs: [
                      SizedBox(
                        height: 25,
                        child: Center(
                          child: TextView(
                            text: "Light Mode",
                            color: isDarkMode ? Colors.white : Colors.black,
                            textOverflow: TextOverflow.ellipsis,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 25,
                        child: Center(
                          child: TextView(
                            text: "Dark Mode",
                            color: isDarkMode ? Colors.black : Colors.black,
                            textOverflow: TextOverflow.ellipsis,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ]),
              ),
              _titleWidget(
                  title: "About", isDarkMode: isDarkMode, showBorder: true),
              InkWell(
                onTap: () {
                  // Get.toNamed(Routes.ABOUT_APP);
                },
                child: _subItemWidget(
                  title: "About Us & App",
                  isDarkMode: isDarkMode,
                ),
              ),
              _titleWidget(
                  title: "Help", showBorder: true, isDarkMode: isDarkMode),
              InkWell(
                onTap: () {
                  controller.rateMyApp.init();
                  controller.rateMyApp.launchStore();
                },
                child: _subItemWidget(
                  title: "Love Shayari? Rate Us!",
                  isDarkMode: isDarkMode,
                ),
              ),
              Divider(height: 1),
              InkWell(
                onTap: () {
                  Share.share(PrefConstant.shareText);
                },
                child: _subItemWidget(
                  title: "Share App",
                  isDarkMode: isDarkMode,
                ),
              ),
              Divider(height: 1),
              InkWell(
                onTap: () {
                  Uri uri = Uri.parse(
                      "https://apps.apple.com/us/developer/rohit-iyer/id1150989827");
                  urlLauncher(url: uri, name: "Store");
                },
                child: _subItemWidget(
                  title: "More App",
                  isDarkMode: isDarkMode,
                ),
              ),
              Divider(height: 1),
              InkWell(
                onTap: () {
                  String subject =
                      "Status Quotes ${(Platform.isIOS) ? "iOS" : "Android"} Feedback";
                  urlLauncher(
                      url: Uri.parse(
                          "mailto:contact@falconsolutions.co?subject=$subject"),
                      name: "Mail");
                },
                child: _subItemWidget(
                  title: "Write Feedback",
                  isDarkMode: isDarkMode,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _titleWidget(
      {required String title,
      bool showBorder = false,
      bool isDarkMode = false}) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.1),
          border: (!showBorder)
              ? null
              : Border(
                  top: BorderSide(
                    color: (isDarkMode ? Colors.white : Colors.black)
                        .withOpacity(0.2),
                    width: 1,
                  ),
                )),
      child: TextView(
        text: "$title",
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _subItemWidget({
    required String title,
    bool isDarkMode = false,
    bool isSwitch = false,
    Widget? widget,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: TextView(
              text: "$title",
              fontSize: 18,
              fontWeight: FontWeight.normal,
            ),
          ),
          if (isSwitch)
            Obx(() {
              return CupertinoSwitch(
                value: controller.isQuoteOfTheDay.value,
                trackColor:
                    (isDarkMode ? Colors.white : Colors.grey).withOpacity(0.2),
                onChanged: (value) {
                  controller.isQuoteOfTheDay.value = value;
                  controller.isQuoteOfTheDay.refresh();
                },
              );
            })
          else if (!isNullEmptyOrFalse(widget))
            widget!
          else
            AssetImageWidget(
              lightImagePath: ImageConstant.arrowDark,
              darkImagePath: ImageConstant.arrowLight,
              height: 15,
              width: 15,
            ),
        ],
      ),
    );
  }
}
