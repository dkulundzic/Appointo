import ProjectDescription

public protocol FrameworkProtocol {
    var hasResources: Bool { get }
    var isTestable: Bool { get }

    func name(
        appName: String
    ) -> String

    func resources(
        appName: String
    ) -> [ResourceFileElement]

    func dependencies(
        appName: String
    ) -> [TargetDependency]
}

public extension FrameworkProtocol {
    var hasResources: Bool { false }

    var isTestable: Bool { false }

    var frameworkDependencies: [Self] { [] }

    func resources(
        appName: String
    ) -> [ResourceFileElement] {
        hasResources ? ["\(appName)/Targets/\(name(appName: appName))/Resources/**"] : []
    }
}

public extension FrameworkProtocol where Self: RawRepresentable, RawValue == String {
    func name(
        appName: String
    ) -> String {
        "\(appName)\(rawValue.capitalized)"
    }
}

public enum Framework: String, FrameworkProtocol, CaseIterable {
    case core
    case model
    case ui
    case localization

    public var hasResources: Bool {
        switch self {
        case .core, .model:
            return false
        case .ui, .localization:
            return true
        }
    }

    public var isTestable: Bool {
        switch self {
        case .core, .model, .localization:
            return true
        case .ui:
            return false
        }
    }

    public func dependencies(
        appName: String
    ) -> [TargetDependency] {
        switch self {
        case .core:
            return []
        case .model, .localization:
            return [
                .target(
                    name: Framework.core.name(appName: appName)
                )
            ]
        case .ui:
            return [
                .target(
                    name: Framework.core.name(appName: appName)
                ),
                .target(
                    name: Framework.localization.name(appName: appName)
                )
            ]
        }
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
            resources: .resources(
                framework.resources(
                    appName: appName
                )
            ),
            dependencies: framework.dependencies(
                appName: appName
            )
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

        let resources: ResourceFileElements = .resources(
            [
                ["\(name)/Resources/**"],
                Framework.ui.resources(appName: name)
            ].flatMap { $0 }
        )

        let mainTarget = Target.target(
            name: name,
            destinations: destinations,
            product: .app,
            bundleId: "\(organizationName).\(name)",
            infoPlist: .extendingDefault(with: infoPlist),
            sources: ["\(name)/Sources/**"],
            resources: resources,
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
