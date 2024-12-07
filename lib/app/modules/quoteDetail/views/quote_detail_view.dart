import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:love_shayri/Widget/assetImageWidget.dart';
import 'package:love_shayri/Widget/backgoundImageWidget.dart';
import 'package:love_shayri/Widget/textCommanWidget.dart';
import 'package:love_shayri/app/routes/app_pages.dart';
import 'package:love_shayri/constants/sizeConstant.dart';
import 'package:love_shayri/constants/stringConstants.dart';
import 'package:love_shayri/main.dart';
import 'package:love_shayri/service/adService/banner_ads.dart';
import 'package:provider/provider.dart';

import '../../../../constants/colorConstant.dart';
import '../../../../service/ThemeService.dart';
import '../controllers/quote_detail_controller.dart';

class QuoteDetailView extends GetWidget<QuoteDetailController> {
  const QuoteDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<QuoteDetailController>(
      assignId: true,
      init: QuoteDetailController(),
      builder: (controller) {
        return Obx(() {
          bool isDarkMode = context.watch<ModelTheme>().isDark;
          return Scaffold(
            body: BackGroundWidget(
              title:
                  controller.shayarimodel.value.shayariCate ?? "" + " Shayari",
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
                  Row(
                    children: [
                      Spacing.width(16),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: InkWell(
                          onTap: () {
                            controller.favoriteQuote();
                          },
                          child: AssetImageWidget(
                            lightImagePath:
                                (controller.shayarimodel.value.favourite == "1")
                                    ? ImageConstant.favoriteLightFill
                                    : ImageConstant.favoriteLight,
                            darkImagePath:
                                (controller.shayarimodel.value.favourite == "1")
                                    ? ImageConstant.favoriteDarkFill
                                    : ImageConstant.favoriteDark,
                            height: 80,
                            width: 80,
                          ),
                        ),
                      ),
                      Spacing.width(16),
                      Expanded(
                        child: AnimatedSwitcher(
                          duration:
                              Duration(seconds: 1), // Duration of the animation
                          child: controller.showToaster.value
                              ? Container(
                                  key: ValueKey('second'),
                                  height: 40,
                                  alignment: Alignment.center,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: isDarkMode
                                        ? Colors.white
                                        : ColorConstants.redColor,
                                  ),
                                  child: TextView(
                                    text: controller.toasterMessage.value,
                                    textAlign: TextAlign.center,
                                    color: isDarkMode
                                        ? Colors.black
                                        : Colors.white,
                                    fontSize: 12,
                                  ),
                                )
                              : InkWell(
                                  onTap: () {
                                    Get.toNamed(Routes.CREATE_POST_SCREEN,
                                        arguments: {
                                          ArgumentConstants.shayariModel:
                                              controller.shayarimodel.value,
                                        });
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    height: 40,
                                    key: ValueKey('first'),
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: isDarkMode
                                          ? Colors.white
                                          : ColorConstants.redColor,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Column(
                                      children: [
                                        Spacer(),
                                        Center(
                                          child: TextView(
                                            text: "Create Post",
                                            textAlign: TextAlign.center,
                                            fontWeight: FontWeight.bold,
                                            color: isDarkMode
                                                ? Colors.black
                                                : Colors.white,
                                            fontSize: 20,
                                          ),
                                        ),
                                        Spacer(),
                                      ],
                                    ),
                                  ),
                                ),
                        ),
                      ),
                      Spacing.width(16),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: InkWell(
                          onTap: () {
                            Clipboard.setData(
                              ClipboardData(
                                  text: controller
                                      .shayarimodel.value.shayariText!),
                            );
                            controller
                                .showToasterMessage("Copied to clipboard");
                          },
                          child: AssetImageWidget(
                            lightImagePath: ImageConstant.copy,
                            darkImagePath: ImageConstant.copyWhite,
                            height: 80,
                            width: 80,
                          ),
                        ),
                      ),
                      Spacing.width(16),
                    ],
                  ),
                  Expanded(
                    child: (controller.isShow.isFalse)
                        ? SizedBox(
                            child: CircularProgressIndicator(),
                          )
                        : AnimatedBuilder(
                            animation: controller.animationController,
                            builder: (context, child) {
                              return SlideTransition(
                                position: controller.positionAnimation,
                                child: Opacity(
                                  opacity: controller.opacityAnimation.value,
                                  child: Container(
                                    padding: Spacing.all(16),
                                    margin: Spacing.horizontal(16),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: isDarkMode
                                            ? ColorConstants.white
                                            : ColorConstants.redColor,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Center(
                                      child: SingleChildScrollView(
                                        child: TextView(
                                          textAlign: TextAlign.center,
                                          text: controller
                                              .shayarimodel.value.shayariText!,
                                          fontSize: 20,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: InkWell(
                          onTap: () {
                            adService.showInterstitialAd(onAdDismissed: () {
                              controller.prevQuote();
                            });
                          },
                          child: AssetImageWidget(
                            lightImagePath: ImageConstant.prevLight,
                            darkImagePath: ImageConstant.prevDark,
                            height: 80,
                            width: 80,
                          ),
                        ),
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: InkWell(
                          onTap: () {
                            controller.shareQuote();
                          },
                          child: AssetImageWidget(
                            lightImagePath: ImageConstant.share,
                            darkImagePath: ImageConstant.shareWhite,
                            height: 80,
                            width: 80,
                          ),
                        ),
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: InkWell(
                          onTap: () {
                            adService.showInterstitialAd(onAdDismissed: () {
                              controller.nextQuote();
                            });
                          },
                          child: AssetImageWidget(
                            lightImagePath: ImageConstant.nextLight,
                            darkImagePath: ImageConstant.nextDark,
                            height: 80,
                            width: 80,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            bottomNavigationBar: Container(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).padding.bottom),
              child: BannerAdsWidget(),
            ),
          );
        });
      },
    );
  }
}
