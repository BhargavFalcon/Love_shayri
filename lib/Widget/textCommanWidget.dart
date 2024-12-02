import 'package:flutter/material.dart';
import 'package:love_shayri/constants/sizeConstant.dart';
import 'package:provider/provider.dart';

import '../service/ThemeService.dart';

class TextView extends StatelessWidget {
  const TextView(
      {super.key,
      required this.text,
      this.color,
      this.fontSize,
      this.fontWeight,
      this.textAlign,
      this.maxLine,
      this.textOverflow,
      this.fontStyle});
  final String text;
  final Color? color;
  final double? fontSize;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;
  final int? maxLine;
  final TextOverflow? textOverflow;
  final FontStyle? fontStyle;
  @override
  Widget build(BuildContext context) {
    bool isDarkMode = context.watch<ModelTheme>().isDark;
    return Text(
      text,
      style: TextStyle(
        color: color ?? (isDarkMode ? Colors.white : Colors.black),
        fontSize: MySize.getHeight(fontSize ?? 20),
        fontWeight: fontWeight ?? FontWeight.w500,
        fontStyle: fontStyle ?? FontStyle.normal,
      ),
      textAlign: textAlign,
      maxLines: maxLine,
      overflow: textOverflow,
    );
  }
}
