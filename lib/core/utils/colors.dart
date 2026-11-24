import 'package:flutter/material.dart';

abstract class AppColors {
  static bool isLightTheme = true;

  static const Color primaryBlue1 = Color(0xFF254D99);
  static const Color primaryBlue2 = Color(0xFF549DD6);
  static const Color primaryBlue3 = Color(0xFFF1F5FF);
  static const Color primaryBlue4 = Color(0xFF82A5F6);
  static const Color secondaryBlue1 = Color(0xFFE9EDF5);
  static const Color secondaryBlue1OPacity70 = Color(0xB6254E99);

  static const Color secondaryGrey1 = Color(0xFFEEEEEE);
  static const Color secondaryGrey2 = Color(0xFFDBDBDB);
  static const Color secondaryGrey3 = Color(0xFFA3A3A3);
  static const Color secondaryGrey4 = Color(0xFF5C5C5C);
  static const Color secondaryGrey5 = Color(0xFF616161);
  static const Color blackColor = Color(0xFF1C1C1C);

  static const Color statusColorTextCyan = Color(0xFF44A6F3);
  static const Color statusColorTextRed = Color(0xFFFF4747);
  static const Color statusColorTextViolet = Color(0xFF9266FF);
  static const Color statusColorTextYellow = Color(0xFFFA9E00);
  static const Color statusColorTextGreen = Color(0xFF178E1E);
  static const Color statusSurgeryCompleted = Color(0xFF16796D);
  static const Color bannerTextColor = Color(0xFFAD6F03);

  static const Color statusColorBackgoundLightCyan = Color(0xFFE5F3FF);
  static const Color statusColorBackgoundLightRed = Color(0xFFFDE3E3);
  static const Color statusColorBackgoundLightViolet = Color(0xFFF0EBFF);
  static const Color statusColorBackgoundLightYellow = Color(0xFFFFF0D6);
  static const Color statusColorBackgoundLightGreen = Color(0xFFDAF2DB);

  static const Color grey = Color(0xFFF5F5F5);
  static const Color greyShade = Color(0xFFE0E0E0);
  static const Color blueGrey = Color(0xFFCFD8DC);
  static const Color white = Color(0xFFFFFFFF);
  static const boxShadowColor = Color(0x14000000);
  static const Color greyShadeBackground = Color(0xFFFAFAFA);
  static const Color dataTableBackground = Color(0xFFF7F7F7);
  static const Color yellowShade = Color(0xFFFFEFD5);
  static const Color orange = Color(0xFFFF9800);
  static const Color orangeShade = Color(0xFFFFF3E0);
  static const Color green = Color(0xFF4CAF50);
  static const Color greenShade = Color(0xFFE8F5E9);
  static const Color versionText = Color(0xFFCECECE);
  static const Color lightBlueShade = Color(0xFFF1F5FF);
  static const Color vitalsNormal = Color(0xFF008000);
  static const Color vitalsAlert = Color(0xFFD3E204);
  static const Color vitalsAbnormal = Color(0xFFFFA500);
  static const Color vitalsPanic = Color(0xFFFF0000);
  static const Color chipBlue = Color(0xFF5B9BD5);

//#
  static const Color red = Color(0xFFFF0000);
  static const Color pinkShade = Color(0xFFFDE3E3);
  static const Color blue = Color(0xFF2196F3);
  static const Color redShade = Color(0xFFFFCDD2);
  static const Color blueShade = Color(0xFFBBDEFB);
  static const Color purpleShade = Color(0xFFE1BEE7);
  static const Color purple = Color(0xFF9C27BD);
  static const Color lightCyan = Color(0xFFCBE2F5);
  static const Color lightGreen = Color(0xFFDDF5E7);
  static const Color lightRed = Color(0xFFF8B8B8);
  static const Color dismissibleBar = Color(0xFFE0E0E0);
  static const Color hintTextColor = Color(0xFF656565);
  static const Color textPrimary = Color(0xFF0C1421);
  static const Color textSecondary = Color(0xFF313957);
  static const Color textDisabled = Color(0xFF959CB6);

  static const Color textColorMain = Color(0xFF1C1C1C);
  static const Color black = Color(0xFF000000);
  static const Color transparent = Colors.transparent;
  static const Color dividerColor = Color(0xFFD6D6D6);
  static const Color shadowColor = Color(0xFF2D9FFF);
  static const Color goToTopBorderColor = Color(0xFFB6DFFF);
  static const Color oswaldColor = Color(0xFF1A40C7);

  static Color get regularTextColor => isLightTheme ? textColorMain : white;

  static const Color borderColor = Color(0xFFBDBDBD);

  static Color get backgroundColor =>
      isLightTheme ? white : const Color(0x00ededed);

  static Color get textFieldColor =>
      isLightTheme ? const Color(0xFFCCCCCC) : const Color(0xFF343434);

  static Color get appBarTextColor => isLightTheme ? primaryBlue1 : white;

  static Color get skeletonBaseColor => isLightTheme ? black : white;
}
