import ProjectDescription
import ProjectDescriptionHelpers

let appName = "Appointo"
let organizationName = "com.codeopolis"

let project = Project.app(
    name: appName,
    organizationName: organizationName,
    destinations: .iOS,
    additionalTargets: Framework.allCases
)
