part of 'helpers.dart';

class MyThemApp {
  static ThemeData themeData(BuildContext context) {
    return ThemeData.dark().copyWith(
      textTheme: GoogleFonts.robotoTextTheme().copyWith(
        headline1: GoogleFonts.roboto(
          color: kColorFontLight,
          fontSize: 24.sp,
          fontWeight: FontWeight.bold,
        ),
        headline2: GoogleFonts.roboto(
          color: kColorFontLight,
          fontSize: 22.sp,
          fontWeight: FontWeight.bold,
        ),
        headline3: GoogleFonts.roboto(
          color: kColorFontLight,
          fontSize: 20.sp,
          fontWeight: FontWeight.bold,
        ),
        headline4: GoogleFonts.roboto(
          color: kColorFontLight,
          fontSize: 18.sp,
          fontWeight: FontWeight.bold,
        ),
        headline5: GoogleFonts.roboto(
          color: kColorFontLight,
          fontSize: 16.sp,
          fontWeight: FontWeight.bold,
        ),
        headline6: GoogleFonts.roboto(
          color: kColorFontLight,
          fontSize: 14.sp,
          fontWeight: FontWeight.bold,
        ),
        subtitle1: GoogleFonts.roboto(
          color: kColorFontLight,
          fontSize: 18.sp,
        ),
        subtitle2: GoogleFonts.roboto(
          color: kColorFontLight,
          fontSize: 16.sp,
        ),
      ),
    );
  }
}
