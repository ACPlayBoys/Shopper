import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MTheme {
  static ThemeData lightTheme(BuildContext context) => ThemeData(
        primarySwatch: Colors.amber,
        canvasColor: Colors.white,
        fontFamily: GoogleFonts.lato().fontFamily,
        primaryColor: Colors.amberAccent,
        backgroundColor: Colors.amber[50],
        primaryTextTheme: GoogleFonts.latoTextTheme(),
        accentTextTheme: GoogleFonts.pacificoTextTheme(),
        cardColor: MTheme.creamColor,
        
      );

  static ThemeData darkTheme(BuildContext context) => ThemeData(
        brightness: Brightness.dark,
        fontFamily: GoogleFonts.poppins().fontFamily,
        appBarTheme: AppBarTheme(
          elevation: 0.0,
        ),
      );

  static Color creamColor = Color(0xfff5f5f5);
  static Color darkBluish = Color(0xff403b58);
}
