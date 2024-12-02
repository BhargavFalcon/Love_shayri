import 'package:flutter/material.dart';
import 'package:love_shayri/constants/sizeConstant.dart';
import 'package:provider/provider.dart';

import '../service/ThemeService.dart';

class AssetImageWidget extends StatelessWidget {
  const AssetImageWidget({
    super.key,
    required this.lightImagePath,
    required this.darkImagePath,
    this.height,
    this.width,
    this.fit,
  });
  final String lightImagePath;
  final String darkImagePath;
  final double? height;
  final double? width;
  final BoxFit? fit;

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = context.watch<ModelTheme>().isDark;
    return Image.asset(
      isDarkMode ? darkImagePath : lightImagePath,
      height: MySize.getHeight(height ?? 60),
      width: MySize.getHeight(width ?? 60),
      fit: fit,
    );
  }
}
