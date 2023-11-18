import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:prayer/bloc/auth/authentication_bloc.dart';
import 'package:prayer/constants/router.dart';
import 'package:prayer/constants/theme.dart';
import 'package:prayer/repo/authentication_repository.dart';
import 'package:prayer/repo/group_repository.dart';
import 'package:prayer/repo/prayer_repository.dart';
import 'package:prayer/repo/user_repository.dart';
import 'package:themed/themed.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => AuthenticationRepository()),
        RepositoryProvider(create: (context) => UserRepository()),
        RepositoryProvider(create: (context) => GroupRepository()),
        RepositoryProvider(create: (context) => PrayerRepository()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthenticationBloc(
              authRepository: context.read<AuthenticationRepository>(),
              userRepository: context.read<UserRepository>(),
            ),
          )
        ],
        child: PlatformProvider(
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
                routerConfig: AppRouter.router,
                builder: (context, child) => Material(child: child),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
