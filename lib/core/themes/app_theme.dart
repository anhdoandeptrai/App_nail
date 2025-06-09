import 'package:flutter/material.dart';
import 'app_color.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: Colors.white,
      primaryColor: AppColor.brandSupernova,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColor.brandSupernova,
        primary: AppColor.brandSupernova,
        secondary: AppColor.brandSun,
        background: Colors.white,
        brightness: Brightness.light,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.white,
        foregroundColor: AppColor.brandSupernova,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: AppTextStyle.title1,
        iconTheme: const IconThemeData(color: AppColor.brandSupernova),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColor.brandSupernova,
          foregroundColor: Colors.white,
          textStyle: AppTextStyle.bodyBold,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColor.brandSun,
          textStyle: AppTextStyle.body,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColor.brandSupernova),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: AppColor.brandSupernova,
            width: 2,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColor.brandSupernova),
        ),
        labelStyle: AppTextStyle.body,
        hintStyle: AppTextStyle.body,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 14,
        ),
        errorStyle: TextStyle(
          color: Colors.red,
          fontStyle: FontStyle.normal,
          fontSize: 13,
          fontWeight: FontWeight.normal,
        ),
      ),
      textTheme: TextTheme(
        displayLarge: AppTextStyle.largeTitle,
        headlineLarge: AppTextStyle.title1,
        headlineMedium: AppTextStyle.title2,
        headlineSmall: AppTextStyle.title3,
        titleLarge: AppTextStyle.headline,
        bodyLarge: AppTextStyle.body,
        bodyMedium: AppTextStyle.callout,
        bodySmall: AppTextStyle.subheadline,
        labelLarge: AppTextStyle.footnote,
        labelMedium: AppTextStyle.caption1,
        labelSmall: AppTextStyle.caption2,
      ),
      fontFamily: 'Roboto',
      dialogTheme: const DialogThemeData(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(18)),
        ),
      ),
    );
  }
}

class AppTextStyle {
  static const largeTitle = TextStyle(
    fontSize: 34,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );
  static const title1 = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );
  static const title2 = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );
  static const title3 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );
  static const headline = TextStyle(
    fontSize: 17,
    fontWeight: FontWeight.w600,
    color: Colors.black,
    fontStyle: FontStyle.italic,
  );
  static const body = TextStyle(
    fontSize: 17,
    fontWeight: FontWeight.normal,
    color: Colors.black,
  );
  static const bodyBold = TextStyle(
    fontSize: 17,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );
  static const callout = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: Colors.black,
  );
  static const subheadline = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w600,
    color: Colors.black,
    fontStyle: FontStyle.italic,
  );
  static const footnote = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.normal,
    color: Colors.black,
  );
  static const caption1 = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    color: Colors.black,
  );
  static const caption2 = TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.normal,
    color: Colors.black,
  );
}
