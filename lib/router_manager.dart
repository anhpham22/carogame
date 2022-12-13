import 'package:carogame/settings/settings_screen.dart';
import 'package:carogame/view/level_selection_screen.dart';
import 'package:carogame/view/main_menu_screen.dart';
import 'package:flutter/material.dart';

class RouterManager {
  static var routers = {
    MainMenuScreen.routerName: (BuildContext context) => const MainMenuScreen(),
    LevelSelectionScreen.routerName: (BuildContext context) =>
        const LevelSelectionScreen(),
    SettingsScreen.routeName: (BuildContext context) => const SettingsScreen(),
  };
  static var initialRoute = MainMenuScreen.routerName;
}
