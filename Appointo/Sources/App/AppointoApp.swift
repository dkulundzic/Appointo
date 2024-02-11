import UIKit

@UIApplicationMain
class AppointoApp: NSObject, UIApplicationDelegate {
    var window: UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
    ) -> Bool {
        let initialViewController = AppointmentListViewController(
            store: .init(
                initialState: .init()
            ) { AppointmentListReducer() }
        )

        window = UIWindow()
        window?.rootViewController = UINavigationController(
            rootViewController: initialViewController
        )
        window?.makeKeyAndVisible()

        return true
    }
}
