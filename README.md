# 🔥 A powerful set of scrollable widgets: haptics, keyboard dismissing, and more 🔥

- Submit an issue [here](https://github.com/mattrltrent/scrollable/issues).
- Create a pull request [here](https://github.com/mattrltrent/scrollable/pulls).
- Contact me via email [here](mailto:me@matthewtrent.me).

## 3 Widgets in this package 📚

#### 💥 `ScrollHaptics`

- Applies haptic feedback when its `child` is scrolled (during scroll & edge of scroll view).

#### 💥 `KeyboardDismiss`

- Dismisses the soft-keyboard when its `child` is scrolled, or tapped.

#### 💥 `ScrollableView`

- The above 2 widgets combined into 1 widget for ease-of-use.

## Example Gif 📸

_It's hard to display haptics in a gif, but they're there._

<img src="https://github.com/mattrltrent/scrollable/blob/main/resources/example.gif?raw=true" style="display: inline"/>

## Installing 🧑‍🏫

- Install the package from the pub.
  - `flutter pub add scrollable_view`
- Import the package.
  - `import 'package:scrollable/scrollable.dart';`

## Quick Start 💨

Simply wrap whatever you want inside the `ScrollHaptics`, `KeyboardDismiss`, or `ScrollableView` widget, then edit whatever of its many properties you want!

## Short Examples of the 3 Widgets 📜

_For a full example with context, view the examples tab. It shows just the `ScrollableView`, but it's the same layout for all 3 widgets._

<details>
<summary>Scroll Haptics</summary>

## **`ScrollHaptics`**

```dart
ScrollHaptics(
        // <Assorted Properties Here>
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(height: 100, width: 100, color: Colors.redAccent),
              Container(height: 100, width: 100, color: Colors.blue),
              Container(height: 100, width: 100, color: Colors.purple),
            ],
          ),
        ),
      );
```

</details>

<details>
<summary>Keyboard Dismiss</summary>

## **`KeyboardDismiss`**

```dart
KeyboardDismiss(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(height: 100, width: 100, color: Colors.redAccent),
              Container(height: 100, width: 100, color: Colors.blue),
              Container(height: 100, width: 100, color: Colors.purple),
            ],
          ),
        ),
      );
```

</details>

<details>
<summary>Scrollable View</summary>

## **`ScrollableView`**

```dart
ScrollableView(
        controller: ScrollController(),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(height: 100, width: 100, color: Colors.redAccent),
              Container(height: 100, width: 100, color: Colors.blue),
              Container(height: 100, width: 100, color: Colors.purple),
            ],
          ),
        ),
      );
```

</details>

## Properties of the 3 Widgets 📜

<details>
<summary>Scroll Haptics</summary>

## **`ScrollHaptics`**

**Highly reccomended to use `ClampingScrollPhysics` for the physics of whatever scrollable you're wrapping, as it works best with haptics.**

- `child` (required): This widget's child.
- `bubbleUpScrollNotifications`: Whether the widget should bubble up scroll notifications, or block them.
- `heavyHapticsAtEdgeEnabled`: When a scroll reaches the edge, if there should be a haptic effect emitted.
- `hapticEffectAtEdge`: Which kind of haptic effect should be emitted when the scroll edge is reached?
- `hapticEffectDuringScroll`: Which kind of haptic effect should be emitted during the scroll.
- `distancebetweenHapticEffectsDuringScroll`: The distance, in pixels, that should be scrolled before emitting a new haptic scroll effect.
</details>

<details>
<summary>Keyboard Dismiss</summary>

## **`Keyboard Dismiss`**

- `child` (required): This widget's child.
- `bubbleUpScrollNotifications`: Whether the widget should bubble up scroll notifications, or block them.
- `closeKeyboardOnTap`: If the keyboard should also be closed just on the widget being tapped.
</details>

<details>
<summary>Scrollable View</summary>

## **`ScrollableView`**

- `child` (required): This widget's child.
- `controller` (required): A `ScrollController` to manage the scrolling of the widget.
- `bubbleUpScrollNotifications`: Whether the widget should bubble up scroll notifications, or block them.
- `closeKeyboardOnScroll`: Whether the keyboard should be automatically closed on the widget being scrolled.
- `closeKeyboardOnTap`: If the keyboard should also be closed just on the widget being tapped.
- `physics`: Physics of the scroll view. **Highly reccomended to use `ClampingScrollPhysics` as it works best with haptics.**
- `scrollDirection`: Direction of the scroll.
- `inlineBottomOrRightPadding`: Inline padding of the scroll view. This is a clean substitute to having to add `SizedBox` widgets inside your scroll view. For the bottom (if vertical) or right (if horizontal) of the scroll view.
- `inlineTopOrLeftPadding`: Inline padding of the scroll view. This is a clean substitute to having to add `SizedBox` widgets inside your scroll view. For the top (if vertical) or left (if horizontal) of the scroll view.
- `padding`: Outer padding of the widget.
- `hapticsEnabled`: If haptics should be enabled.
- `distancebetweenHapticEffectsDuringScroll`: The distance, in pixels, that should be scrolled before emitting a new haptic scroll effect.
- `heavyHapticsAtEdgeEnabled`: If the haptics when the edge of the scroll is reached should be enabled or not.
- `hapticEffectAtEdge`: Which kind of haptic effect should be emitted when the scroll edge is reached?
- `hapticEffectDuringScroll`: Which kind of haptic effect should be emitted during the scroll.
- `primary`: Whether this is the primary scroll view associated with the parent `PrimaryScrollController`.
- `dragStartBehavior`: Determines the way that drag start behavior is handled.
- `restorationId`: Restoration ID to save and restore the scroll offset of the scrollable.
- `reverse`: Whether the scroll view scrolls in the reading direction.
</details>

## Additional Info 📣

- The package is always open to [improvements](https://github.com/mattrltrent/scrollable/issues), [suggestions](mailto:me@matthewtrent.me), and [additions](https://github.com/mattrltrent/scrollable/pulls)!

- I'll look through PRs and issues as soon as I can!

- [Learn about me](me@matthewtrent.me).
