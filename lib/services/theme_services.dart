import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:todo_bestech/ui/theme.dart';

class ThemeServices {
  final _box = GetStorage();
  final _key = 'isDarkMode';
  _saveThemeToBox(bool isDarkMode) => _box.write(_key, isDarkMode);
  bool _loadThemeFromBox() => _box.read(_key) ?? false;
  ThemeData get theme => _loadThemeFromBox() ? Themes.dark : Themes.light;

  void switchTheme() {
    Get.changeTheme(_loadThemeFromBox() ? Themes.light : Themes.dark);
    _saveThemeToBox(!_loadThemeFromBox());
  }
}
