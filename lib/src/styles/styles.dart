import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyStyles {
  //Queries
  static double deviceHieight(BuildContext context) =>
      MediaQuery.of(context).size.height;

  static double deviceWidth(BuildContext context) =>
      MediaQuery.of(context).size.width;
  static double buttonWidth(BuildContext context) =>
      MediaQuery.of(context).size.width * .8;

  static double buttonHeight = 55;

  //All Application Colours
  static Color white = const Color(0xffFFFFFF);
  static Color primaryPurple = const Color(0xff3D0040);
  static Color gradientGreen = const Color(0xff00E4AE);
  static Color primaryGreen = const Color(0xff0CC393);
  static Color backgroundColour = Colors.black;
  static Color primaryGrey = const Color(0xff282828);
  static Color darkGrey = const Color(0xff0F0F0F);
  static Color active = const Color(0xffBCFFC3);
  static Color gold = const Color(0xffE9BE00);
  static Color listeningColor = const Color(0xffB3B2FF);
  static Color faintRed = const Color(0xffFFA9A9);

  //General goodle font

  //static TextStyle headerOne = GoogleFonts.getFont('Manrope', fontSize: 20, color: darkGrey);

  static TextStyle headerOne = GoogleFonts.getFont(
    'Manrope',
    fontSize: 20,
    color: darkGrey,
  );
  static TextStyle headerOneW = GoogleFonts.getFont(
    'Manrope',
    fontSize: 20,
    color: white,
  );

  static TextStyle buttonText = GoogleFonts.getFont(
    'Manrope',
    fontSize: 16,
  );
  static TextStyle bodyText = GoogleFonts.getFont(
    'Manrope',
    fontSize: 14,
    color: Colors.black,
  );
  static TextStyle bodyTextSmall = GoogleFonts.getFont(
    'Manrope',
    fontSize: 10,
    color: Colors.black,
  );
  static TextStyle bodyTextBold = GoogleFonts.getFont('Manrope',
      fontSize: 14, color: Colors.black, fontWeight: FontWeight.bold);

  // Spacing
  static SizedBox verticalSpaceZero = const SizedBox(
    height: 10,
  );
  static SizedBox horizontalSpaceZero = const SizedBox(
    width: 10,
  );
  static SizedBox verticalSpaceOne = const SizedBox(
    height: 20,
  );
  static SizedBox verticalSpaceTwo = const SizedBox(
    height: 30,
  );
  static SizedBox horizontalSpaceOne = const SizedBox(
    width: 20,
  );
  static SizedBox horizontalSpaceTwo = const SizedBox(
    width: 30,
  );

  //Border Radius
  static BorderRadius myBorderRadius = BorderRadius.circular(500);
}
