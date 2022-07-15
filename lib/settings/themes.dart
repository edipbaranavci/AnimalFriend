import 'package:flutter/material.dart';

class CustomThemes {
  static ThemeData light() {
    return ThemeData.light().copyWith(
      hintColor: Colors.purple[200],
      primaryColor: Colors.purple,
      colorScheme: const ColorScheme.light(
          background: Colors.white, primary: Colors.black, error: Colors.red),
      listTileTheme: CustomObjectStyles.lisTileThemeData(Colors.purple),
      textTheme: CustomObjectStyles.textThemeColors(Colors.purple),
      scaffoldBackgroundColor: Colors.transparent,
      brightness: Brightness.light,
      elevatedButtonTheme: CustomObjectStyles.elevatedButtonStyle(),
    );
  }
}

class CustomObjectStyles {
  static ListTileThemeData lisTileThemeData(Color color) {
    return ListTileThemeData(iconColor: color);
  }

  static TextTheme textThemeColors(Color? color) {
    TextStyle textStyle = TextStyle(color: color);
    return const TextTheme().copyWith(
      headline6: textStyle,
      headline5: textStyle,
      headline4: textStyle,
      headline3: textStyle,
      headline2: textStyle,
      headline1: textStyle,
      bodyText1: textStyle,
      bodyText2: textStyle,
      subtitle1: textStyle,
      subtitle2: textStyle,
    );
  }

  static ElevatedButtonThemeData? elevatedButtonStyle() =>
      ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
        primary: Colors.white,
        elevation: 40,
        shadowColor: Colors.purple,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        padding: const EdgeInsets.all(10),
      ));
}
