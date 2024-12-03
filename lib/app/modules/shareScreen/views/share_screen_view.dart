import 'package:flutter/material.dart';
import 'package:flutter_social_share_plugin/file_type.dart';
import 'package:get/get.dart';
import 'package:love_shayri/Widget/assetImageWidget.dart';
import 'package:love_shayri/Widget/backgoundImageWidget.dart';
import 'package:love_shayri/app/routes/app_pages.dart';
import 'package:love_shayri/constants/sizeConstant.dart';
import 'package:love_shayri/constants/stringConstants.dart';
import 'package:love_shayri/service/CameraService.dart';
import 'package:love_shayri/service/ThemeService.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

import '../controllers/share_screen_controller.dart';

class ShareScreenView extends GetWidget<ShareScreenController> {
  const ShareScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = context.watch<ModelTheme>().isDark;
    return Obx(() {
      return Scaffold(
        body: BackGroundWidget(
          title: "Share Post",
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
            padding: Spacing.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              children: [
                Expanded(
                  child: Image.file(
                    controller.shareFile.value,
                  ),
                ),
                Spacing.height(50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: () {
                        controller.flutterShareMe
                            .shareToWhatsApp(
                          fileType: FileType.image,
                          imagePath: controller.shareFile.value.path,
                          msg: PrefConstant.shareText,
                        )
                            .then(
                          (value) {
                            print(value);
                            if (value!.contains("WHATSAPP_NOT_INSTALLED") ||
                                value.contains("WhatsApp is not found")) {
                              customDialog(
                                context: context,
                                title: "Alert",
                                content:
                                    "WhatsApp service not available on this device",
                                cancel: "Cancel",
                                ok: "Remove",
                                onOk: () {
                                  Get.back();
                                },
                              );
                            }
                          },
                        );
                      },
                      child: AssetImageWidget(
                        lightImagePath: ImageConstant.whatsAppLight,
                        darkImagePath: ImageConstant.whatsAppDark,
                        width: 60,
                        height: 60,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        controller.flutterShareMe
                            .shareToInstagram(
                          filePath: controller.shareFile.value.path,
                          fileType: FileType.image,
                        )
                            .then(
                          (value) {
                            if (value!.contains("INSTAGRAM_NOT_INSTALLED") ||
                                value.contains(
                                    "Instagram app is not installed on your device")) {
                              customDialog(
                                context: context,
                                title: "Alert",
                                content:
                                    "Instagram service not available on this device",
                                cancel: "Cancel",
                                ok: "OK",
                                okColor: Colors.blue,
                                onOk: () {
                                  Get.back();
                                },
                              );
                            }
                          },
                        );
                      },
                      child: AssetImageWidget(
                        lightImagePath: ImageConstant.instaLight,
                        darkImagePath: ImageConstant.instaDark,
                        width: 60,
                        height: 60,
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                        controller.flutterShareMe
                            .shareToFacebook(
                          msg: PrefConstant.shareText,
                          imagePath: controller.shareFile.value.path,
                        )
                            .then(
                          (value) {
                            if (value!.contains("FACEBOOK_NOT_INSTALLED") ||
                                value.contains("FacebookAppNotInstalled")) {
                              customDialog(
                                context: context,
                                title: "Alert",
                                content:
                                    "Facebook service not available on this device",
                                cancel: "Cancel",
                                ok: "OK",
                                okColor: Colors.blue,
                                onOk: () {
                                  Get.back();
                                },
                              );
                            }
                          },
                        );
                      },
                      child: AssetImageWidget(
                        lightImagePath: ImageConstant.facebookLight,
                        darkImagePath: ImageConstant.facebookDark,
                        width: 60,
                        height: 60,
                      ),
                    ),
                  ],
                ),
                Spacing.height(13),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: () {
                        controller.flutterShareMe
                            .shareToTwitter(
                          msg: PrefConstant.shareText,
                          url: "",
                        )
                            .then(
                          (value) {
                            if (value!.contains("error") ||
                                value.contains("Twitter is not found")) {
                              customDialog(
                                context: context,
                                title: "Alert",
                                content:
                                    "Twitter service not available on this device",
                                cancel: "cancel",
                                ok: "OK",
                                okColor: Colors.blue,
                                onOk: () {
                                  Get.back();
                                },
                              );
                            }
                          },
                        );
                      },
                      child: AssetImageWidget(
                        lightImagePath: ImageConstant.twitterLight,
                        darkImagePath: ImageConstant.twitterDark,
                        width: 60,
                        height: 60,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Share.shareXFiles(
                          [XFile(controller.shareFile.value.path)],
                          text: PrefConstant.shareText,
                        );
                      },
                      child: AssetImageWidget(
                        lightImagePath: ImageConstant.sharePostLight,
                        darkImagePath: ImageConstant.sharePostDark,
                        width: 60,
                        height: 60,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Get.offAllNamed(Routes.HOME);
                      },
                      child: AssetImageWidget(
                        lightImagePath: ImageConstant.homeLight,
                        darkImagePath: ImageConstant.homeDark,
                        width: 60,
                        height: 60,
                      ),
                    ),
                  ],
                ),
                Spacing.height(13),
              ],
            ),
          ),
        ),
      );
    });
  }
}
