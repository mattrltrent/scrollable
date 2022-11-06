import 'package:flutter/material.dart';

class KeyboardDismiss extends StatefulWidget {
  const KeyboardDismiss({
    super.key,
    required this.child,
    this.closeKeyboardOnTap = true,
    this.bubbleUpScrollNotifications = true,
  });

  /// This widget's child.
  final Widget child;

  /// Whether the widget should bubble up scroll notifications, or block them.
  final bool bubbleUpScrollNotifications;

  /// If the keyboard should also be closed just on the widget being tapped.
  final bool closeKeyboardOnTap;

  @override
  State<KeyboardDismiss> createState() => _KeyboardDismissState();
}

class _KeyboardDismissState extends State<KeyboardDismiss> {
  ScrollNotification? _lastScrollNotification;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => widget.closeKeyboardOnTap ? FocusScope.of(context).unfocus() : null,
      child: NotificationListener<ScrollNotification>(
        onNotification: (notification) {
          if (notification is UserScrollNotification &&
              (_lastScrollNotification == null || _lastScrollNotification is ScrollStartNotification)) {
            FocusScope.of(context).unfocus();
          }
          _lastScrollNotification = notification;
          return !widget.bubbleUpScrollNotifications;
        },
        child: widget.child,
      ),
    );
  }
}
