import UIKit
import AppointoCore

@UIApplicationMain
class AppointoApp: NSObject, UIApplicationDelegate {
    var window: UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
    ) -> Bool {
        boostrap()

        return true
    }
}

private extension AppointoApp {
    func boostrap() {
        func setUpWindow() {
            let initialViewController = AppointmentListViewController(
                store: .init(
                    initialState: .init()
                ) { AppointmentListFeature() }
            )

            let navigationController = UINavigationController(
                rootViewController: initialViewController
            )
            navigationController.navigationBar.prefersLargeTitles = true

            window = UIWindow()
            window?.rootViewController = navigationController
            window?.makeKeyAndVisible()
        }

        func runStartupProcesses() {
            StartupProcessService()
                .run(AppearanceStartupProcess())
        }

        runStartupProcesses()
        setUpWindow()
    }
}
