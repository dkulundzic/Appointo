import ProjectDescription
import ProjectDescriptionHelpers

enum Framework: String, ProjectDescriptionHelpers.Framework, CaseIterable {
    case core
    case model
    case localization

    func resources(
        appName: String
    ) -> ProjectDescription.ResourceFileElements? {
        switch self {
        case .core, .model:
            return nil
        case .localization:
            return .resources([
                "\(appName)/Targets/\(name(appName: appName))/Resources/**"
            ])
        }
    }
}

let appName = "Appointo"
let organizationName = "com.codeopolis"

let project = Project.app(
    name: appName,
    organizationName: organizationName,
    destinations: .iOS,
    additionalTargets: Framework.allCases
)
