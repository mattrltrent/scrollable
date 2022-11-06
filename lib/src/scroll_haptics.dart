import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../types/enums.dart';

class ScrollHaptics extends StatefulWidget {
  const ScrollHaptics({
    super.key,
    required this.child,
    this.bubbleUpScrollNotifications = true,
    this.heavyHapticsAtEdgeEnabled = true,
    this.hapticEffectAtEdge,
    this.hapticEffectDuringScroll,
    this.distancebetweenHapticEffectsDuringScroll = 15,
  });

  /// This widget's child.
  final Widget child;

  /// Whether the widget should bubble up scroll notifications, or block them.
  final bool bubbleUpScrollNotifications;

  /// When a scroll reaches the edge, if there should be a haptic effect emitted.
  final bool heavyHapticsAtEdgeEnabled;

  /// Which kind of haptic effect should be emitted during the scroll.
  final HapticType? hapticEffectDuringScroll;

  /// Which kind of haptic effect should be emitted when the scroll edge is reached?
  final HapticType? hapticEffectAtEdge;

  /// The distance, in pixels, that should be scrolled before emitting a new haptic scroll effect.
  final double distancebetweenHapticEffectsDuringScroll;

  @override
  State<ScrollHaptics> createState() => _ScrollHapticsState();
}

class _ScrollHapticsState extends State<ScrollHaptics> {
  double _scrollDelta = 0.0;
  bool _alreadyVibratedForEdge = true;

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
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        if (notification.metrics.atEdge && !_alreadyVibratedForEdge && widget.heavyHapticsAtEdgeEnabled) {
          _alreadyVibratedForEdge = true;
          widget.hapticEffectAtEdge == null ? HapticFeedback.heavyImpact() : _hapticEffect(widget.hapticEffectAtEdge!);
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
      },
      child: widget.child,
    );
  }
}
