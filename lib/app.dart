import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:prayer/constants/router.dart';
import 'package:prayer/constants/theme.dart';
import 'package:prayer/generated/l10n.dart';
import 'package:themed/themed.dart';

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(AppRouter.routerProvider);

    return PlatformProvider(
      settings: PlatformSettingsData(
        legacyIosUsesMaterialWidgets: true,
        iosUsesMaterialWidgets: true,
      ),
      builder: (context) => Themed(
        child: PlatformTheme(
          themeMode: ThemeMode.dark,
          materialDarkTheme: darkThemeData,
          cupertinoDarkTheme: cupertinoDarkTheme,
          builder: (context) => PlatformApp.router(
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              S.delegate,
            ],
            supportedLocales: S.delegate.supportedLocales,
            routerConfig: router,
            builder: (context, child) => Material(child: child),
          ),
        ),
      ),
    );
  }
}
