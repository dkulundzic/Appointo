import UIKit

class AppointoScene: NSObject, UIWindowSceneDelegate {
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

        _ = UIWindow(
            windowScene: windowScene
        )
    }
}
