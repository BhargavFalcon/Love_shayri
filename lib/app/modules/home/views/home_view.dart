import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:love_shayri/Widget/backgoundImageWidget.dart';
import 'package:love_shayri/Widget/textFiledWidget.dart';
import 'package:love_shayri/app/routes/app_pages.dart';
import 'package:love_shayri/constants/sizeConstant.dart';
import 'package:love_shayri/main.dart';
import 'package:love_shayri/service/ThemeService.dart';
import 'package:love_shayri/service/adService/banner_ads.dart';
import 'package:provider/provider.dart';
import '../../../../constants/stringConstants.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetWidget<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    MySize().init(context);
    bool isDarkMode = context.watch<ModelTheme>().isDark;
    return Obx(() {
      return Scaffold(
        body: BackGroundWidget(
          leading: InkWell(
            onTap: () {
              Get.toNamed(Routes.MORE_SCREEN);
            },
            child: Image.asset(
              isDarkMode ? ImageConstant.moreLight : ImageConstant.moreDark,
              height: MySize.getHeight(60),
              width: MySize.getWidth(60),
              fit: BoxFit.cover,
            ),
          ),
          actions: [
            InkWell(
              onTap: () {
                service.shownNotification(id: 1, title: "title", body: "body");
              },
              child: Icon(
                Icons.notifications,
                color: Colors.white,
                size: 30,
              ),
            ),
            InkWell(
              onTap: () {
                Get.toNamed(Routes.FAVOURITE_SHAYARI_LIST_SCREEN);
              },
              child: Image.asset(
                isDarkMode ? ImageConstant.starLight : ImageConstant.starDark,
                height: MySize.getHeight(60),
                width: MySize.getWidth(60),
                fit: BoxFit.cover,
              ),
            ),
          ],
          child: Column(
            children: [
              Spacing.height(10),
              Padding(
                padding: Spacing.horizontal(16),
                child: Container(
                  height: MySize.getHeight(40),
                  child: TextFiledWidget(
                    hintText: "Search Category",
                    controller: controller.searchController,
                    onChanged: (value) {
                      controller.onSearch(value);
                    },
                  ),
                ),
              ),
              Spacing.height(15),
              Expanded(
                child: GridView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  itemCount: controller.itemList.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 8,
                      crossAxisCount: 2),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        adService.showInterstitialAd(onAdDismissed: () {
                          Get.toNamed(Routes.SHAYRI_LIST_SCREEN, arguments: {
                            ArgumentConstants.shayariCate:
                                controller.itemList[index].title,
                          });
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white),
                          image: DecorationImage(
                            image: AssetImage(
                              controller.itemList[index].image!,
                            ),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                controller.itemList[index].title!,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "TOTAL " +
                                    controller.itemList[index].size.toString(),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
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
        bottomNavigationBar: Container(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
          child: BannerAdsWidget(),
        ),
      );
    });
  }
}
