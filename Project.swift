import ProjectDescription
import ProjectDescriptionHelpers

let appName = "Appointo"
let organizationName = "com.codeopolis"

enum Framework: String, ProjectDescriptionHelpers.Framework, CaseIterable {
    case core
    case model
    case ui
    case localization

    var hasResources: Bool {
        switch self {
        case .core, .model:
            return false
        case .ui, .localization:
            return true
        }
    }

    var isTestable: Bool {
        switch self {
        case .core, .model, .localization:
            return true
        case .ui:
            return false
        }
    }

    var dependencies: [TargetDependency] {
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

let project = Project.app(
    name: appName,
    organizationName: organizationName,
    destinations: .iOS,
    additionalTargets: Framework.allCases
)
