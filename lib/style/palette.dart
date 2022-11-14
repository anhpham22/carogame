import 'package:flutter/material.dart';

/// A palette of colors to be used in the game.
///
/// The reason we're not going with something like Material Design's
/// `Theme` is simply that this is simpler to work with and yet gives
/// us everything we need for a game.
///
/// Games generally have more radical color palettes than apps. For example,
/// every level of a game can have radically different colors.
/// At the same time, games rarely support dark mode.
///
/// Colors taken from this fun palette:
/// https://lospec.com/palette-list/crayola84
///
/// Colors here are implemented as getters so that hot reloading works.
/// In practice, we could just as easily implement the colors
/// as `static const`. But this way the palette is more malleable:
/// we could allow players to customize colors, for example,
/// or even get the colors from the network.
class Palette {
  static Color pen = const Color(0xff1d75fb);
  static Color darkPen = const Color(0xFF0050bc);
  static Color redPen = const Color(0xFFd10841);
  static Color inkFullOpacity = const Color(0xff352b42);
  static Color ink = const Color(0xee352b42);
  static Color backgroundMain = const Color(0xffffffd1);
  static Color backgroundLevelSelection = const Color(0xffa2dcc7);
  static Color backgroundPlaySession = const Color(0xffffebb5);
  static Color background4 = const Color(0xffffd7ff);
  static Color backgroundSettings = const Color(0xffbfc8e3);
  static Color trueWhite = const Color(0xffffffff);
}
