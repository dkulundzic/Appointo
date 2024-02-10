import ProjectDescription

let appName = "Appointo"
let organizationName = "com.codeopolis"

let project = Project(
    name: appName,
    targets: [
        .target(
            name: appName,
            destinations: .iOS,
            product: .app,
            bundleId: "\(organizationName).\(appName.lowercased())",
            infoPlist: .extendingDefault(
                with: [
                    "UIMainStoryboardFile": "",
                    "UILaunchStoryboardName": "LaunchScreen",
                ]
            ),
            sources: ["\(appName)/Sources/**"],
            resources: ["\(appName)/Resources/**"],
            dependencies: []
        ),
        .target(
            name: "\(appName)Tests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "\(organizationName).\(appName)Tests",
            infoPlist: .default,
            sources: ["\(appName)/Tests/**"],
            resources: [],
            dependencies: [.target(name: appName)]
        ),
        .target(
            name: "\(appName)Core",
            destinations: .iOS,
            product: .framework,
            bundleId: "\(organizationName).\(appName.lowercased()).core",
            sources: ["\(appName)/Targets/Core/Sources/**"]
        )
    ]
)

// MARK: - Helper

private extension Project {
    /// Helper function to create the Project for this ExampleApp
    static func app(
        name: String,
        organizationName: String,
        destinations: Destinations,
        additionalTargets: [String]
    ) -> Project {
        var targets = makeAppTargets(
            name: name,
            organizationName: organizationName,
            destinations: destinations,
            dependencies: additionalTargets.map {
                TargetDependency.target(
                    name: $0
                )
            }
        )

//        targets += additionalTargets.flatMap {
//            makeFrameworkTargets(
//                name: $0,
//                organizationName: organizationName,
//                destinations: destinations
//            )
//        }

        return Project(
            name: name,
            organizationName: organizationName,
            targets: []
        )
    }

    // MARK: - Private

    /// Helper function to create a framework target and an associated unit test target
    private static func makeFrameworkTargets(
        name: String,
        organizationName: String,
        destinations: Destinations
    ) -> [Target] {
        let sources: Target = .target(
            name: name,
            destinations: destinations,
            product: .framework,
            bundleId: "\(organizationName).\(name)",
            infoPlist: .default,
            sources: ["Targets/\(name)/Sources/**"],
            resources: [],
            dependencies: []
        )

        let tests: Target = .target(
            name: "\(name)Tests",
            destinations: destinations,
            product: .unitTests,
            bundleId: "\(organizationName).\(name)Tests",
            infoPlist: .default,
            sources: ["Targets/\(name)/Tests/**"],
            resources: [],
            dependencies: [.target(name: name)]
        )

        return [sources, tests]
    }

    /// Helper function to create the application target and the unit test target.
    private static func makeAppTargets(
        name: String,
        organizationName: String,
        destinations: Destinations,
        dependencies: [TargetDependency]
    ) -> [Target] {
        let infoPlist: [String: Plist.Value] = [
            "CFBundleShortVersionString": "1.0",
            "CFBundleVersion": "1",
            "UIMainStoryboardFile": "",
            "UILaunchStoryboardName": "LaunchScreen",
        ]

        let mainTarget = Target.target(
            name: name,
            destinations: destinations,
            product: .app,
            bundleId: "\(organizationName).\(name)",
            infoPlist: .extendingDefault(with: infoPlist),
            sources: ["Targets/\(name)/Sources/**"],
            resources: ["Targets/\(name)/Resources/**"],
            dependencies: dependencies
        )

        let testTarget = Target.target(
            name: "\(name)Tests",
            destinations: destinations,
            product: .unitTests,
            bundleId: "\(organizationName).\(name)Tests",
            infoPlist: .default,
            sources: ["Targets/\(name)/Tests/**"],
            dependencies: [
                .target(name: "\(name)"),
            ]
        )
        return [mainTarget, testTarget]
    }
}


