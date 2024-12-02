import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:love_shayri/constants/colorConstant.dart';
import 'package:love_shayri/constants/sizeConstant.dart';
import 'package:provider/provider.dart';

import '../service/ThemeService.dart';

class TextFiledWidget extends StatelessWidget {
  const TextFiledWidget({
    super.key,
    this.hintText,
    this.labelText,
    this.controller,
    this.keyboardType,
    this.maxLength,
    this.textInputFormatter,
    this.validator,
    this.onChanged,
    this.obscureText,
    this.readOnly,
    this.enabled,
    this.suffixIcon,
    this.prefixIcon,
    this.onEditingComplete,
    this.onFieldSubmitted,
    this.borderRadius,
  });
  final String? hintText;
  final String? labelText;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final int? maxLength;
  final List<TextInputFormatter>? textInputFormatter;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final bool? obscureText;
  final bool? readOnly;
  final bool? enabled;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final double? borderRadius;
  final void Function()? onEditingComplete;
  final void Function(String)? onFieldSubmitted;

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = context.watch<ModelTheme>().isDark;
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      maxLength: maxLength,
      inputFormatters: textInputFormatter,
      validator: validator,
      onChanged: onChanged,
      obscureText: obscureText ?? false,
      readOnly: readOnly ?? false,
      enabled: enabled ?? true,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: isDarkMode ? ColorConstants.white : ColorConstants.black,
              width: 1),
          borderRadius: BorderRadius.circular(50),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: isDarkMode ? ColorConstants.white : ColorConstants.black,
              width: 1),
          borderRadius: BorderRadius.circular(50),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 50),
          borderSide: BorderSide.none,
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 20),
        hintText: hintText,
        labelText: labelText,
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        hintStyle: TextStyle(
          color: isDarkMode ? ColorConstants.white : ColorConstants.black,
          fontSize: MySize.getHeight(16),
        ),
        labelStyle: TextStyle(
          color: isDarkMode ? ColorConstants.white : ColorConstants.black,
          fontSize: MySize.getHeight(16),
        ),
      ),
      cursorColor: isDarkMode ? ColorConstants.white : ColorConstants.black,
      cursorHeight: MySize.getHeight(16),
      style: TextStyle(
        color: isDarkMode ? ColorConstants.white : ColorConstants.black,
        fontSize: MySize.getHeight(16),
      ),
      onEditingComplete: onEditingComplete,
      onFieldSubmitted: onFieldSubmitted,
    );
  }
}
