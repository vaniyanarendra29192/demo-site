import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../core/utils/colors.dart';
import '../../core/utils/dimens.dart';
import '../../core/utils/styles.dart';
import '../widgets/svg_icon.dart';

class SwipeAction {
  const SwipeAction({
    required this.label,
    required this.icon,
    required this.backgroundColor,
    required this.onTap,
    this.isDisabled = false,
  });

  final String label;
  final String icon;
  final Color backgroundColor;
  final VoidCallback onTap;
  final bool isDisabled;
}

/// A generic swipeable list item that reveals actions on both swipe directions.
/// Place it inside a [ListView.builder] or any scroll view.
///
/// Example:
/// ```dart
/// SwipeActionItem(
///   leadingActions: [
///     SwipeAction(label: 'Repeat', icon: 'assets/icons/replay.svg', backgroundColor: AppColors.statusColorTextCyan, onTap: ...),
///   ],
///   trailingActions: [
///     SwipeAction(label: 'Delete', icon: 'assets/icons/delete.svg', backgroundColor: AppColors.statusColorTextRed, onTap: ...),
///   ],
///   child: MyCard(),
/// )
/// ```
class SwipeActionItem extends StatefulWidget {
  const SwipeActionItem({
    super.key,
    required this.child,
    this.leadingActions = const [],
    this.trailingActions = const [],
    this.actions = const [],
    this.actionButtonWidth = Dimens.tabBarHeight,
  });

  final Widget child;
  final List<SwipeAction> leadingActions;
  final List<SwipeAction> trailingActions;

  /// Backward compatibility for old API usage.
  final List<SwipeAction> actions;

  /// Width of each action button revealed on swipe.
  final double actionButtonWidth;

  @override
  State<SwipeActionItem> createState() => _SwipeActionItemState();
}

class _SwipeActionItemState extends State<SwipeActionItem>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late Animation<double> _offsetAnimation;
  late final VoidCallback _offsetAnimationListener;

  double _currentOffset = 0;
  double _dragStartX = 0;
  double _dragStartOffset = 0;

  List<SwipeAction> get _effectiveTrailingActions =>
      widget.trailingActions.isNotEmpty
          ? widget.trailingActions
          : widget.actions;

  double get _maxLeadingOffset =>
      widget.leadingActions.length * widget.actionButtonWidth;

  double get _maxTrailingOffset =>
      _effectiveTrailingActions.length * widget.actionButtonWidth;

  bool get _isOpen => _currentOffset != 0;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 220),
    );
    _offsetAnimation = AlwaysStoppedAnimation(0.0);
    _offsetAnimationListener =
        () => setState(() => _currentOffset = _offsetAnimation.value);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _animateTo(double target) {
    if (_currentOffset == target) return;
    _animationController.stop();
    _offsetAnimation.removeListener(_offsetAnimationListener);
    _offsetAnimation =
        Tween<double>(begin: _currentOffset, end: target).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    )..addListener(_offsetAnimationListener);
    _animationController.forward(from: 0.0);
  }

  void _close() {
    _animateTo(0);
  }

  void _onHorizontalDragStart(DragStartDetails details) {
    _dragStartX = details.localPosition.dx;
    _dragStartOffset = _currentOffset;
    if (_animationController.isAnimating) {
      _animationController.stop();
    }
  }

  void _onHorizontalDragUpdate(DragUpdateDetails details) {
    final delta = details.localPosition.dx - _dragStartX;
    final raw = _dragStartOffset + delta;
    final clamped = raw.clamp(-_maxTrailingOffset, _maxLeadingOffset);
    if (_currentOffset != clamped) {
      setState(() => _currentOffset = clamped);
    }
  }

  void _onHorizontalDragEnd(DragEndDetails details) {
    final velocityX = details.velocity.pixelsPerSecond.dx;

    if (_currentOffset > 0) {
      final shouldOpen =
          velocityX > 300 || _currentOffset >= (_maxLeadingOffset / 2);
      _animateTo(shouldOpen ? _maxLeadingOffset : 0);
      return;
    }

    if (_currentOffset < 0) {
      final shouldOpen =
          velocityX < -300 || _currentOffset.abs() >= (_maxTrailingOffset / 2);
      _animateTo(shouldOpen ? -_maxTrailingOffset : 0);
      return;
    }

    _animateTo(0);
  }

  @override
  Widget build(_) => LayoutBuilder(
        builder: (_, constraints) {
          final width = constraints.maxWidth;
          final showLeadingPanel = _maxLeadingOffset > 0 && _currentOffset > 0;
          final showTrailingPanel =
              _maxTrailingOffset > 0 && _currentOffset < 0;
          const cornerRadius = Dimens.radius2xSmall;
          return GestureDetector(
            onHorizontalDragStart: _onHorizontalDragStart,
            onHorizontalDragUpdate: _onHorizontalDragUpdate,
            onHorizontalDragEnd: _onHorizontalDragEnd,
            onTap: _isOpen ? _close : null,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(cornerRadius),
              child: Stack(
                clipBehavior: Clip.hardEdge,
                alignment: Alignment.centerLeft,
                children: [
                  const Positioned.fill(
                    child: ColoredBox(color: AppColors.white),
                  ),
                  if (showLeadingPanel)
                    Positioned(
                      top: -cornerRadius,
                      bottom: -cornerRadius,
                      left: 0,
                      width: _maxLeadingOffset + cornerRadius,
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(cornerRadius),
                          bottomLeft: Radius.circular(cornerRadius),
                        ),
                        child: _SwipeActionsPanel(
                          actions: widget.leadingActions,
                          backgroundColor:
                              widget.leadingActions.first.backgroundColor,
                          onActionTap: (action) {
                            _close();
                            action.onTap();
                          },
                          onBackgroundTap: _close,
                        ),
                      ),
                    ),
                  if (showTrailingPanel)
                    Positioned(
                      top: -cornerRadius,
                      bottom: -cornerRadius,
                      right: 0,
                      width: _maxTrailingOffset + cornerRadius,
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(cornerRadius),
                          bottomRight: Radius.circular(cornerRadius),
                        ),
                        child: _SwipeActionsPanel(
                          actions: _effectiveTrailingActions,
                          backgroundColor:
                              _effectiveTrailingActions.first.backgroundColor,
                          onActionTap: (action) {
                            _close();
                            action.onTap();
                          },
                          onBackgroundTap: _close,
                        ),
                      ),
                    ),
                  Transform.translate(
                    offset: Offset(_currentOffset, 0),
                    child: IgnorePointer(
                      ignoring: _isOpen,
                      child: SizedBox(
                        width: width,
                        child: GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: _isOpen ? _close : null,
                          child: widget.child,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
}

class _SwipeActionButton extends StatelessWidget {
  const _SwipeActionButton({
    required this.action,
    required this.onTap,
  });

  final SwipeAction action;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: action.isDisabled ? null : onTap,
      behavior: HitTestBehavior.opaque,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AppSvgIcon(
            action.icon,
            color: AppColors.white,
            height: Dimens.space3xMedium,
            width: Dimens.space3xMedium,
          ),
          const Gap(Dimens.spaceXSmall),
          Text(
            action.label,
            style: AppFontTextStyles.textStyleBold().copyWith(
              color: AppColors.white,
              fontSize: Dimens.fontSizeFourteen,
            ),
          ),
        ],
      ),
    );
  }
}

class _SwipeActionsPanel extends StatelessWidget {
  const _SwipeActionsPanel({
    required this.actions,
    required this.backgroundColor,
    required this.onActionTap,
    required this.onBackgroundTap,
  });

  final List<SwipeAction> actions;
  final Color backgroundColor;
  final ValueChanged<SwipeAction> onActionTap;
  final VoidCallback onBackgroundTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onBackgroundTap,
      child: ColoredBox(
        color: backgroundColor,
        child: actions.length == 1
            ? SizedBox.expand(
                child: _SwipeActionButton(
                  action: actions.first,
                  onTap: () => onActionTap(actions.first),
                ),
              )
            : Column(
                children: [
                  for (var index = 0; index < actions.length; index++) ...[
                    if (index != 0)
                      Divider(
                        height: Dimens.spaceMin,
                        color: AppColors.white.withValues(alpha: 0.4),
                        indent: Dimens.spaceMedium,
                        endIndent: Dimens.spaceMedium,
                      ),
                    Expanded(
                      child: _SwipeActionButton(
                        action: actions[index],
                        onTap: () => onActionTap(actions[index]),
                      ),
                    ),
                  ],
                ],
              ),
      ),
    );
  }
}
