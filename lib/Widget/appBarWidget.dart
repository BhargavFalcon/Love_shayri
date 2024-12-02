import 'package:flutter/material.dart';
import 'package:love_shayri/constants/colorConstant.dart';
import 'package:love_shayri/constants/sizeConstant.dart';
import 'package:provider/provider.dart';

import '../constants/stringConstants.dart';
import '../service/ThemeService.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppBarWidget({
    super.key,
    required this.text,
    this.toolbarHeight,
    this.leading,
    this.actions,
    this.isShowBackButton = false,
  });
  final String text;
  final double? toolbarHeight;
  final Widget? leading;
  final List<Widget>? actions;
  final bool isShowBackButton;
  @override
  Widget build(BuildContext context) {
    bool isDarkMode = context.watch<ModelTheme>().isDark;

    return AppBar(
      leading: (isShowBackButton)
          ? InkWell(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Center(
                child: Image.asset(
                  isDarkMode
                      ? ImageConstant.arrowBackDark
                      : ImageConstant.arrowBackLight,
                  height: MySize.getHeight(60),
                  width: MySize.getWidth(60),
                ),
              ),
            )
          : leading,
      leadingWidth: leading != null ? MySize.getWidth(60) : null,
      title: Text(
        text,
        style: TextStyle(
          color: isDarkMode ? ColorConstants.white : ColorConstants.black,
          fontSize: MySize.getHeight(20),
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: actions,
      centerTitle: true,
    );
  }

  Size get preferredSize => Size.fromHeight(toolbarHeight ?? kToolbarHeight);
}
