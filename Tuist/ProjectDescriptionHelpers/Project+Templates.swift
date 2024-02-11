import ProjectDescription

public protocol Framework {
    var hasResources: Bool { get }
    var isTestable: Bool { get }
    var dependencies: [TargetDependency] { get }

    func name(
        appName: String
    ) -> String

    func resources(
        appName: String
    ) -> ProjectDescription.ResourceFileElements?
}

public extension Framework {
    var hasResources: Bool { false }

    var isTestable: Bool { false }

    var frameworkDependencies: [Self] { [] }

    func resources(
        appName: String
    ) -> ProjectDescription.ResourceFileElements? {
        hasResources ? .resources([
            "\(appName)/Targets/\(name(appName: appName))/Resources/**"
        ]) : nil
    }
}

public extension Framework where Self: RawRepresentable, RawValue == String {
    func name(
        appName: String
    ) -> String {
        "\(appName)\(rawValue.capitalized)"
    }
}

public extension Project {
    /// Helper function to create the Project for this ExampleApp
    static func app(
        name: String,
        organizationName: String,
        destinations: Destinations,
        additionalTargets: [Framework]
    ) -> Project {
        let appDependencies: [TargetDependency] = [
            [
                .external(name: "SnapKit"),
                .external(name: "ComposableArchitecture")
            ],
            additionalTargets
                .map {
                    TargetDependency.target(
                        name: $0.name(
                            appName: name
                        )
                    )
                }
        ].flatMap { $0 }

        var targets = makeAppTargets(
            name: name,
            organizationName: organizationName,
            destinations: destinations,
            dependencies: appDependencies
        )

        targets += additionalTargets.flatMap {
            makeFrameworkTargets(
                framework: $0,
                appName: name,
                organizationName: organizationName,
                destinations: destinations
            )
        }

        return Project(
            name: name,
            organizationName: organizationName,
            targets: targets
        )
    }

    // MARK: - Private

    /// Helper function to create a framework target and an associated unit test target
    private static func makeFrameworkTargets(
        framework: Framework,
        appName: String,
        organizationName: String,
        destinations: Destinations
    ) -> [Target] {
        let name = framework.name(
            appName: appName
        )

        let sources: Target = .target(
            name: name,
            destinations: destinations,
            product: .framework,
            bundleId: "\(organizationName).\(name)",
            infoPlist: .default,
            sources: ["\(appName)/Targets/\(name)/Sources/**"],
            resources: framework.resources(
                appName: appName
            ),
            dependencies: framework.dependencies
        )


        let tests: Target? = framework.isTestable ? .target(
            name: "\(name)Tests",
            destinations: destinations,
            product: .unitTests,
            bundleId: "\(organizationName).\(name)Tests",
            infoPlist: .default,
            sources: ["\(appName)/Targets/\(name)/Tests/**"],
            resources: [],
            dependencies: [.target(name: name)]
        ) : nil

        return [sources, tests]
            .compactMap { $0 }
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
            sources: ["\(name)/Sources/**"],
            resources: ["\(name)/Resources/**"],
            scripts: [
                .post(
                    script: """
                            export PATH="$PATH:/opt/homebrew/bin"

                            if which swiftlint > /dev/null; then
                              swiftlint
                            else
                              echo "warning: SwiftLint not installed, download from https://github.com/realm/SwiftLint"
                            fi
                            """,
                    name: "SwiftLint",
                    basedOnDependencyAnalysis: false
                )
            ],
            dependencies: dependencies
        )

        let testTarget = Target.target(
            name: "\(name)Tests",
            destinations: destinations,
            product: .unitTests,
            bundleId: "\(organizationName).\(name)Tests",
            infoPlist: .default,
            sources: ["\(name)/Tests/**"],
            dependencies: [
                .target(name: "\(name)"),
            ]
        )
        return [mainTarget, testTarget]
    }
}
