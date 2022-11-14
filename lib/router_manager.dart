import 'package:carogame/view/level_selection_screen.dart';
import 'package:carogame/view/main_menu_screen.dart';
import 'package:carogame/viewmodel/play_progress_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class RouterManager {
  static var routers = {
    MainMenuScreen.routerName: (BuildContext context) => const MainMenuScreen(),
    LevelSelectionScreen.routerName: (BuildContext context) {
      return MultiProvider(
        providers: [
          BlocProvider(
            create: (context) => PlayProgressBloc(),
          ),
        ],
        child: const LevelSelectionScreen(),
      );
    }
  };
  static var initialRoute = MainMenuScreen.routerName;
}
