import 'package:flutter/material.dart';

class KeyboardDismiss extends StatefulWidget {
  const KeyboardDismiss({
    super.key,
    required this.child,
    this.closeKeyboardOnTap = true,
    this.bubbleUpScrollNotifications = true,
    this.closeKeyboardOnVerticalSwipe = true,
    this.onKeyboardDismissed,
  });

  /// This widget's child.
  final Widget child;

  /// A callback that's fired when a user dismisses they keyboard
  final VoidCallback? onKeyboardDismissed;

  /// Whether the widget should bubble up scroll notifications, or block them.
  final bool bubbleUpScrollNotifications;

  /// If the keyboard should also be closed just on the widget being tapped.
  final bool closeKeyboardOnTap;

  /// If the keyboard should be closed when a vertical swipe occurs.
  final bool closeKeyboardOnVerticalSwipe;

  @override
  State<KeyboardDismiss> createState() => _KeyboardDismissState();
}

class _KeyboardDismissState extends State<KeyboardDismiss> {
  ScrollNotification? _lastScrollNotification;
  bool _alreadyDismissedThisDrag = false;

  void onDismiss() {
    FocusScope.of(context).unfocus();
    if (widget.onKeyboardDismissed != null) {
      widget.onKeyboardDismissed!();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onVerticalDragStart: (_) {
        if (!_alreadyDismissedThisDrag && widget.closeKeyboardOnVerticalSwipe) {
          onDismiss();
        }
      },
      onVerticalDragUpdate: (_) => _alreadyDismissedThisDrag = true,
      onVerticalDragEnd: (_) => _alreadyDismissedThisDrag = false,
      behavior: HitTestBehavior.translucent,
      onTap: () {
        if (widget.closeKeyboardOnTap) {
          onDismiss();
        }
      },
      child: NotificationListener<ScrollNotification>(
        onNotification: (notification) {
          if (notification is UserScrollNotification &&
              (_lastScrollNotification == null || _lastScrollNotification is ScrollStartNotification)) {
            onDismiss();
          }
          _lastScrollNotification = notification;
          return !widget.bubbleUpScrollNotifications;
        },
        child: widget.child,
      ),
    );
  }
}
