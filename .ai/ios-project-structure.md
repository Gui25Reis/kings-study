# iOS Project Structure (Swift-Project Template)

This document describes the Tuist setup for iOS app projects in this repository — used for studies and POCs under `Studies/`. It is a separate template from `Swift-Exercise`, which is for command-line exercise projects.

---

## Context

Studies are isolated iOS projects, each focused on a specific topic or technique. They live under `Studies/<ProjectName>/` and are bootstrapped from the `Templates/Swift-Project/` template via a bash script.

---

## Bootstrapping a New Project

```bash
cd Templates/Swift-Project
./new-project.sh <ProjectName>
```

This creates `Studies/<ProjectName>/` from `Template.zip`, replacing all occurrences of `"Template"` with the project name in Swift files. Then:

```bash
cd Studies/<ProjectName>
tuist generate --no-open
```

---

## Project Structure (per study)

```
Studies/<ProjectName>/
├── Tuist.swift
├── Project.swift
├── iOSApp/
│   ├── Sources/
│   │   ├── Application/
│   │   │   ├── AppDelegate.swift
│   │   │   └── SceneDelegate.swift     ← programmatic, sets rootViewController
│   │   └── Scenes/
│   │       ├── Launch/
│   │       │   └── Base.lproj/
│   │       │       └── LaunchScreen.storyboard
│   │       └── Main/
│   │           ├── MainController.swift
│   │           └── MainScreen.swift    ← optional, ViewCode UI
│   ├── Resources/
│   │   └── Assets.xcassets/
│   └── Tests/
│       └── dummy.swift                 ← placeholder, replace with real tests
└── Modules/
    └── dummy.txt                       ← instructions for adding a module
```

---

## Tuist Targets

Two targets by default. Modules can be added when needed.

### 1. App Target (`<ProjectName>`)

- Product: `.app`
- Sources: `iOSApp/Sources/**`
- Resources: `iOSApp/Resources/**`
- InfoPlist: extended default with `UILaunchStoryboardName` and scene manifest

### 2. Test Target (`<ProjectName>Tests`)

- Product: `.unitTests`
- Sources: `iOSApp/Tests/**`
- Dependencies: `[.target(name: appName)]`

### 3. Module Target (optional, add as needed)

```swift
moduleTarget(name: "DesignSystem")
```

- Product: `.staticFramework`
- Sources: `Modules/<Name>/Sources/**`
- Add `.target(name: "<Name>")` to the app's dependencies
- See `Modules/dummy.txt` for step-by-step instructions

---

## Key Conventions

**No storyboards for app UI.** The `LaunchScreen.storyboard` is the only storyboard — it's the launch screen, not the app's UI. All screens use ViewCode.

**SceneDelegate sets the root programmatically:**

```swift
window = UIWindow(windowScene: windowScene)
window?.rootViewController = MainController()
window?.makeKeyAndVisible()
```

**Screen/Controller split (when UI is non-trivial):**
- `MainScreen.swift` — `UIView` subclass, owns all UI elements and constraints
- `MainController.swift` — `UIViewController`, owns business logic and actions, sets `view = screen` in `loadView()`

This pattern is visible in both `KeyboardHandler` and `PhoneMasks` studies.

---

## Tuist.swift

```swift
import ProjectDescription

let tuist = Tuist(
    project: .tuist(
        compatibleXcodeVersions: .upToNextMajor("26"),
        swiftVersion: "5.10"
    )
)
```

---

## Project.swift

```swift
import ProjectDescription

let appName = "Template"      // ← change per project
let bundlePrefix = "com.gui"
let deploymentTarget = "15.0"

func appTarget() -> Target { ... }
func appTestTarget() -> Target { ... }
func moduleTarget(name: String, dependencies: [TargetDependency] = []) -> Target { ... }

let project = Project(
    name: appName,
    organizationName: "Gui",
    targets: [
        appTarget(),
        appTestTarget()
        // moduleTarget(name: "DesignSystem")
    ]
)
```

---

## Gitignore

Same rules as the exercise template — generated files are not committed:

```
Derived/
*.xcodeproj/
*.xcworkspace/
```

---

## Existing Studies

| Project | Status | Topic |
|---|---|---|
| `KeyboardHandler` | Partial | Generic handler to move any UIView with the keyboard |
| `PhoneMasks` | Functional | Protocol-based phone input mask |

See each project's `README.md` for usage examples and context.
