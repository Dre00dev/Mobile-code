import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
//making a dark mode theme for the app screens in the future allow to set theme light vs dark but i like dark.
//will set appTheme as theme in main 
abstract class AppColors{
  static const darkModeBackground = Color(0xff030f3f);//(0xFF0f153a);
  static const darkModeCardColor = Color(0xFF1b1a4a);
  static const darkModeCategoryColor = Color(0xFF7F6446);
  static const primaryWhiteColor = Color(0xFFF7F7F7);
  static const headerTextColor = Color(0xFF333f67);// (0xFF466994);
  static const secondaryAccent = Color(0xFF3b67b5);
  static const categoryColor1 = Color(0xFFffd084);
  static const categoryColor2 = Color(0xFFb2f0fb);
  static const categoryColor3 = Color(0xFFfddddc);
  static const prettypurple1 = Color(0xFF5140f0);
  static const prettyblue1 = Color(0xFF2bcee6);
  static const errorRed =  Color(0xFFfc4445);
}
var appTheme = ThemeData(

  fontFamily: GoogleFonts.roboto().fontFamily,

  primaryColor: AppColors.darkModeBackground,
  backgroundColor: Colors.red,
  brightness: Brightness.light,
  scaffoldBackgroundColor: AppColors.darkModeBackground,
  bottomAppBarTheme: const BottomAppBarTheme(
    color: AppColors.darkModeCardColor,
  ),

  textTheme: const TextTheme(
    bodyText1: TextStyle(
      fontSize: 18,
      color:AppColors.primaryWhiteColor,
      ),
    bodyText2: TextStyle(
      fontSize: 16,
      color:AppColors.primaryWhiteColor,
      ),

  
    button: TextStyle(
      letterSpacing: 1.5,
      fontWeight: FontWeight.bold,
    ),
    headline1: TextStyle(
      fontWeight: FontWeight.bold,
    ),
    subtitle1: TextStyle(
      color: AppColors.primaryWhiteColor,
    ),
  ),
  buttonTheme: const ButtonThemeData(),
);