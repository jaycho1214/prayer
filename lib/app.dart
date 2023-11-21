import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:prayer/constants/router.dart';
import 'package:prayer/constants/theme.dart';
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
              DefaultMaterialLocalizations.delegate,
              DefaultWidgetsLocalizations.delegate,
              DefaultCupertinoLocalizations.delegate,
            ],
            routerConfig: router,
            builder: (context, child) => Material(child: child),
          ),
        ),
      ),
    );
  }
}
