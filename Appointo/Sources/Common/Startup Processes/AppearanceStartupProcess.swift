import UIKit
import AppointoCore

struct AppearanceStartupProcess: StartupProcess {
    func run() {
        setUpNavigationBarAppearance()
    }
}

private extension AppearanceStartupProcess {
    func setUpNavigationBarAppearance() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .white
        appearance.titleTextAttributes = [
            .font: UIFont.preferredFont(
                forTextStyle: .title2
            )
        ]
        appearance.largeTitleTextAttributes = [
            .font: UIFont.preferredFont(
                forTextStyle: .largeTitle
            )
        ]

        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
}
