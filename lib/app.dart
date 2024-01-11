import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:prayer/constants/router.dart';
import 'package:prayer/constants/theme.dart';
import 'package:prayer/i18n/strings.g.dart';

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(AppRouter.routerProvider);

    return ValueListenableBuilder(
      valueListenable: Hive.box('settings').listenable(keys: ['theme']),
      builder: (context, box, _) {
        return PlatformProvider(
          settings: PlatformSettingsData(
            legacyIosUsesMaterialWidgets: true,
            iosUsesMaterialWidgets: true,
          ),
          builder: (context) => PlatformTheme(
            themeMode:
                box.get('theme') == 'dark' ? ThemeMode.dark : ThemeMode.light,
            materialLightTheme: lightThemeData,
            cupertinoLightTheme: lightDefaultCupertinoTheme,
            materialDarkTheme: darkThemeData,
            cupertinoDarkTheme: darkDefaultCupertinoTheme,
            builder: (context) => PlatformApp.router(
              localizationsDelegates: const [
                GlobalMaterialLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
              ],
              locale: TranslationProvider.of(context).flutterLocale,
              supportedLocales: AppLocaleUtils.supportedLocales,
              routerConfig: router,
              builder: (context, child) => Material(child: child),
            ),
          ),
        );
      },
    );
  }
}
