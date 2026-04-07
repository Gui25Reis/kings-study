# Phone Masks

![Status](https://img.shields.io/badge/Status-Functional-brightgreen?style=flat-square) ![Swift](https://img.shields.io/badge/Swift-FA7343?style=flat-square&logo=swift&logoColor=white)

A flexible phone mask component for iOS, designed to support multiple mask types and formats through a protocol-based approach.

### Context

This came up as a real demand while I was at Santander. Instead of hardcoding a specific format, I wanted something where you could choose the mask type at runtime — making it reusable across different fields and regions without duplicating logic.

## How it Works

The `PhoneMaskType` protocol defines the contract: maximum allowed digits, the formatted result, and a `createPhoneMask` method. Each mask (e.g. `BRPhoneMask`) conforms to it and handles the formatting logic internally.

`PhoneParts` holds the decomposed phone number (area code, prefix, suffix) and uses memoization to avoid recomputing parts on every keystroke. The mask applies formatting as the user types via `UITextFieldDelegate`, assembling the final string from the cached parts.

This structure makes it straightforward to add new mask types — implement the protocol, define the format, and plug it in.

### Usage Example

```swift
class MyScreen: UIView {

    lazy var phoneMask = BRPhoneMask02()

    lazy var phoneField: UITextField = {
        let field = UITextField()
        field.delegate = phoneMask   // mask applies formatting via UITextFieldDelegate
        field.keyboardType = .numberPad
        field.placeholder = "Telefone"
        return field
    }()
}
```

To swap the mask type, replace `BRPhoneMask02()` with any other conforming type — no changes needed in the field or the controller.
