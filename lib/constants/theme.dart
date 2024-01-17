import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

final lightColorScheme = ColorScheme.light(
  background: Colors.white,
  onBackground: Colors.black,
  outline: Color(0xFF696969),
  outlineVariant: Color(0xFFD4D4D4),
  primary: Colors.black,
  onPrimary: Colors.white,
  secondary: Color(0xFFE1E1E2),
  onSecondary: Colors.black,
  surface: Colors.black,
  onSurface: Colors.white,
  inverseSurface: Colors.white,
  onInverseSurface: Colors.black,
  inversePrimary: Colors.white,
  scrim: Colors.black.withAlpha(50),
  error: Colors.red,
  onError: Colors.white,
  errorContainer: Color(0xFF98817B),
  onErrorContainer: Colors.white,
);

final lightThemeData = ThemeData.light().copyWith(
  colorScheme: lightColorScheme,
  bottomSheetTheme: BottomSheetThemeData(
    modalBarrierColor: lightColorScheme.scrim,
    backgroundColor: Color(0xFFFAFAFA),
  ),
  dividerTheme: DividerThemeData(color: lightColorScheme.outlineVariant),
  textTheme: TextTheme(
    displayLarge: TextStyle(
      fontWeight: FontWeight.w900,
      fontSize: 30,
    ),
    displayMedium: TextStyle(
      fontWeight: FontWeight.w900,
      fontSize: 25,
    ),
    displaySmall: TextStyle(
      fontWeight: FontWeight.w900,
      fontSize: 17,
    ),
    headlineLarge: TextStyle(),
    headlineMedium: TextStyle(),
    headlineSmall: TextStyle(fontWeight: FontWeight.w900, fontSize: 20),
    titleLarge: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
    titleMedium: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
    titleSmall: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
    bodyLarge: TextStyle(fontSize: 18),
    bodyMedium: TextStyle(fontSize: 14),
    bodySmall: TextStyle(),
  ).apply(bodyColor: Colors.black, displayColor: Colors.black).copyWith(
        labelLarge: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold,
          color: Color(0xFF737579),
        ),
        labelMedium: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.normal,
          color: Color(0xFF737579),
        ),
        labelSmall: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w400,
          color: Color(0xFF737579),
        ),
      ),
  searchBarTheme: SearchBarThemeData(
    backgroundColor: MaterialStatePropertyAll(Colors.transparent),
    shadowColor: const MaterialStatePropertyAll(Colors.transparent),
    elevation: const MaterialStatePropertyAll(0.0),
    side: MaterialStatePropertyAll(BorderSide(color: lightColorScheme.outline)),
    textStyle: MaterialStatePropertyAll(
        TextStyle(color: lightColorScheme.onBackground, fontSize: 13)),
    hintStyle: MaterialStatePropertyAll(TextStyle(color: Color(0xFF737579))),
  ),
  listTileTheme: ListTileThemeData(
    dense: true,
  ),
  inputDecorationTheme:
      InputDecorationTheme(counterStyle: TextStyle(color: Color(0xFF737579))),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: Color(0xCF8c1c13),
    foregroundColor: Colors.white,
  ),
  tabBarTheme: TabBarTheme(
    labelStyle: TextStyle(
      color: lightColorScheme.onBackground,
      fontWeight: FontWeight.w800,
      fontSize: 13,
    ),
    unselectedLabelStyle: TextStyle(
      color: Color(0xFF737579),
      fontWeight: FontWeight.w800,
      fontSize: 13,
    ),
    dividerColor: Color(0xFF696969),
  ),
  iconTheme: IconThemeData(
    color: lightColorScheme.onBackground,
    size: 15,
  ),
  scaffoldBackgroundColor: lightColorScheme.background,
  appBarTheme: AppBarTheme(
    backgroundColor: lightColorScheme.background,
    foregroundColor: lightColorScheme.background,
    surfaceTintColor: lightColorScheme.background,
  ),
  disabledColor: Color(0xFF737579),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    selectedItemColor: lightColorScheme.onBackground,
    unselectedItemColor: Color(0xFF737579),
  ),
);

final lightDefaultCupertinoTheme =
    MaterialBasedCupertinoThemeData(materialTheme: lightThemeData).copyWith(
  scaffoldBackgroundColor: lightColorScheme.background,
);

final darkColorScheme = ColorScheme.dark(
  background: Colors.black,
  onBackground: Colors.white,
  outline: Color(0xFF696969),
  outlineVariant: Color(0xFF2F4F4F),
  primary: Colors.white,
  onPrimary: Colors.black,
  secondary: Color(0xFF2E002E),
  onSecondary: Colors.black,
  surface: Colors.white,
  onSurface: Colors.black,
  inverseSurface: Colors.black,
  onInverseSurface: Colors.white,
  inversePrimary: Colors.black,
  scrim: Colors.white.withAlpha(50),
  error: Colors.red,
  onError: Colors.white,
  errorContainer: Color(0xFF98817B),
  onErrorContainer: Colors.white,
);

final darkThemeData = lightThemeData.copyWith(
  brightness: Brightness.dark,
  colorScheme: darkColorScheme,
  canvasColor: Color(0xFF003262),
  bottomSheetTheme: BottomSheetThemeData(
    modalBarrierColor: darkColorScheme.scrim,
    backgroundColor: Color(0xFF000000),
  ),
  searchBarTheme: lightThemeData.searchBarTheme.copyWith(
    side: MaterialStatePropertyAll(BorderSide(color: darkColorScheme.outline)),
    textStyle: MaterialStatePropertyAll(
        TextStyle(color: darkColorScheme.onBackground, fontSize: 13)),
    hintStyle: MaterialStatePropertyAll(TextStyle(color: Color(0xFF737579))),
  ),
  dividerTheme: DividerThemeData(color: darkColorScheme.outlineVariant),
  textTheme: lightThemeData.textTheme
      .apply(bodyColor: Colors.white, displayColor: Colors.white)
      .copyWith(
        labelLarge: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold,
          color: Color(0xFF737579),
        ),
        labelMedium: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.normal,
          color: Color(0xFF737579),
        ),
        labelSmall: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w400,
          color: Color(0xFF737579),
        ),
      ),
  inputDecorationTheme:
      InputDecorationTheme(counterStyle: TextStyle(color: Color(0xFF737579))),
  appBarTheme: AppBarTheme(
    backgroundColor: darkColorScheme.background,
    foregroundColor: darkColorScheme.background,
    surfaceTintColor: darkColorScheme.background,
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: Color(0xCF7BAFD4),
    foregroundColor: Colors.white,
  ),
  iconTheme: lightThemeData.iconTheme.copyWith(
    color: darkColorScheme.onBackground,
  ),
  scaffoldBackgroundColor: darkColorScheme.background,
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    selectedItemColor: darkColorScheme.onBackground,
    unselectedItemColor: Color(0xFF737579),
  ),
  tabBarTheme: TabBarTheme(
    labelStyle: TextStyle(
      color: darkColorScheme.onBackground,
      fontWeight: FontWeight.w800,
      fontSize: 13,
    ),
    unselectedLabelStyle: TextStyle(
      color: Color(0xFF737579),
      fontWeight: FontWeight.w800,
      fontSize: 13,
    ),
    dividerColor: Color(0xFF696969),
  ),
  checkboxTheme: CheckboxThemeData(side: BorderSide(color: Color(0xFF737579))),
);

final darkDefaultCupertinoTheme =
    MaterialBasedCupertinoThemeData(materialTheme: darkThemeData).copyWith(
  scaffoldBackgroundColor: darkColorScheme.background,
  barBackgroundColor: darkColorScheme.background,
  textTheme: CupertinoTextThemeData(
    navTitleTextStyle: TextStyle(
      inherit: true,
      color: darkColorScheme.onBackground,
      fontWeight: FontWeight.bold,
      fontSize: 17,
    ),
  ),
);
