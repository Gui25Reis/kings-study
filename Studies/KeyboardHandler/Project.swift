import ProjectDescription

// MARK: - Constants

let appName = "KeyboardHandler"      // ← change per project
let bundlePrefix = "com.gui"
let deploymentTarget = "15.0"

// MARK: - Helpers

func appTarget() -> Target {
    .target(
        name: appName,
        destinations: .iOS,
        product: .app,
        bundleId: "\(bundlePrefix).\(appName.lowercased())",
        deploymentTargets: .iOS(deploymentTarget),
        infoPlist: .extendingDefault(with: [
            "UILaunchStoryboardName": "LaunchScreen",
            "UIApplicationSceneManifest": .dictionary([
                "UIApplicationSupportsMultipleScenes": .boolean(false),
                "UISceneConfigurations": .dictionary([
                    "UIWindowSceneSessionRoleApplication": .array([
                        .dictionary([
                            "UISceneConfigurationName": .string("Default Configuration"),
                            "UISceneDelegateClassName": .string("$(PRODUCT_MODULE_NAME).SceneDelegate")
                        ])
                    ])
                ])
            ])
        ]),
        sources: ["iOSApp/Sources/**"],
        resources: ["iOSApp/Resources/**"]
    )
}

func appTestTarget() -> Target {
    .target(
        name: "\(appName)Tests",
        destinations: .iOS,
        product: .unitTests,
        bundleId: "\(bundlePrefix).\(appName.lowercased()).tests",
        deploymentTargets: .iOS(deploymentTarget),
        sources: ["iOSApp/Tests/**"],
        dependencies: [.target(name: appName)]
    )
}

func moduleTarget(name: String, dependencies: [TargetDependency] = []) -> Target {
    .target(
        name: name,
        destinations: .iOS,
        product: .staticFramework,
        bundleId: "\(bundlePrefix).\(name.lowercased())",
        deploymentTargets: .iOS(deploymentTarget),
        sources: ["Modules/\(name)/Sources/**"],
        dependencies: dependencies
    )
}

// MARK: - Project

let project = Project(
    name: appName,
    organizationName: "Gui",
    targets: [
        appTarget(),
        appTestTarget()
        // Add module targets here when needed:
        // moduleTarget(name: "DesignSystem")
    ]
)
