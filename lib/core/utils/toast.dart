import 'dart:async';
import 'package:flutter/material.dart';
import 'utils_import.dart';

void showToast(
  Widget child,
  BuildContext context, {
  Duration? duration,
}) {
  final overlay = Overlay.of(context);
  final entry = OverlayEntry(
    builder: (context) => Positioned(
      top: MediaQuery.of(context).padding.top + 10,
      left: Dimens.padding3xMedium,
      right: Dimens.padding3xMedium,
      child: Dismissible(
        direction: DismissDirection.up,
        key: UniqueKey(),
        child: child,
      ),
    ),
  );

  overlay.insert(entry);
  Timer(duration ?? const Duration(seconds: 3), () => entry.remove());
}
