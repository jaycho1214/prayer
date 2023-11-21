import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:themed/themed.dart';

final darkThemeData = ThemeData.dark().copyWith(
  buttonTheme: const ButtonThemeData(
    buttonColor: Color.fromRGBO(10, 10, 10, 1.0),
  ),
  colorScheme: const ColorScheme.dark().copyWith(
    background: Color.fromARGB(255, 0, 0, 0),
  ),
  splashColor: Colors.transparent,
);

const darkDefaultCupertinoTheme =
    CupertinoThemeData(brightness: Brightness.dark);

final cupertinoDarkTheme = MaterialBasedCupertinoThemeData(
  materialTheme: darkThemeData.copyWith(
    cupertinoOverrideTheme: darkDefaultCupertinoTheme.copyWith(
        textTheme: darkDefaultCupertinoTheme.textTheme.copyWith(
      textStyle: darkDefaultCupertinoTheme.textTheme.textStyle.copyWith(
        color: Colors.white,
        textBaseline: TextBaseline.ideographic,
      ),
    )),
  ),
);

Map<ThemeRef, Object> lightTheme = {};

class MyTheme {
  static const primary = ColorRef(Color(0xFF301934));
  static const fab = ColorRef(Color(0xEF562D5D));
  static const onPrimary = ColorRef(Color.fromRGBO(245, 245, 245, 1.0));
  static const outline = ColorRef(Color(0xFF696969));
  static const surface = ColorRef(Color.fromRGBO(10, 10, 10, 1.0));
  static const surfaceContainer = ColorRef(Color(0xFF301934));
  static const surfaceDim = ColorRef(Color(0xFF241320));
  static const inverseSurface = ColorRef(Color(0xFF2A3439));

  static const sheetSurface = ColorRef(Color(0xFF000000));
  static const sheetSurfaceContainer = ColorRef(Color(0xFF1c1c1c));

  static const error = ColorRef(Colors.red);
  static const disabled = ColorRef(Color(0xFF2F4F4F));
}
