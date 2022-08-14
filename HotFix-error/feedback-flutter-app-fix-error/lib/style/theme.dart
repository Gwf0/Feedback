import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FeedbackTheme {
  static const double elementSpacing = 16;

  static const Color feedbackRed = Color(0xFFff272b);
  static const Color feedbackWhite = Color.fromARGB(255, 255, 255, 255);
  static const Color feedbackBlack = Color(0xFF3E3D3D);
  static const Color feedbackLightGrey = Color(0xFFE6E7E8);
  static const Color feedbackGrey = Color(0xFF707070);
  static const Color feedbackOrange = Color(0xFFE39219);

  static ThemeData theme = ThemeData(
    appBarTheme: AppBarTheme(
      color: feedbackRed,
      //foregroundColor: Colors.black,
      systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: feedbackRed),
    ),
    tabBarTheme: TabBarTheme(
      indicator: UnderlineTabIndicator(
        borderSide: BorderSide(color: feedbackWhite, width: 2.0),
      ),
    ),
    colorScheme: ColorScheme.light(primary: feedbackRed),
    primaryColor: feedbackRed,
    backgroundColor: feedbackWhite,
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      selectedItemColor: feedbackRed,
      unselectedItemColor: feedbackBlack,
    ),
    progressIndicatorTheme:
        const ProgressIndicatorThemeData(color: Color(0xFFff272b)),
    buttonTheme: const ButtonThemeData(
      buttonColor: feedbackRed,
      textTheme: ButtonTextTheme.primary,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(primary: feedbackRed),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        primary: feedbackRed,
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        primary: feedbackRed,
      ),
    ),
  );
}
