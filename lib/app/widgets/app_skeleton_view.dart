import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../core/utils/colors.dart';
import '../../core/utils/transition_duration.dart';

class AppSkeletonWrapper extends StatelessWidget {
  final Widget child;
  final Color? baseColor;
  final Color highlightColor;
  final Color containersColor;
  final Duration duration;
  final PaintingEffect? effect;
  final bool? ignoreContainers;
  final bool enabled;
  final double? textBoneBorderRadius;

  const AppSkeletonWrapper(
      {super.key,
      required this.child,
      this.baseColor,
      this.highlightColor = AppColors.white,
      this.containersColor = AppColors.secondaryGrey2,
      this.duration = TransitionDuration.slow,
      this.effect,
      this.ignoreContainers,
      this.enabled = true,
      this.textBoneBorderRadius});

  @override
  Widget build(BuildContext context) => Skeletonizer(
      containersColor: containersColor,
      effect: effect ??
          PulseEffect(
            from: AppColors.secondaryGrey2,
            to: AppColors.secondaryGrey1,
            duration: duration,
          ),
      ignoreContainers: ignoreContainers,
      enabled: enabled,
      textBoneBorderRadius:
          TextBoneBorderRadius.fromHeightFactor(textBoneBorderRadius ?? 0.5),
      child: child);
}
