# Keyboard Handler

![Status](https://img.shields.io/badge/Status-Partial-yellow?style=flat-square) ![Swift](https://img.shields.io/badge/Swift-FA7343?style=flat-square&logo=swift&logoColor=white)

A generic keyboard handler that makes any view follow the keyboard on screen — not just text fields, but any UIView passed as reference.

### Context

This study came up during my time at iOS Lab, while I was teaching students. One of the common pain points was dealing with the keyboard covering UI elements. Instead of solving it the usual way (scroll views, fixed offsets), I got curious about building something more generic — a handler you could attach to any view, on any screen, without repeating the same logic everywhere.

## How it Works

`KeyboardHandler` is initialized with a `UITextField` that acts as the trigger — when it becomes active, the keyboard appears and the associated view moves up. Any `UIView` can be passed as `keyboardView` to define what actually moves, making it independent of the field itself.

It uses `NotificationCenter` to observe `keyboardWillShowNotification`, calculates how many points the view needs to move to stay visible above the keyboard, and animates it. A `UITapGestureRecognizer` on the `baseView` handles dismissal.

The partial status reflects that the current implementation covers the main case but has edge cases — particularly around views that are already near the bottom of the screen or inside scroll views. An adjusted version was used in production at Novibet.

### Usage Example

```swift
class MyController: UIViewController {

    private var keyboardHandler: KeyboardHandler?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupKeyboardHandler()
    }

    private func setupKeyboardHandler() {
        keyboardHandler = KeyboardHandler(textField: myTextField) // trigger field
        keyboardHandler?.keyboardView = myTextField               // view that moves (defaults to the field itself)
        keyboardHandler?.baseView = view                          // tap to dismiss
        keyboardHandler?.spaceBetweenKeyboard = 40               // optional spacing
    }
}
```

`keyboardView` can be set to any `UIView` — useful when you want a container or a different element to move instead of the field.
