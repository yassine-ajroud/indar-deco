import 'package:flutter/material.dart';
import 'package:indar_deco/core/styles/colors.dart';

class AppTheme{
  static ThemeData lightTheme = ThemeData(
     appBarTheme:const AppBarTheme(backgroundColor: AppColors.bgColor,elevation: 0,iconTheme:IconThemeData(color: AppColors.black),
      surfaceTintColor: Colors.transparent,centerTitle: true,
      ),
     scaffoldBackgroundColor: AppColors.bgColor
  );
}