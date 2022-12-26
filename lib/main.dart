import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';
import 'app_lifecycle/app_lifecycle.dart';
import 'audio/audio_controller.dart';
import 'games_services/games_services.dart';
import 'games_services/score.dart';
import 'play_session/play_session_screen.dart';
import 'player_progress/persistence/local_storage_player_progress_persistence.dart';
import 'player_progress/persistence/player_progress_persistence.dart';
import 'player_progress/player_progress.dart';
import 'settings/persistence/local_storage_settings_persistence.dart';
import 'settings/persistence/settings_persistence.dart';
import 'settings/settings.dart';
import 'settings/settings_screen.dart';
import 'style/ink_transition.dart';
import 'style/palette.dart';
import 'style/snack_bar.dart';
import 'view/level_selection_screen.dart';
import 'view/levels.dart';
import 'view/main_menu_screen.dart';
import 'win_game/win_game_screen.dart';
import 'package:firebase_core/firebase_core.dart';

// import 'firebase_options.dart';

// Future<void> main() async {
//   FirebaseCrashlytics? crashlytics;
//   if (!kIsWeb && (Platform.isIOS || Platform.isAndroid)) {
//     try {
//       WidgetsFlutterBinding.ensureInitialized();
//       // await Firebase.initializeApp(
//       //   options: DefaultFirebaseOptions.currentPlatform,
//       // );
//       crashlytics = FirebaseCrashlytics.instance;
//     } catch (e) {
//       debugPrint("Firebase couldn't be initialized: $e");
//     }
//   }

//   await guardWithCrashlytics(
//     guardedMain,
//     crashlytics: crashlytics,
//   );
// }
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  _log.info('Going full screen');
  await Firebase.initializeApp();
  GamesServicesController? gamesServicesController;
  runApp(
    MyApp(
      settingsPersistence: LocalStorageSettingsPersistence(),
      playerProgressPersistence: LocalStoragePlayerProgressPersistence(),
      // inAppPurchaseController: inAppPurchaseController,
      // adsController: adsController,
      gamesServicesController: gamesServicesController,
    ),
  );
}

Logger _log = Logger('main.dart');

class MyApp extends StatelessWidget {
  static final _router = GoRouter(
    routes: [
      GoRoute(
          path: '/',
          builder: (context, state) =>
              const MainMenuScreen(key: Key('main menu')),
          routes: [
            GoRoute(
                path: 'play',
                pageBuilder: (context, state) => buildTransition(
                      child: const LevelSelectionScreen(
                          key: Key('level selection')),
                      color: context.watch<Palette>().backgroundLevelSelection,
                    ),
                routes: [
                  GoRoute(
                    path: 'session/:level',
                    pageBuilder: (context, state) {
                      final levelNumber = int.parse(state.params['level']!);
                      final level = gameLevels
                          .singleWhere((e) => e.number == levelNumber);
                      return buildTransition(
                        child: PlaySessionScreen(
                          level,
                          key: const Key('play session'),
                        ),
                        color: context.watch<Palette>().backgroundPlaySession,
                        flipHorizontally: true,
                      );
                    },
                  ),
                  GoRoute(
                    path: 'won',
                    pageBuilder: (context, state) {
                      final map = state.extra! as Map<String, dynamic>;
                      final score = map['score'] as Score;

                      return buildTransition(
                        child: WinGameScreen(
                          score: score,
                          key: const Key('win game'),
                        ),
                        color: context.watch<Palette>().backgroundPlaySession,
                        flipHorizontally: true,
                      );
                    },
                  )
                ]),
            GoRoute(
              path: 'settings',
              builder: (context, state) =>
                  const SettingsScreen(key: Key('settings')),
            ),
          ]),
    ],
  );

  final PlayerProgressPersistence playerProgressPersistence;

  final SettingsPersistence settingsPersistence;

  final GamesServicesController? gamesServicesController;

  // final InAppPurchaseController? inAppPurchaseController;

  // final AdsController? adsController;

  const MyApp({
    required this.playerProgressPersistence,
    required this.settingsPersistence,
    // required this.inAppPurchaseController,
    // required this.adsController,
    required this.gamesServicesController,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppLifecycleObserver(
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) {
              var progress = PlayerProgress(playerProgressPersistence);
              progress.getLatestFromStore();
              return progress;
            },
          ),
          Provider<GamesServicesController?>.value(
              value: gamesServicesController),
          // Provider<AdsController?>.value(value: adsController),
          // ChangeNotifierProvider<InAppPurchaseController?>.value(
          //     value: inAppPurchaseController),
          Provider<SettingsController>(
            lazy: false,
            create: (context) => SettingsController(
              persistence: settingsPersistence,
            )..loadStateFromPersistence(),
          ),
          ProxyProvider2<SettingsController, ValueNotifier<AppLifecycleState>,
              AudioController>(
            // Ensures that the AudioController is created on startup,
            // and not "only when it's needed", as is default behavior.
            // This way, music starts immediately.
            lazy: false,
            create: (context) => AudioController()..initialize(),
            update: (context, settings, lifecycleNotifier, audio) {
              if (audio == null) throw ArgumentError.notNull();
              audio.attachSettings(settings);
              audio.attachLifecycleNotifier(lifecycleNotifier);
              return audio;
            },
            dispose: (context, audio) => audio.dispose(),
          ),
          Provider(
            create: (context) => Palette(),
          ),
        ],
        child: Builder(builder: (context) {
          final palette = context.watch<Palette>();

          return MaterialApp.router(
            title: 'Flutter Demo',
            theme: ThemeData.from(
              colorScheme: ColorScheme.fromSeed(
                seedColor: palette.darkPen,
                background: palette.backgroundMain,
              ),
              textTheme: TextTheme(
                bodyText2: TextStyle(
                  color: palette.ink,
                ),
              ),
            ),
            routeInformationParser: _router.routeInformationParser,
            routerDelegate: _router.routerDelegate,
            scaffoldMessengerKey: scaffoldMessengerKey,
          );
        }),
      ),
    );
  }
}
