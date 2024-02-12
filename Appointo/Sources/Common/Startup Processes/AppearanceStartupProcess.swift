import UIKit
import AppointoCore

struct AppearanceStartupProcess: StartupProcess {
    private let window: UIWindow?

    init(
        window: UIWindow?
    ) {
        self.window = window
    }

    func run() {
        setUpWindow()
        setUpNavigationBarAppearance()
    }
}

private extension AppearanceStartupProcess {
    func setUpWindow() {
        window?.tintColor = AppointoAsset.Colors.accentColor.color
    }

    func setUpNavigationBarAppearance() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .white
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
