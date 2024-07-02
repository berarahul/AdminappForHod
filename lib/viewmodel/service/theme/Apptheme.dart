import 'package:flutter/material.dart';

import 'AppCheapTheme.dart';
import 'AppTextTheme.dart';
import 'AppbarTheme.dart';
import 'ButtomSheetTheme.dart';
import 'CheckBoxTheme.dart';
import 'OutlinebuttonTheme.dart';
import 'TextFieldTheme.dart';
class AppTheme{
  AppTheme._();
  static ThemeData lightTheme= ThemeData(

    useMaterial3: true,
    fontFamily: 'poppins',
    brightness: Brightness.light,
    primaryColor: Colors.blue,
    scaffoldBackgroundColor: Colors.white,
    textTheme: AppTexttheme.lightTexttheme,
    chipTheme: CheapTheme.lightChipTheme,
    appBarTheme: AppbarTheme.lightAppBarTheme,
    checkboxTheme: CheckBoxTheme.lightCheckboxTheme,
    bottomSheetTheme: ButtomsheetTheme.lightbuttomsheet,
    // elevatedButtonTheme: ElevatedButtonTheme.lightElevatedButtonTheme,
    outlinedButtonTheme: OutLineButtonTheme.lightOutLinedButtonTheme,
    inputDecorationTheme: TextFieldTheme.lightTextField,

  );
  static ThemeData darkTheme= ThemeData(
    useMaterial3: true,
    fontFamily: 'poppins',
    brightness: Brightness.dark,
    primaryColor: Colors.blue,
    scaffoldBackgroundColor: Colors.black,
    textTheme: AppTexttheme.darkTexttheme,
    chipTheme: CheapTheme.darkChipTheme,
    appBarTheme: AppbarTheme.darkAppBarTheme,
    checkboxTheme: CheckBoxTheme.darkCheckboxTheme,
    bottomSheetTheme: ButtomsheetTheme.darkbuttomsheet,
    // elevatedButtonTheme: ElevatedButtonTheme.darkElevatedButtonTheme,
    outlinedButtonTheme: OutLineButtonTheme.darkOutLinedButtonTheme,
    inputDecorationTheme: TextFieldTheme.darkTextField,
  );

}