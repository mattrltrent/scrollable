import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';

import '../types/enums.dart';

class ScrollableView extends StatefulWidget {
  const ScrollableView({
    Key? key,
    required this.controller,
    required this.child,
    this.bubbleUpScrollNotifications = true,
    this.closeKeyboardOnScroll = true,
    this.closeKeyboardOnTap = true,
    this.physics = const ClampingScrollPhysics(),
    this.scrollDirection = Axis.vertical,
    this.inlineBottomOrRightPadding = 0.0,
    this.inlineTopOrLeftPadding = 0.0,
    this.padding,
    this.hapticsEnabled = true,
    this.distancebetweenHapticEffectsDuringScroll = 15,
    this.heavyHapticsAtEdgeEnabled = true,
    this.hapticEffectAtEdge,
    this.hapticEffectDuringScroll,
    this.primary,
    this.dragStartBehavior,
    this.restorationId,
    this.scrollBarVisible = true,
    this.reverse = false,
    this.closeKeyboardOnVerticalSwipe = true,
  })  : assert(distancebetweenHapticEffectsDuringScroll >= 0),
        super(key: key);

  /// A [ScrollController] to manage the scrolling of the widget.
  final ScrollController controller;

  /// This widget's child.
  final Widget child;

  /// Whether the widget should bubble up scroll notifications, or block them.
  final bool bubbleUpScrollNotifications;

  /// Whether the keyboard should be automatically closed on the widget being scrolled.
  final bool closeKeyboardOnScroll;

  /// If the keyboard should also be closed just on the widget being tapped.
  final bool closeKeyboardOnTap;

  /// Physics of the scroll view.
  ///
  /// Highly reccomended to use [ClampingScrollPhysics] as it works best with haptics.
  final ScrollPhysics? physics;

  /// Direction of the scroll.
  final Axis scrollDirection;

  /// Inline padding of the scroll view.
  ///
  /// This is a clean substitute to having to add SizedBox widgets inside your scroll view.
  /// For the top (if vertical) or left (if horizontal) of the scroll view.
  final double inlineTopOrLeftPadding;

  /// Inline padding of the scroll view.
  ///
  /// This is a clean substitute to having to add SizedBox widgets inside your scroll view.
  /// For the bottom (if vertical) or right (if horizontal) of the scroll view.
  final double inlineBottomOrRightPadding;

  /// Outer padding of the widget.
  final EdgeInsetsGeometry? padding;

  /// If haptics should be enabled.
  final bool hapticsEnabled;

  /// The distance, in pixels, that should be scrolled before emitting a new haptic scroll effect.
  final double distancebetweenHapticEffectsDuringScroll;

  /// If the haptics when the edge of the scroll is reached should be enabled or not.
  final bool heavyHapticsAtEdgeEnabled;

  /// Which kind of haptic effect should be emitted during the scroll.
  final HapticType? hapticEffectDuringScroll;

  /// Which kind of haptic effect should be emitted when the scroll edge is reached?
  final HapticType? hapticEffectAtEdge;

  /// If the scroll bar should be visible.
  final bool scrollBarVisible;

  /// Whether this is the primary scroll view associated with the parent [PrimaryScrollController].
  final bool? primary;

  /// Determines the way that drag start behavior is handled.
  final DragStartBehavior? dragStartBehavior;

  /// Restoration ID to save and restore the scroll offset of the scrollable.
  final String? restorationId;

  /// Whether the scroll view scrolls in the reading direction.
  final bool reverse;

  /// If the keyboard should be closed when a vertical swipe occurs.
  final bool closeKeyboardOnVerticalSwipe;

  @override
  State<ScrollableView> createState() => _ScrollableViewState();
}

class _ScrollableViewState extends State<ScrollableView> {
  ScrollNotification? _lastScrollNotification;
  double _scrollDelta = 0.0;
  bool _alreadyVibratedForEdge = true;
  bool _alreadyDismissedThisDrag = false;

  void _hapticEffect(HapticType hapticType) {
    switch (hapticType) {
      case HapticType.light:
        HapticFeedback.lightImpact();
        break;
      case HapticType.medium:
        HapticFeedback.mediumImpact();
        break;
      case HapticType.heavy:
        HapticFeedback.heavyImpact();
        break;
      case HapticType.selection:
        HapticFeedback.selectionClick();
        break;
      case HapticType.vibration:
        HapticFeedback.vibrate();
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onVerticalDragStart: (_) {
        if (!_alreadyDismissedThisDrag && widget.closeKeyboardOnVerticalSwipe)
          FocusScope.of(context).unfocus();
      },
      onVerticalDragUpdate: (_) => _alreadyDismissedThisDrag = true,
      onVerticalDragEnd: (_) => _alreadyDismissedThisDrag = false,
      behavior: HitTestBehavior.translucent,
      onTap: () {
        if (widget.closeKeyboardOnTap) {
          FocusScope.of(context).unfocus();
        }
      },
      child: Padding(
        padding: widget.padding ?? const EdgeInsets.all(0),
        child: NotificationListener<ScrollNotification>(
          onNotification: (notification) {
            if (widget.closeKeyboardOnScroll) {
              if (notification is UserScrollNotification &&
                  (_lastScrollNotification == null ||
                      _lastScrollNotification is ScrollStartNotification)) {
                FocusScope.of(context).unfocus();
              }
              _lastScrollNotification = notification;
            }
            if (widget.hapticsEnabled) {
              if (notification.metrics.atEdge &&
                  !_alreadyVibratedForEdge &&
                  widget.heavyHapticsAtEdgeEnabled) {
                _alreadyVibratedForEdge = true;
                widget.hapticEffectAtEdge == null
                    ? HapticFeedback.heavyImpact()
                    : _hapticEffect(widget.hapticEffectAtEdge!);
                return !widget.bubbleUpScrollNotifications;
              }
              if (notification is! ScrollUpdateNotification) return true;
              _alreadyVibratedForEdge = false;
              if ((_scrollDelta - notification.metrics.extentBefore).abs() >
                  widget.distancebetweenHapticEffectsDuringScroll) {
                _scrollDelta = notification.metrics.extentBefore;
                widget.hapticEffectDuringScroll == null
                    ? HapticFeedback.selectionClick()
                    : _hapticEffect(widget.hapticEffectDuringScroll!);
                return !widget.bubbleUpScrollNotifications;
              }
              return !widget.bubbleUpScrollNotifications;
            }
            return !widget.bubbleUpScrollNotifications;
          },
          child: CupertinoScrollbar(
            thickness: widget.scrollBarVisible ? 3.0 : 0.0,
            controller: widget.controller,
            child: SingleChildScrollView(
              reverse: widget.reverse,
              primary: widget.primary,
              dragStartBehavior:
                  widget.dragStartBehavior ?? DragStartBehavior.start,
              restorationId: widget.restorationId,
              scrollDirection: widget.scrollDirection,
              physics: widget.physics,
              controller: widget.controller,
              child: widget.scrollDirection == Axis.horizontal
                  ? Row(
                      children: [
                        SizedBox(width: widget.inlineTopOrLeftPadding),
                        widget.child,
                        SizedBox(width: widget.inlineBottomOrRightPadding),
                      ],
                    )
                  : Column(
                      children: [
                        SizedBox(height: widget.inlineTopOrLeftPadding),
                        widget.child,
                        SizedBox(height: widget.inlineBottomOrRightPadding),
                      ],
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
