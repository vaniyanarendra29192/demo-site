import 'package:flutter/material.dart';

import '../../core/utils/utils_import.dart';

class AppInkWell extends StatelessWidget {
  final GestureTapCallback? onTap;
  final GestureTapDownCallback? onTapDown;
  final Widget child;
  final Color highlightColor;
  final Color splashColor;
  final bool enableSplash;
  final double radius;

  const AppInkWell(
      {required this.child,
      this.onTap,
      this.onTapDown,
      this.highlightColor = AppColors.transparent,
      this.splashColor = AppColors.primaryBlue1,
      this.enableSplash = false,
      this.radius = 0,
      super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(radius),
      onTapDown: onTapDown,
      splashColor: enableSplash ? splashColor : AppColors.transparent,
      highlightColor: enableSplash ? highlightColor : AppColors.transparent,
      child: child,
    );
  }
}
