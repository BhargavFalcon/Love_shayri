import 'package:flutter/material.dart';
import 'package:love_shayri/Widget/appBarWidget.dart';
import 'package:love_shayri/constants/stringConstants.dart';
import 'package:provider/provider.dart';

import '../service/ThemeService.dart';

class BackGroundWidget extends StatefulWidget {
  const BackGroundWidget(
      {super.key,
      required this.child,
      this.title,
      this.toolbarHeight,
      this.actions,
      this.leading,
      this.isShowBackButton = false});
  final Widget child;
  final String? title;
  final double? toolbarHeight;
  final Widget? leading;
  final List<Widget>? actions;
  final bool isShowBackButton;

  @override
  State<BackGroundWidget> createState() => _BackGroundWidgetState();
}

class _BackGroundWidgetState extends State<BackGroundWidget> {
  @override
  Widget build(BuildContext context) {
    bool isDarkMode = context.watch<ModelTheme>().isDark;

    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(isDarkMode
              ? ImageConstant.darkModeBg
              : ImageConstant.lightModeBg),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        children: [
          SizedBox(
            height: 50 + MediaQuery.of(context).padding.top,
            child: AppBarWidget(
              text: widget.title ?? "Love Shayri",
              leading: widget.leading,
              actions: widget.actions,
              isShowBackButton: widget.isShowBackButton,
            ),
          ),
          Expanded(child: widget.child),
        ],
      ),
    );
  }
}
