import 'package:flutter/material.dart';

import 'colors.dart';
import 'dimens.dart';

String internetStatus = 'ConnectivityResult.none';

abstract class AppFontTextStyles {
  static const fontFamily = 'Ageo';

  static TextStyle textStyleSmall() => TextStyle(
      fontFamily: AppFontTextStyles.fontFamily,
      fontWeight: FontWeight.w400,
      fontSize: Dimens.fontSizeTwelve,
      color: AppColors.regularTextColor,
      overflow: TextOverflow.visible,
      letterSpacing: 0.07);

  static TextStyle textStyleMedium() => TextStyle(
      fontFamily: AppFontTextStyles.fontFamily,
      fontWeight: FontWeight.w400,
      fontSize: Dimens.fontSizeFourteen,
      color: AppColors.regularTextColor,
      overflow: TextOverflow.visible,
      letterSpacing: 0.07);

  static TextStyle textStyleLarge() => TextStyle(
      fontFamily: AppFontTextStyles.fontFamily,
      fontWeight: FontWeight.w400,
      fontSize: Dimens.fontSizeEighteen,
      color: AppColors.regularTextColor,
      overflow: TextOverflow.visible,
      letterSpacing: 0.07);

  static TextStyle textStyleBold() => TextStyle(
      fontFamily: AppFontTextStyles.fontFamily,
      fontWeight: FontWeight.w600,
      fontSize: Dimens.fontSizeEighteen,
      color: AppColors.regularTextColor,
      overflow: TextOverflow.visible,
      letterSpacing: 0.07);

  static TextStyle buttonTextStyle() => const TextStyle(
      fontFamily: AppFontTextStyles.fontFamily,
      fontWeight: FontWeight.w600,
      fontSize: Dimens.fontSizeSixteen,
      color: AppColors.white,
      overflow: TextOverflow.visible,
      letterSpacing: 0.07);

  static TextStyle appbarTextStyle() => TextStyle(
      fontFamily: AppFontTextStyles.fontFamily,
      fontWeight: FontWeight.w600,
      fontSize: Dimens.fontSizeEighteen,
      color: AppColors.appBarTextColor,
      overflow: TextOverflow.visible,
      letterSpacing: 0.07);

  static TextStyle get commonTextStyle => AppFontTextStyles.textStyleMedium()
      .copyWith(color: AppColors.hintTextColor);

  static TextStyle getLabelStyle(TextEditingController controller) {
    return controller.text.isEmpty
        ? AppFontTextStyles.textStyleMedium().copyWith(
            color: AppColors.secondaryGrey4,
          )
        : AppFontTextStyles.textStyleBold().copyWith(
            color: AppColors.primaryBlue1, fontSize: Dimens.fontSizeFourteen);
  }
}
