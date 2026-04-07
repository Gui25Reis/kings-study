# Exercise Pattern (Swift)

This document describes the exact pattern used to create a new exercise in any Swift project in this repository. The pattern is the same across all sites (URI, LeetCode, HackerRank, etc.) — examples below use URI as reference since it was the first site configured.

---

## Overview

Each exercise consists of exactly **two files**:

| File | Location | Purpose |
|---|---|---|
| `NNNN.swift` | `Application/Sources/Exercises/` | Exercise implementation |
| `UriNNNNTests.swift` | `Application/Tests/` | Unit tests |

Where `NNNN` is the exercise number (or a meaningful identifier for sites that use slugs instead of numbers).

> **Why `Uri` prefix on test classes?** Swift class names cannot start with a digit, so a prefix is required. `Uri` was chosen to be meaningful and consistent with the site name. For other sites, the prefix should match the site name (e.g., `HackerRank1001Tests`, `Leetcode1001Tests`).

---

## InputProvider: The Core Abstraction

Located at `Application/Sources/Aux/Providers/InputProvider.swift`.

This protocol abstracts all I/O so that the same exercise function can run in production (reading from stdin, printing to stdout) and in tests (reading from a mock array, capturing output).

```swift
protocol InputProvider: AnyObject {
    var shouldConsidereNextLineForEachPrint: Bool { get set }
    func readLine() -> String?
    func print(_ data: String)
}
```

### DefaultInputProvider

Used at runtime (CommandLine target). Delegates directly to `Swift.readLine()` and `Swift.print()`.

### MockInputProvider

Used in tests. Receives a `[String]` array of inputs at init time. Reads them sequentially via an internal index. Captures printed output in `dataPrinted: String?`.

**Critical behavior of `dataPrinted`:**

- By default (`shouldConsidereNextLineForEachPrint = false`): only the **last** call to `print()` is stored. Each call **overwrites** `dataPrinted`.
- When `shouldConsidereNextLineForEachPrint = true`: each `print()` call **appends** to `dataPrinted` with a `\n` separator.

This flag must be set **before** calling the exercise function in tests that expect multi-line output.

```swift
// Single-line output exercise (default behavior)
let provider = MockInputProvider(inputs: ["10", "9"])
ex1001(input: provider)
// provider.dataPrinted == "X = 19"

// Multi-line output exercise
let provider = MockInputProvider(inputs: [...])
provider.shouldConsidereNextLineForEachPrint = true
ex1021(input: provider)
// provider.dataPrinted == "line1\nline2\nline3"
```

---

## Exercise File Pattern

**File:** `Application/Sources/Exercises/NNNN.swift`

```swift
//
//  Gui Reis  -  gui.sreis25@gmail.com - DD/MM/YY.
//

/**
 [Problem description copied from the site]

 Entrada
 [Input description]

 Saída
 [Output description]

 link: [URL to the problem]
 */


// MARK: - Exercício

func exNNNN(input: InputProvider = DefaultInputProvider()) {
    // Read inputs using input.readLine()
    // Process
    // Output using input.print()
}
```

### Rules for the exercise function

- Function name: `ex` + exercise number, e.g., `ex1001`, `ex1028`
- Always has `input: InputProvider = DefaultInputProvider()` as its only parameter
- Use `input.readLine()!` (or with guard/if let) to read values — never `Swift.readLine()` directly
- Use `input.print(...)` to output — never `Swift.print()` directly
- No `public` modifier needed (both targets compile the same sources directly)
- The docstring at the top should contain the full problem statement for context

### Real example (exercise 1001)

```swift
func ex1001(input: InputProvider = DefaultInputProvider()) {
    let userInputA = input.readLine()!
    let A = Int(userInputA)!

    let userInputB = input.readLine()!
    let B = Int(userInputB)!

    let X = A + B

    input.print("X = \(X)")
}
```

---

## Test File Pattern

**File:** `Application/Tests/UriNNNNTests.swift`

```swift
//
//  Gui Reis  -  gui.sreis25@gmail.com - DD/MM/YY
//

import XCTest


final class UriNNNNTests: XCTestCase {

    var inputs: [String]! = .init()


    /* Ciclo de Vida */
    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        inputs = nil
        super.tearDown()
    }


    /* Aux */
    private func validate(expected: String) {
        // Prepare
        let provider = MockInputProvider(inputs: inputs)

        // Action
        exNNNN(input: provider)

        // Validation
        XCTAssertEqual(expected, provider.dataPrinted)
    }


    /* Testes */
    func test_01() {
        // Prepare
        let expected = "..."
        inputs = ["..."]

        // Action
        validate(expected: expected)
    }
}
```

### Rules for the test file

- Class name: `Uri` + exercise number + `Tests`, e.g., `Uri1001Tests` — **never use a digit as the first character of a class name in Swift**
- `var inputs: [String]! = .init()` — always declared this way, reset to `nil` in `tearDown`
- The `validate(expected:)` helper is always private and always follows the same Prepare / Action / Validation structure
- **No `import` statement for the site framework** — tests compile the sources directly, so exercise functions are available without import
- Only `import XCTest` is needed
- Each test method is named `test_01`, `test_02`, etc.
- Use test cases from the problem's sample input/output section on the site

### Multi-line output variant of `validate`

When the exercise prints multiple lines, set the flag before calling the exercise:

```swift
private func validate(expected: String) {
    let provider = MockInputProvider(inputs: inputs)
    provider.shouldConsidereNextLineForEachPrint = true  // ← add this line
    exNNNN(input: provider)
    XCTAssertEqual(expected, provider.dataPrinted)
}
```

And the expected string uses `\n`:

```swift
func test_01() {
    let expected = "NOTA: 5.7\nAPROVADO"
    inputs = ["6.5", "5.0"]
    validate(expected: expected)
}
```

### Real example (exercise 1001)

```swift
final class Uri1001Tests: XCTestCase {

    var inputs: [String]! = .init()

    override func setUp() { super.setUp() }

    override func tearDown() {
        inputs = nil
        super.tearDown()
    }

    private func validate(expected: String) {
        let provider = MockInputProvider(inputs: inputs)
        ex1001(input: provider)
        XCTAssertEqual(expected, provider.dataPrinted)
    }

    func test_01() {
        let expected = "X = 19"
        inputs = ["10", "9"]
        validate(expected: expected)
    }

    func test_02() {
        let expected = "X = -6"
        inputs = ["-10", "4"]
        validate(expected: expected)
    }

    func test_03() {
        let expected = "X = 8"
        inputs = ["15", "-7"]
        validate(expected: expected)
    }
}
```

---

## Workflow: Adding a New Exercise

1. Open the site and find the exercise
2. Create `Application/Sources/Exercises/NNNN.swift` with the function stub
3. Implement the solution using `input.readLine()` and `input.print()`
4. Create `Application/Tests/<SiteName>NNNNTests.swift` with test cases from the problem's sample section
5. Run tests from Xcode or via CLI:
   ```bash
   xcodebuild -workspace <SiteName>.xcworkspace \
              -scheme <SiteName> \
              -destination 'platform=macOS' \
              -only-testing:<SiteName>Tests \
              test
   ```
6. No `tuist generate` needed when adding new files — Tuist uses glob patterns so new files are picked up automatically on the next build

---

## Adapting the Pattern per Site

### Sites with numeric IDs (URI, HackerRank)

Same pattern — use the number as file name and function name.

### Sites with slug-based IDs (LeetCode)

Adapt the naming:
- File: `two-sum.swift`
- Function: `exTwoSum(input:)` or use a descriptive name
- Test class: `LeetcodeTwoSumTests` (use the site name as prefix)

The `InputProvider` pattern still applies if the problem reads from stdin. For LeetCode-style problems that receive function parameters directly (no stdin), `InputProvider` may not be necessary — the function can take direct parameters and return a value instead. In that case, the test file still follows the same `XCTestCase` structure but calls the function directly without `validate(expected:)`.

---

## main.swift

The `main.swift` file is the CommandLine entry point. It is **not compiled into the test target** (excluded via Tuist glob). Its purpose is to manually invoke exercises during development. Typical content:

```swift
// Invoke the exercise you're currently working on
ex1024()
```

Keep it minimal. It is not meant to be a router for all exercises.
