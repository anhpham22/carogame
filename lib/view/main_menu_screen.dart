import 'package:carogame/style/palette.dart';
import 'package:carogame/view/level_selection_screen.dart';
import 'package:carogame/view/responsive_screen.dart';
import 'package:carogame/widget/button_widget.dart';
import 'package:flutter/material.dart';

class MainMenuScreen extends StatefulWidget {
  const MainMenuScreen({super.key});

  static const routerName = "/main-menu";

  @override
  State<MainMenuScreen> createState() => _MainMenuScreenState();
}

class _MainMenuScreenState extends State<MainMenuScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Palette.redPen,
        appBar: null,
        body: ResponsiveScreen(
            squarishMainArea: Center(
              child: Image.asset("assets/images/main-menu.png"),
            ),
            rectangularMenuArea: Column(
              children: [
                ButtonWidget(
                  widget: const Text("Play"),
                  buttonRectangle: true,
                  fontSize: 42,
                  onTap: () {
                    Navigator.pushNamed(
                        context, LevelSelectionScreen.routerName);
                  },
                  textColor: Palette.redPen,
                ),
                ButtonWidget(
                  widget: const Text("Setting"),
                  buttonRectangle: false,
                  fontSize: 42,
                  onTap: () {},
                  textColor: Palette.trueWhite,
                ),
              ],
            )));
  }
}
