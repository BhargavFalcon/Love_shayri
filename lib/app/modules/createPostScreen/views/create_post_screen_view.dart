import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:love_shayri/Widget/assetImageWidget.dart';
import 'package:love_shayri/Widget/backgoundImageWidget.dart';
import 'package:love_shayri/Widget/textCommanWidget.dart';
import 'package:love_shayri/app/routes/app_pages.dart';
import 'package:love_shayri/constants/colorConstant.dart';
import 'package:love_shayri/constants/sizeConstant.dart';
import 'package:love_shayri/constants/stringConstants.dart';
import 'package:love_shayri/service/ThemeService.dart';
import 'package:love_shayri/service/adService/banner_ads.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:scroll_screenshot/scroll_screenshot.dart';
import '../../../../main.dart';
import '../../../../service/CameraService.dart';
import '../controllers/create_post_screen_controller.dart';

class CreatePostScreenView extends GetWidget<CreatePostScreenController> {
  CreatePostScreenView({super.key});

  final GlobalKey _textSizeIconKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = context.watch<ModelTheme>().isDark;

    return GetBuilder<CreatePostScreenController>(
      assignId: true,
      init: CreatePostScreenController(),
      builder: (controller) {
        return Obx(() {
          return Scaffold(
            body: GestureDetector(
              onTap: () {
                controller.isTextSizeVisible.value = false;
              },
              child: BackGroundWidget(
                title: "Create Post",
                leading: InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: Image.asset(
                      isDarkMode
                          ? ImageConstant.arrowBackLight
                          : ImageConstant.arrowBackDark,
                    )),
                actions: [
                  InkWell(
                    onTap: () async {
                      String? base64String =
                          await ScrollScreenshot.captureAndSaveScreenshot(
                              controller.screenshotKey);
                      final bytes = base64Decode(base64String!);
                      final directory = await getApplicationCacheDirectory();
                      final imagePath = File(
                          '${directory.path}/${DateTime.now().microsecond}.png');
                      await imagePath.writeAsBytes(bytes);
                      Get.toNamed(Routes.SHARE_SCREEN, arguments: {
                        ArgumentConstants.imagePath: imagePath,
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextView(
                        text: "Share",
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
                child: Padding(
                  padding: Spacing.horizontal(16),
                  child: Stack(
                    children: [
                      Column(
                        children: [
                          Spacing.height(50),
                          Expanded(
                            child: RepaintBoundary(
                              key: controller.screenshotKey,
                              child: (controller.isEditByAi.value == true)
                                  ? Container(
                                      padding: Spacing.all(16),
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage(isDarkMode
                                              ? ImageConstant.darkModeBg
                                              : ImageConstant.lightModeBg),
                                          fit: BoxFit.fill,
                                        ),
                                        borderRadius: BorderRadius.circular(
                                            (controller
                                                    .isCaptureScreenShot.isTrue)
                                                ? 0
                                                : 10),
                                      ),
                                      child: Padding(
                                        padding: Spacing.horizontal(16),
                                        child: Center(
                                          child: TextView(
                                            text: controller.shayarimodel.value
                                                    .shayariText ??
                                                "No Text",
                                            color: isDarkMode
                                                ? ColorConstants.white
                                                : ColorConstants.black,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                    )
                                  : Container(
                                      padding: Spacing.all(16),
                                      decoration: BoxDecoration(
                                        color:
                                            controller.backgroundColor?.value,
                                        image: (controller.filePath.isNotEmpty)
                                            ? DecorationImage(
                                                image: FileImage(File(
                                                    controller.filePath.value)),
                                                fit: BoxFit.cover,
                                              )
                                            : controller.backgroundColor != null
                                                ? null
                                                : DecorationImage(
                                                    image: AssetImage(isDarkMode
                                                        ? ImageConstant
                                                            .darkModeBg
                                                        : ImageConstant
                                                            .lightModeBg),
                                                    fit: BoxFit.cover,
                                                  ),
                                        borderRadius: BorderRadius.circular(
                                            (controller
                                                    .isCaptureScreenShot.isTrue)
                                                ? 0
                                                : 10),
                                      ),
                                      child: Padding(
                                        padding: Spacing.horizontal(16),
                                        child: Center(
                                          child: TextView(
                                            text: controller.shayarimodel.value
                                                    .shayariText ??
                                                "No Text",
                                            color: controller.textColor?.value,
                                            fontSize: controller.fontSize.value,
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                    ),
                            ),
                          ),
                          Spacing.height(30),
                          InkWell(
                            onTap: () {
                              controller.isEditByAi.toggle();
                            },
                            child: Container(
                              alignment: Alignment.center,
                              height: MySize.getHeight(45),
                              width: MySize.getWidth(200),
                              decoration: BoxDecoration(
                                color: isDarkMode
                                    ? Colors.white
                                    : ColorConstants.redColor,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Center(
                                child: TextView(
                                  textAlign: TextAlign.center,
                                  text: controller.isEditByAi.isTrue
                                      ? "Undo"
                                      : "Edit Image With AI",
                                  color: isDarkMode
                                      ? ColorConstants.black
                                      : Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                          Spacing.height(30),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              InkWell(
                                onTap: () {
                                  showColorPicker(
                                    context: context,
                                    isDarkMode: isDarkMode,
                                    isFromText: true,
                                    pickerColor: controller.textColor?.value,
                                  );
                                },
                                child: imageWithText(
                                  lightImage: ImageConstant.textColorDark,
                                  darkImage: ImageConstant.textColorLight,
                                  text: "Text Color",
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  controller.isTextSizeVisible.toggle();
                                },
                                onTapDown: (details) {
                                  WidgetsBinding.instance
                                      .addPostFrameCallback((_) {
                                    controller.offset.value =
                                        _getIconPosition(_textSizeIconKey) ??
                                            Offset.zero;
                                  });
                                },
                                child: Column(
                                  key: _textSizeIconKey,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    imageWithText(
                                      lightImage: ImageConstant.textSizeDark,
                                      darkImage: ImageConstant.textSizeLight,
                                      text: "Text Size",
                                    ),
                                  ],
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  if (controller.baseColorAlertVisible.isTrue) {
                                    showColorPicker(
                                      context: context,
                                      isDarkMode: isDarkMode,
                                      isFromText: false,
                                      pickerColor:
                                          controller.backgroundColor?.value,
                                    );
                                    return;
                                  }
                                  customDialog(
                                    context: context,
                                    title: "Alert",
                                    content:
                                        "Selecting this option will remove the default image. Are you sure you want to proceed?",
                                    cancel: "Cancel",
                                    ok: "Remove",
                                    onOk: () {
                                      Get.back();
                                      controller.baseColorAlertVisible.toggle();
                                      showColorPicker(
                                        context: context,
                                        isDarkMode: isDarkMode,
                                        isFromText: false,
                                        pickerColor:
                                            controller.backgroundColor?.value,
                                      );
                                    },
                                  );
                                },
                                child: imageWithText(
                                  lightImage: ImageConstant.baseColorDark,
                                  darkImage: ImageConstant.baseColorLight,
                                  text: "Base Color",
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  BgImgPopUp(
                                    context: context,
                                    controller: controller,
                                    isDarkMode: isDarkMode,
                                  );
                                },
                                child: imageWithText(
                                  lightImage: ImageConstant.bgImageDark,
                                  darkImage: ImageConstant.bgImageLight,
                                  text: "BgImg",
                                ),
                              ),
                            ],
                          ),
                          Spacing.height(50),
                        ],
                      ),
                      if (controller.isTextSizeVisible.value)
                        Positioned(
                          top: controller.offset.value.dy - 250,
                          left: controller.offset.value.dx - 25,
                          child: Container(
                            height: MySize.getHeight(138),
                            width: MySize.getWidth(60),
                            child: CupertinoPicker(
                              itemExtent: 30,
                              scrollController: FixedExtentScrollController(
                                  initialItem:
                                      controller.fontSize.value.toInt() - 11),
                              children: List.generate(
                                39,
                                (index) => Center(
                                  child: TextView(
                                    fontSize: 13,
                                    text: (index + 12).toString(),
                                  ),
                                ),
                              ),
                              useMagnifier: true,
                              magnification: 1.2,
                              onSelectedItemChanged: (int index) {
                                controller.fontSize.value = index + 11.0;
                                controller.update();
                              },
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
            bottomNavigationBar: Container(
              padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
              child: BannerAdsWidget(),
            ),
          );
        });
      },
    );
  }

  BgImgPopUp({
    required BuildContext context,
    required CreatePostScreenController controller,
    required bool isDarkMode,
  }) {
    return showCupertinoModalPopup(
        barrierDismissible: true,
        context: context,
        builder: (BuildContext context) => CupertinoTheme(
              data: CupertinoThemeData(
                brightness: box.read(PrefConstant.isDarkTheme) ?? true
                    ? Brightness.dark
                    : Brightness.light,
              ),
              child: CupertinoActionSheet(
                actions: <CupertinoActionSheetAction>[
                  CupertinoActionSheetAction(
                    child: Text('Camera',
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 18,
                            color: Colors.blue)),
                    onPressed: () {
                      pickImage(ImageSource.camera).then((value) {
                        if (value != null) {
                          controller.filePath.value = value.path;
                        }
                      });
                      Navigator.pop(context);
                      // Perform action 1
                    },
                  ),
                  CupertinoActionSheetAction(
                    child: Text('Photos',
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 18,
                            color: Colors.blue)),
                    onPressed: () {
                      pickImage(ImageSource.gallery).then((value) {
                        if (value != null) {
                          controller.filePath.value = value.path;
                        }
                      });
                      Navigator.pop(context);
                      // Perform action 2
                    },
                  ),
                ],
                cancelButton: CupertinoActionSheetAction(
                  child: Text('Cancel',
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                          color: Colors.blue)),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ));
  }

  Widget imageWithText({
    required String lightImage,
    required String darkImage,
    required String text,
  }) {
    return Column(
      children: [
        AssetImageWidget(
          lightImagePath: lightImage,
          darkImagePath: darkImage,
          height: 40,
          width: 40,
        ),
        Spacing.height(4),
        TextView(
          text: text,
          fontSize: 12,
        ),
      ],
    );
  }

  showColorPicker({
    required BuildContext context,
    required bool isDarkMode,
    Color? pickerColor,
    bool isFromText = true,
  }) {
    Color? colors;
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ColorPicker(
                  pickerColor:
                      pickerColor ?? (isDarkMode ? Colors.white : Colors.black),
                  onColorChanged: (color) {
                    colors = color;
                  },
                ),
              ],
            ),
            actions: <Widget>[
              InkWell(
                onTap: () {
                  if (colors != null) {
                    if (isFromText) {
                      Get.find<CreatePostScreenController>().textColor =
                          Rx(colors!);
                    } else {
                      Get.find<CreatePostScreenController>().backgroundColor =
                          Rx(colors!);
                    }
                    Get.find<CreatePostScreenController>().update();
                  }
                  Get.back();
                },
                child: Text(
                  "Done",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          );
        });
      },
    );
  }

  Offset? _getIconPosition(GlobalKey key) {
    final RenderBox? box = key.currentContext?.findRenderObject() as RenderBox?;
    return box?.localToGlobal(Offset.zero);
  }
}
