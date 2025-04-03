import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:tripeaks_neue/l10n/app_localizations.dart';
import 'package:tripeaks_neue/pages/home_page/home_page.dart';
import 'package:tripeaks_neue/stores/session.dart';
import 'package:tripeaks_neue/stores/settings.dart';
import 'package:tripeaks_neue/widgets/welcome_dialog.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final session = await Session.read();
  final settings = await Settings.read();
  runApp(
    MultiProvider(
      providers: [Provider<Session>(create: (_) => session), Provider<Settings>(create: (_) => settings)],
      builder: (context, _) => MainApp(session, settings),
    ),
  );
}

class MainApp extends StatefulWidget {
  const MainApp(this.session, this.settings, {super.key});

  final Session session;
  final Settings settings;

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  late final AppLifecycleListener _listener;

  @override
  void initState() {
    super.initState();
    _listener = AppLifecycleListener(onPause: _onPause, onExitRequested: _onExitRequested);
    widget.settings.sounds.load();
  }

  @override
  void dispose() {
    _listener.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final settings = Provider.of<Settings>(context);
    var showWelcome = settings.firstRun;
    if (showWelcome) {
      settings.ran();
      settings.write();
    }
    return Observer(
      builder:
          (context) => MaterialApp(
            localizationsDelegates: [AppLocalizations.delegate],
            debugShowCheckedModeBanner: false,
            title: "TriPeaks NEUE",
            supportedLocales: [Locale("en")],
            themeMode: settings.themeMode,
            theme: _defaultLight,
            darkTheme: _defaultDark,
            scrollBehavior: const MyCustomScrollBehavior(),
            home: Builder(
              builder: (context) {
                if (showWelcome) {
                  showWelcome = false;
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    showDialog(
                      context: context,
                      builder: (context) => const WelcomeDialog(),
                      barrierDismissible: true,
                      barrierColor: Colors.transparent,
                    );
                  });
                }
                return HomePage();
              },
            ),
          ),
    );
  }

  static final _tooltipTheme = TooltipThemeData(waitDuration: Durations.long4, preferBelow: false);

  static final _defaultLight = ThemeData(
    useMaterial3: true,
    tooltipTheme: _tooltipTheme,
    pageTransitionsTheme: PageTransitionsTheme(
      builders: Map<TargetPlatform, PageTransitionsBuilder>.fromIterable(
        TargetPlatform.values,
        value: (_) => const FadeForwardsPageTransitionsBuilder(),
      ),
    ),
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.blueAccent,
      tertiary: Colors.red.shade500,
      tertiaryContainer: Colors.red.shade600,
    ),
  );

  static final _defaultDark = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    tooltipTheme: _tooltipTheme,
    pageTransitionsTheme: PageTransitionsTheme(
      builders: Map<TargetPlatform, PageTransitionsBuilder>.fromIterable(
        TargetPlatform.values,
        value: (_) => const FadeForwardsPageTransitionsBuilder(),
      ),
    ),
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.blueAccent,
      tertiary: Colors.red.shade300,
      tertiaryContainer: Colors.red.shade600, // Color(0xff932e2e),
      surfaceContainer: Color(0xff151618),
      brightness: Brightness.dark,
    ),
  );

  void _onPause() => _onPauseAsync();

  Future<void> _onPauseAsync() async {
    await widget.session.write();
    await widget.settings.write();
  }

  Future<AppExitResponse> _onExitRequested() async {
    await widget.session.write();
    await widget.settings.write();
    widget.settings.dispose();
    return AppExitResponse.exit;
  }
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  const MyCustomScrollBehavior();

  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
    PointerDeviceKind.touch,
    PointerDeviceKind.mouse,
    // etc.
  };
}
