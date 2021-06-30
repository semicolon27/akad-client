import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

// Color scheme
const Color colorPrimary = Color(0xff2278ff);
const Color colorPrimaryVariant = Color(0xff6200EE);
const Color colorOnPrimary = Color(0xff3700B3);
const Color colorBorder = Color(0xffd4d4d4);

const Color colorSecondary = Color(0xffffffff);
const Color colorSecondaryVariant = Color(0xff018786);
const Color colorOnSecondary = Color(0xff000000);

const Color colorTextPrimary = Color(0xff313444);
const Color colorTextSecondary = Color(0xff5c6573);
const Color colorTextLight = Color(0xfffbfbfb);
const Color colorTextHint = Color(0xff717171);

const Color colorCreditIcon = Color(0xff8bd838);
const Color colorDebitIcon = Color(0xfff24630);

const Color colorTextButtonPrimary = Color(0xffffffff);
const Color colorTextButtonSecondary = Color(0xffffffff);

const Color colorBackgroundGrey = Color(0xffF7F8FA);
// sizing
const defaultAppbarSize = 60.0;
BorderRadius defaultBorderRadius = BorderRadius.circular(10);

const kPrimaryColor = Color(0xFF366CF6);
const kSecondaryColor = Color(0xFFF5F6FC);
const kBgLightColor = Color(0xFFF2F4FC);
const kBgDarkColor = Color(0xFFEBEDFA);
const kBadgeColor = Color(0xFFEE376E);
const kGrayColor = Color(0xFF8793B2);
const kBorderColor = Color(0xFFEEF0F3);
const kBorderBlueColor = Color(0xFF1E67DB);
const kTitleTextColor = Color(0xFF30384D);
const kTextColor = Color(0xFF4D5875);
const kSidebarExtend = Color(0xff1E67DB);
const kSidebarExtend1 = Color(0xff1E67DB);

double kDefaultPadding = 20.0.sp;
const double kAppbarHeight = 70;

// styling card / container
const List<BoxShadow> defaultCardShadow = [
  BoxShadow(
    color: Color.fromRGBO(0, 0, 0, 0.15),
    offset: Offset(0, 3),
    blurRadius: 8,
    spreadRadius: 0,
  ),
];

const List<BoxShadow> defaultPinShadow = [
  BoxShadow(
    color: Color(0x29000000),
    offset: Offset(0, 5),
    blurRadius: 2,
    spreadRadius: 0,
  ),
];

const double heightBetweenField = 15.0;

BoxDecoration defaultCardDecoration = BoxDecoration(
  color: colorSecondary,
  borderRadius: defaultBorderRadius,
  boxShadow: defaultCardShadow,
);

BoxDecoration flatCardDecoration = BoxDecoration(
  color: colorSecondary,
  borderRadius: defaultBorderRadius,
);

BoxDecoration mutasiCardDecoration = BoxDecoration(
  gradient: LinearGradient(
    stops: [0.015, 0.015],
    colors: [Color.fromRGBO(243, 243, 243, 1), Colors.white],
  ),
  borderRadius: BorderRadius.all(
    Radius.circular(5.0),
  ),
  boxShadow: [
    BoxShadow(
      color: Color.fromRGBO(207, 207, 207, 1),
      blurRadius: 1.0,
      spreadRadius: 1.0,
      offset: Offset(0.0, 0.0),
    ),
  ],
);

// Text / font styling
// ignore: must_be_immutable
class MainTextStyle extends TextStyle {
  static const bool fontScaling = false;
  static const double letterSpace = 0.5;
  static const double normalSize = 12.5;
  static const double normalh4Size = 11.5;
  static const double normalh3Size = 13.5;
  static const double boldSize = 15.5;

  static const double fontSizeH1 = 96.0;
  static const double fontSizeH2 = 60.0;
  static const double fontSizeH3 = 48.0;
  static const double fontSizeH4 = 34.0;
  static const double fontSizeH5 = 24.0;
  static const double fontSizeH6 = 20.0;
  static const double fontSizeSubtitle1 = 16.0;
  static const double fontSizeSubtitle2 = 14.0;
  static const double fontSizeBody1 = 16.0;
  static const double fontSizeBody2 = 14.0;
  static const double fontSizeButton = 14.0;
  static const double fontSizeCaption = 12;
  static const double fontSizeOverline = 10;

  static const double letterSpaceH1 = -1.5;
  static const double letterSpaceH2 = -0.5;
  static const double letterSpaceH3 = 0;
  static const double letterSpaceH4 = 0.25;
  static const double letterSpaceH5 = 0;
  static const double letterSpaceH6 = 0.15;
  static const double letterSpaceSubtitle1 = 0.15;
  static const double letterSpaceSubtitle2 = 0.1;
  static const double letterSpaceBody1 = 0.5;
  static const double letterSpaceBody2 = 0.25;
  static const double letterSpaceButton = 1.25;
  static const double letterSpaceCaption = 0.4;
  static const double letterSpaceOverline = 1.5;

  TextStyle textStyleH1 = GoogleFonts.nunito(
    color: colorTextPrimary,
    letterSpacing: letterSpaceH1,
    fontSize: fontSizeH1.sp,
    fontWeight: FontWeight.w300,
  );

  TextStyle textStyleH2 = GoogleFonts.nunito(
    color: colorTextPrimary,
    letterSpacing: letterSpaceH2,
    fontSize: fontSizeH2.sp,
    fontWeight: FontWeight.w300,
  );

  TextStyle textStyleH3 = GoogleFonts.nunito(
    color: colorTextPrimary,
    letterSpacing: letterSpaceH3,
    fontSize: fontSizeH3.sp,
    fontWeight: FontWeight.normal,
  );

  TextStyle textStyleH4 = GoogleFonts.nunito(
    color: colorTextPrimary,
    letterSpacing: letterSpaceH4,
    fontSize: fontSizeH4.sp,
    fontWeight: FontWeight.normal,
  );

  TextStyle textStyleH5 = GoogleFonts.nunito(
    color: colorTextPrimary,
    letterSpacing: letterSpaceH5,
    fontSize: fontSizeH5.sp,
    fontWeight: FontWeight.w100,
  );

  TextStyle textStyleH6 = GoogleFonts.nunito(
    color: colorTextPrimary,
    letterSpacing: letterSpaceH6,
    fontSize: fontSizeH6.sp,
    fontWeight: FontWeight.w500,
  );

  TextStyle textStyleSubtitle1 = GoogleFonts.nunito(
    color: colorTextPrimary,
    letterSpacing: letterSpaceSubtitle1,
    fontSize: fontSizeSubtitle1.sp,
    fontWeight: FontWeight.normal,
  );

  TextStyle textStyleSubtitle2 = GoogleFonts.nunito(
    color: colorTextSecondary,
    letterSpacing: letterSpaceSubtitle2,
    fontSize: fontSizeSubtitle2.sp,
    fontWeight: FontWeight.w500,
  );

  TextStyle textStyleBody1 = GoogleFonts.nunito(
    color: colorTextPrimary,
    letterSpacing: letterSpaceBody1,
    fontSize: fontSizeBody1.sp,
    fontWeight: FontWeight.w500,
  );

  TextStyle textStyleBody2 = GoogleFonts.nunito(
    color: colorTextSecondary,
    letterSpacing: letterSpaceBody1,
    fontSize: fontSizeBody1.sp,
    fontWeight: FontWeight.normal,
  );

  TextStyle textStyleButton = GoogleFonts.nunito(
    color: colorTextButtonPrimary,
    letterSpacing: letterSpaceButton,
    fontSize: fontSizeButton.sp,
    fontWeight: FontWeight.w500,
  );

  TextStyle textStyleCaption = GoogleFonts.nunito(
    color: colorTextPrimary,
    letterSpacing: letterSpaceCaption,
    fontSize: fontSizeCaption.sp,
    fontWeight: FontWeight.normal,
  );

  TextStyle textStyleOverline = GoogleFonts.nunito(
    color: colorTextPrimary,
    letterSpacing: letterSpaceOverline,
    fontSize: fontSizeOverline.sp,
    fontWeight: FontWeight.normal,
  );
}

MainTextStyle textStyle = MainTextStyle();
ScreenUtil scUtil = ScreenUtil();

dynamic setHeight(double height) {
  return scUtil.setHeight(height);
}

dynamic setWidth(double width) {
  return scUtil.setWidth(width);
}
