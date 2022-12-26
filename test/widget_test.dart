// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:io';
import 'package:carogame/games_services/games_services.dart';
import 'package:carogame/player_progress/persistence/local_storage_player_progress_persistence.dart';
import 'package:carogame/settings/persistence/local_storage_settings_persistence.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/foundation.dart';
import 'package:carogame/main.dart';

void main() {
  GamesServicesController? gamesServicesController;
  if (!kIsWeb && (Platform.isIOS || Platform.isAndroid)) {
    gamesServicesController = GamesServicesController()
      // Attempt to log the player in.
      ..initialize();
  }
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp(
      settingsPersistence: LocalStorageSettingsPersistence(),
      playerProgressPersistence: LocalStoragePlayerProgressPersistence(),
      // inAppPurchaseController: inAppPurchaseController,
      // adsController: adsController,
      gamesServicesController: gamesServicesController,
    ));

    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}
