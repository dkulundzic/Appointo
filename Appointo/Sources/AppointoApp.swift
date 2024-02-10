import UIKit

class AppointoApp: NSObject, UISceneDelegate {
    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard
            let windowScene = scene as? UIWindowScene
        else {
            return
        }

        let window = UIWindow(
            windowScene: windowScene
        )
    }
}
