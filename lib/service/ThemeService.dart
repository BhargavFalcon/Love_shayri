import 'package:flutter/material.dart';

import '../constants/stringConstants.dart';
import '../main.dart';

class ModelTheme extends ChangeNotifier {
  late bool _isDark;
  bool get isDark => _isDark;

  ModelTheme() {
    _isDark = true;
    getPreferences();
  }
//Switching the themes
  set isDark(bool value) {
    _isDark = value;
    box.write(PrefConstant.isDarkTheme, value);
    notifyListeners();
  }

  getPreferences() async {
    _isDark = await box.read(PrefConstant.isDarkTheme) ?? true;
    notifyListeners();
  }

  void changeTheme() {
    _isDark = !_isDark;
    box.write(PrefConstant.isDarkTheme, _isDark);
    notifyListeners();
  }
}
